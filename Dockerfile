# Stage 1: Build environment
FROM alpine:latest AS builder
RUN apk add --no-cache \
    build-base \
    gcc \
    g++ \
    make

WORKDIR /home/optima
COPY . .

# Stage 2: Runtime environment  
FROM alpine:latest
RUN apk add --no-cache \
    libstdc++ \
    libc6-compat

WORKDIR /app
COPY --from=builder /home/optima/trig_function /app/

ENTRYPOINT ["./trig_function"]