FROM wagoodman/dive:v0.10.0

RUN apk add --upgrade bash

# RUN apk add --update --no-cache podman --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN mkdir /app

WORKDIR /app

ADD run.sh ./

ENTRYPOINT ["./run.sh"]

CMD ["images"]