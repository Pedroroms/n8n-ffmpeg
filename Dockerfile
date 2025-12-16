FROM n8nio/n8n:1.121.3

USER root

RUN apk add --no-cache \
  ffmpeg \
  python3 \
  py3-pip

USER node
