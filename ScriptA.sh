#!/bin/bash

readonly IMAGE="nikolaienkodmytro/httpserv:latest"
readonly CONTAINERS=("serviceX" "serviceY" "serviceZ")
declare -A CORE_ASSIGNMENTS=([serviceX]=0 [serviceY]=1 [serviceZ]=2)
declare -A CONTAINER_STATES=([serviceX]="required" [serviceY]="optional" [serviceZ]="optional")

log_message() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

check_container_status() {
    local container=$1
    if docker ps --format '{{.Names}}' | grep -q "$container"; then
        echo "running"
    elif docker ps -a --format '{{.Names}}' | grep -q "$container"; then
        echo "exists"
    else
        echo "none"
    fi
}

get_container_metrics() {
    local container=$1
    local attempts=2
    local total_cpu=0
    
    for ((i=1; i<=attempts; i++)); do
        local cpu=$(docker stats "$container" --no-stream --format "{{.CPUPerc}}" | sed 's/%//')
        total_cpu=$(echo "$total_cpu + $cpu" | bc -l)
        [[ $i -lt $attempts ]] && sleep 20
    done
    
    echo "$(echo "scale=2; $total_cpu / $attempts" | bc)"
}

manage_container() {
    local container=$1
    local action=$2
    
    case $action in
        "start")
            log_message "Starting $container on CPU ${CORE_ASSIGNMENTS[$container]}"
            docker run -d --name "$container" \
                         --cpuset-cpus="${CORE_ASSIGNMENTS[$container]}" \
                         "$IMAGE"
            sleep 10
            ;;
        "stop")
            log_message "Stopping $container"
            docker stop "$container" >/dev/null
            docker rm "$container" >/dev/null
            ;;
    esac
}

check_and_scale() {
    local status
    local cpu_usage
    
    for container in "${CONTAINERS[@]}"; do
        status=$(check_container_status "$container")
        
        case $container in
            "serviceX")
                [[ $status != "running" ]] && manage_container "$container" "start"
                ;;
            *)
                if [[ $status == "running" ]]; then
                    cpu_usage=$(get_container_metrics "$container")
                    if (( $(echo "$cpu_usage < 10" | bc -l) )); then
                        manage_container "$container" "stop"
                    fi
                fi
                ;;
        esac
    done
    
    # Check load and scale up if needed
    for ((i=0; i<${#CONTAINERS[@]}-1; i++)); do
        current=${CONTAINERS[$i]}
        next=${CONTAINERS[$i+1]}
        
        if [[ $(check_container_status "$current") == "running" ]]; then
            cpu_usage=$(get_container_metrics "$current")
            if (( $(echo "$cpu_usage > 80" | bc -l) )); then
                if [[ $(check_container_status "$next") != "running" ]]; then
                    log_message "$current is overloaded. Starting $next"
                    manage_container "$next" "start"
                fi
            fi
        fi
    done
}

update_containers() {
    if docker pull "$IMAGE" | grep -q 'Downloaded newer image'; then
        log_message "New image version detected. Updating containers..."
        for container in "${CONTAINERS[@]}"; do
            if [[ $(check_container_status "$container") == "running" ]]; then
                manage_container "$container" "stop"
                manage_container "$container" "start"
            fi
        done
    fi
}

main() {
    local last_update=0
    
    log_message "Starting container management service"
    while true; do
        check_and_scale
        
        current_time=$(date +%s)
        if (( current_time - last_update >= 600 )); then
            update_containers
            last_update=$current_time
        fi
        
        sleep 20
    done
}

main