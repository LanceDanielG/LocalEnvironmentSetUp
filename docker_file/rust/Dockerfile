FROM rust:1.81-slim

WORKDIR /var/www/html/api

RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    libssl-dev \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cargo install cargo-watch

COPY . .

EXPOSE 8080

CMD ["cargo", "watch", "-x", "run"]
