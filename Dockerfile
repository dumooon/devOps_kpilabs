FROM alpine:latest
WORKDIR /home/optima
COPY ./trig_function .
RUN apk add libstdc++
RUN apk add libc6-compat
ENTRYPOINT ["./trig_function"]