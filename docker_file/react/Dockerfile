FROM node:22.18-slim

WORKDIR /usr/src/app/ui

COPY package*.json ./

RUN npm ci --prefer-offline

EXPOSE 3000

CMD ["npm", "run", "dev"]
