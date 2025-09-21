FROM node:22.19.0-alpine

WORKDIR /usr/src/app/ui

COPY package*.json ./

RUN npm install -g @angular/cli && npm install

COPY . .

CMD ["npm", "start"]
