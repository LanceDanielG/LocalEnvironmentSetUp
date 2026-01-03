FROM oven/bun:1.1-slim

WORKDIR /var/www/html/api

COPY package.json bun.lockb ./
RUN bun install

COPY . .

EXPOSE 3000

CMD ["bun", "run", "index.ts"]
