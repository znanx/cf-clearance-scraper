FROM node:latest

ENV CHROME_BIN=/usr/bin/chromium \
  TZ=Asia/Jakarta \
  PORT=7860 \
  DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    chromium \
    chromium-driver \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app

RUN chmod -R 777 /app && \
  npm cache clean --force && \
  npm install

EXPOSE 3000
CMD ["node", "src/index.js"]
