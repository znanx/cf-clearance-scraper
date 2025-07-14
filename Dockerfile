FROM node:18-slim

# Install dependencies and Chromium
RUN apt-get update && apt-get install -y \
  chromium \
  chromium-driver \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium

WORKDIR /app

COPY package*.json ./

RUN npm install
RUN npm install -g pm2

COPY . .

EXPOSE 3000

CMD ["pm2-runtime", "src/index.js"]
