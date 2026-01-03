FROM node:22-slim

WORKDIR /usr/src/app/ui

COPY package.json package-lock.json* ./
RUN npm install

COPY . .

EXPOSE 4321

CMD ["npm", "run", "dev", "--", "--host"]
