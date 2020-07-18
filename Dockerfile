FROM alpine:3.12.0 AS builder 
RUN apk add build-base --no-cache
WORKDIR /home
COPY hello.c .
RUN gcc "-DARCH=\"`uname -a`\"" hello.c -o hello

LABEL   maintainer="Pascal Watteel" \
        name="hello-multiarch" \
        version="1.0"

FROM alpine:3.12.0 
WORKDIR /home
COPY --from=builder /home/hello .
ENTRYPOINT ["./hello"] 