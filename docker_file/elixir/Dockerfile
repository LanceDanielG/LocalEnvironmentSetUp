FROM elixir:1.17-slim

WORKDIR /var/www/html/api

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY . .

EXPOSE 4000

CMD ["mix", "phx.server"]
