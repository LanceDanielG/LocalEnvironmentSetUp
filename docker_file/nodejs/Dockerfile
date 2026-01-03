FROM node:22.18-slim

WORKDIR /var/www/html/api

COPY package*.json ./

RUN npm ci --prefer-offline

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
