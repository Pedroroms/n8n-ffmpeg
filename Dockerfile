ARG N8N_VERSION=1.95.3
FROM n8nio/n8n:${N8N_VERSION}

USER root

RUN apk add --no-cache \
  ffmpeg \
  python3 \
  py3-pip

USER node
