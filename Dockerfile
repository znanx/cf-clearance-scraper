FROM node:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
  wget \
  gnupg \
  ca-certificates \
  apt-transport-https \
  chromium \
  chromium-driver \
  xvfb \
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

# Set Chromium binary path for Puppeteer/Selenium/etc.
ENV CHROME_BIN=/usr/bin/chromium

# Set working directory
WORKDIR /app

# Copy package.json & install dependencies
COPY package*.json ./
RUN npm install

# Install PM2 globally
RUN npm install -g pm2

# Copy the rest of the app
COPY . .

# Expose port
EXPOSE 3000

# Start application with PM2
CMD ["pm2-runtime", "src/index.js"]
