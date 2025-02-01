FROM node:latest

RUN apt-get update && apt upgrade && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    chromium \
    chromium-driver \
    xvfb \
    libvpx7 \
    libasound2t64 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium

WORKDIR /app

COPY package*.json ./
RUN npm audit fix --force
RUN npm update
RUN npm install
RUN npm i -g pm2
COPY . .

EXPOSE 3000

CMD ["pm2-runtime", "src/index.js"]
