FROM alpine:3.7

RUN mkdir -p /usr/share/1337

ADD landing /usr/share/1337/landing
ADD statics /usr/share/1337/statics

EXPOSE 8080
EXPOSE 8090

VOLUME [ "/certs" ]

ENTRYPOINT [ "/usr/share/1337/landing", "-domain=1337.design", "-production=true" ]