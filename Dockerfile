FROM golang:alpine

RUN apk --no-cache add git  \
    && git clone https://github.com/du5/qb_tools /root/qb_tools\
    && cd /root/qb_tools \
    && go build .
FROM alpine:3

RUN apk --no-cache add tzdata

COPY --from=0 /root/qb_tools/qb_tools /usr/bin/qb_tools
COPY --from=0 /root/qb_tools/env.json /root/env.json

WORKDIR /root

ENTRYPOINT [ "qb_tools" ]