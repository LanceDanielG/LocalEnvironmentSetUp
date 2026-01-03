FROM openjdk:21-slim

WORKDIR /var/www/html/api

# Install Gradle or Maven if needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY . .

# Assume executable jar for standard deployments
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
