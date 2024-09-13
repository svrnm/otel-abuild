FROM alpine:edge as builder

RUN apk update && apk add alpine-sdk

RUN adduser builder -D

RUN adduser builder abuild

USER builder

WORKDIR /home/builder

COPY --chown=builder:abuild ./abuild ./.abuild
COPY *.patch .
COPY ./APKBUILD .

RUN abuild -r

FROM scratch as packages
COPY --from=builder /home/builder/packages/* .
