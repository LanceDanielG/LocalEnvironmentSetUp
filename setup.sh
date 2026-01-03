#!/usr/bin/env bash
set -e

# Usage: ./setup.sh PROJECT_NAME API_LANG UI_LANG [DB_TYPE]
# Example: ./setup.sh my-app laravel vue postgres

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 PROJECT_NAME API_LANG UI_LANG [DB_TYPE]"
    echo "Example: $0 my-app laravel vue postgres"
    exit 1
fi

PROJECT_NAME=$1
API_LANG=$2
UI_LANG=$3
DB_TYPE=${4:-none}

SCRIPT_ROOT_DIR=$(dirname "$(readlink -f "$0")")

if [ -d "$PROJECT_NAME" ]; then
    echo "Project '$PROJECT_NAME' already exists. Updating/using existing directory."
else
    echo "Creating project: $PROJECT_NAME"
    mkdir -p "$PROJECT_NAME"
fi

# Copy API Dockerfile
if [ "$API_LANG" != "none" ]; then
    mkdir -p "$PROJECT_NAME/api"
    if [ -d "$SCRIPT_ROOT_DIR/docker_file/$API_LANG" ]; then
        echo "Copying $API_LANG Dockerfile to $PROJECT_NAME/api/"
        cp -f "$SCRIPT_ROOT_DIR/docker_file/$API_LANG/Dockerfile" "$PROJECT_NAME/api/Dockerfile"
    else
        echo "Error: API language '$API_LANG' not supported (Dockerfile not found in docker_file/)."
        exit 1
    fi
fi

# Copy UI Dockerfile
if [ "$UI_LANG" != "none" ]; then
    mkdir -p "$PROJECT_NAME/ui"
    if [ -d "$SCRIPT_ROOT_DIR/docker_file/$UI_LANG" ]; then
        echo "Copying $UI_LANG Dockerfile to $PROJECT_NAME/ui/"
        cp -f "$SCRIPT_ROOT_DIR/docker_file/$UI_LANG/Dockerfile" "$PROJECT_NAME/ui/Dockerfile"
    else
        echo "Error: UI language '$UI_LANG' not supported (Dockerfile not found in docker_file/)."
        exit 1
    fi
fi

# Copy Nginx config
if [ "$API_LANG" != "none" ] && [ "$UI_LANG" != "none" ] || [ "$API_LANG" != "none" ]; then
    echo "Copying Nginx configuration..."
    mkdir -p "$PROJECT_NAME/infra/config/nginx/conf.d"
    mkdir -p "$PROJECT_NAME/infra/config/nginx/error"
    cp -f "$SCRIPT_ROOT_DIR/config/nginx/conf.d/default.conf" "$PROJECT_NAME/infra/config/nginx/conf.d/default.conf"
fi

# Select and Copy Compose Template
TEMPLATE=""
if [ "$API_LANG" != "none" ] && [ "$UI_LANG" != "none" ]; then
    TEMPLATE="full_template.yaml"
elif [ "$API_LANG" != "none" ]; then
    TEMPLATE="api_template.yaml"
else
    TEMPLATE="ui_template.yaml"
fi

echo "Using template: $TEMPLATE"
cp -f "$SCRIPT_ROOT_DIR/compose_file/$TEMPLATE" "$PROJECT_NAME/compose.yaml"

# Handle Dynamic Database
if [ "$DB_TYPE" != "none" ] && [ "$API_LANG" != "none" ]; then
    echo "Configuring database: $DB_TYPE..."
    DB_IMAGE=""
    DB_PORT=""
    DB_ENV=""

    case $DB_TYPE in
        postgres)
            DB_IMAGE="postgres:alpine"
            DB_PORT="5432"
            DB_ENV="- POSTGRES_DB=\${DB_DATABASE:-project_db}
      - POSTGRES_USER=\${DB_USERNAME:-user}
      - POSTGRES_PASSWORD=\${DB_PASSWORD:-password}"
            ;;
        mysql)
            DB_IMAGE="mysql:8.0"
            DB_PORT="3306"
            DB_ENV="- MYSQL_DATABASE=\${DB_DATABASE:-project_db}
      - MYSQL_USER=\${DB_USERNAME:-user}
      - MYSQL_PASSWORD=\${DB_PASSWORD:-password}
      - MYSQL_ROOT_PASSWORD=\${DB_PASSWORD:-password}"
            ;;
        mariadb)
            DB_IMAGE="mariadb:latest"
            DB_PORT="3306"
            DB_ENV="- MYSQL_DATABASE=\${DB_DATABASE:-project_db}
      - MYSQL_USER=\${DB_USERNAME:-user}
      - MYSQL_PASSWORD=\${DB_PASSWORD:-password}
      - MYSQL_ROOT_PASSWORD=\${DB_PASSWORD:-password}"
            ;;
        mongo)
            DB_IMAGE="mongo:latest"
            DB_PORT="27017"
            DB_ENV="- MONGO_INITDB_DATABASE=\${DB_DATABASE:-project_db}"
            ;;
        redis)
            DB_IMAGE="redis:alpine"
            DB_PORT="6379"
            DB_ENV="- REDIS_PASSWORD=\${DB_PASSWORD:-password}"
            ;;
        *)
            echo "Error: Database type '$DB_TYPE' not supported."
            exit 1
            ;;
    esac

    # Use python for safe multiline replacement
    python3 -c "import sys; content = open(sys.argv[1]).read(); content = content.replace('__DB_IMAGE__', sys.argv[2]).replace('__DB_PORT__', sys.argv[3]).replace('__DB_ENV__', sys.argv[4]); open(sys.argv[1], 'w').write(content)" "$PROJECT_NAME/compose.yaml" "$DB_IMAGE" "$DB_PORT" "$DB_ENV"
else
    echo "No database configured or UI-only project."
    # Remove DB service if it exists in template
    sed -i '/  db:/,/^$/ d' "$PROJECT_NAME/compose.yaml"
    sed -i '/volumes:/,/^$/ d' "$PROJECT_NAME/compose.yaml"
    # Also remove DB env from API service if it exists
    sed -i '/    environment:/,/^$/ d' "$PROJECT_NAME/compose.yaml"
fi

# Check Docker
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

echo "------------------------------------------------"
echo "Project $PROJECT_NAME created successfully!"
echo "Components:"
[ "$API_LANG" != "none" ] && echo "  - API: $API_LANG"
[ "$UI_LANG" != "none" ] && echo "  - UI: $UI_LANG"
[ "$DB_TYPE" != "none" ] && [ "$API_LANG" != "none" ] && echo "  - Persistence: $DB_TYPE"
echo "------------------------------------------------"
echo "Navigate to $PROJECT_NAME and run 'docker compose up' to start."
