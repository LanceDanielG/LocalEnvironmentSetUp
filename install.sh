#!/bin/bash
set -e

# Configuration
INSTALL_DIR="/usr/local/share/automated-setup"
BIN_DIR="/usr/local/bin"
COMMAND_NAME="auto-setup"

echo "🚀 Installing Automated Setup Tool globally..."

# Check for sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or with sudo"
    exit 1
fi

# Create installation directory
echo "Creating installation directory at $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"

# Copy files
echo "Copying project files..."
cp -rf ./* "$INSTALL_DIR/"

# Make script executable
chmod +x "$INSTALL_DIR/setup.sh"

# Create symlink
echo "Creating symlink at $BIN_DIR/$COMMAND_NAME..."
ln -sf "$INSTALL_DIR/setup.sh" "$BIN_DIR/$COMMAND_NAME"

echo "------------------------------------------------"
echo "✅ Installation successful!"
echo "You can now run the tool from anywhere using:"
echo "  $COMMAND_NAME <PROJECT_NAME> <API_LANG> <UI_LANG> [DB_TYPE]"
echo "------------------------------------------------"
