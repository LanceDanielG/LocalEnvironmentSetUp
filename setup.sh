#!/bin/bash
set -e

#Add error tracking variable
setup_error=false

SCRIPT_ROOT_NAME=$(basename "$PWD")
SCRIPT_ROOT_DIR=$PWD

cd ..

project_name=$(basename "$PWD")

for item in "$PWD"/*; do

    folder_name=$(basename "$item")

    if [ "$folder_name" = "$SCRIPT_ROOT_NAME" ] || { [ "$folder_name" != "api" ] && [ "$folder_name" != "ui" ]; }; then
        echo "Skipping setup in script root directory: $folder_name"
        continue
    fi
    
    if [ "$folder_name" = "api" ]; then
        cp -f $SCRIPT_ROOT_NAME/docker_file/laravel/Dockerfile ./api/Dockerfile
        continue
    fi

    if [ "$folder_name" = "ui" ]; then
        cp -f $SCRIPT_ROOT_NAME/docker_file/vue/Dockerfile ./ui/Dockerfile
        continue
    fi
done

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    setup_error=true
    exit 1
fi

echo "Docker is installed and running."

cp -f $SCRIPT_ROOT_NAME/compose_file/compose.yaml ./compose.yaml

docker compose up
