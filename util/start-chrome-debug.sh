#!/bin/bash

# Chrome Debug Mode Starter - Cross-platform (Mac/Linux)
# Usage: ./start-chrome-debug.sh

set -e

USER_DATA_DIR=$(mktemp -d)
CHROME_PATH=""

echo "========================================"
echo "  Chrome Debug Mode Starter"
echo "========================================"
echo ""

echo "[1/4] Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js is not installed or not in PATH"
    echo "Please install Node.js from: https://nodejs.org"
    exit 1
fi
echo "  - Node.js: OK"

# Check opencode
if ! command -v opencode &> /dev/null; then
    echo "ERROR: opencode is not installed or not in PATH"
    echo "Please install opencode from: https://opencode.ai"
    exit 1
fi
echo "  - opencode: OK"

# Detect OS and find Chrome
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if [ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
        CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    elif [ -x "$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
        CHROME_PATH="$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if command -v google-chrome &> /dev/null; then
        CHROME_PATH="google-chrome"
    elif command -v chromium &> /dev/null; then
        CHROME_PATH="chromium"
    elif command -v chromium-browser &> /dev/null; then
        CHROME_PATH="chromium-browser"
    fi
fi

if [ -z "$CHROME_PATH" ]; then
    echo "ERROR: Google Chrome not found"
    echo "Please install Google Chrome from: https://www.google.com/chrome"
    exit 1
fi
echo "  - Chrome: OK ($CHROME_PATH)"

echo ""
echo "[2/4] Checking if port 9222 is available..."
if command -v lsof &> /dev/null; then
    if lsof -i :9222 &> /dev/null; then
        echo "ERROR: Port 9222 is already in use. Another Chrome instance may be running in debug mode."
        echo "Please close the existing Chrome debug instance or stop the process using port 9222."
        echo "To check: lsof -i :9222"
        exit 1
    fi
elif command -v netstat &> /dev/null; then
    if netstat -tuln 2>/dev/null | grep -q ":9222"; then
        echo "ERROR: Port 9222 is already in use. Another Chrome instance may be running in debug mode."
        echo "Please close the existing Chrome debug instance or stop the process using port 9222."
        exit 1
    fi
fi
echo "  - Port 9222: Available"

echo ""
echo "[3/4] Starting Chrome in Debug mode on port 9222..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    open -a "Google Chrome" --args --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir="$USER_DATA_DIR"
else
    "$CHROME_PATH" --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir="$USER_DATA_DIR" &
fi

echo ""
echo "[4/4] Verifying connection..."
sleep 3

if command -v curl &> /dev/null; then
    if curl -s http://localhost:9222/json > /dev/null 2>&1; then
        echo "  - Connection verified: OK"
    else
        echo "WARNING: Could not verify Chrome debug port. Chrome may not be responding."
        echo "You can verify manually at: http://localhost:9222/json"
    fi
fi

echo ""
echo "========================================"
echo "  Chrome is ready!"
echo "========================================"
echo ""
echo "Now run 'opencode' to use Chrome DevTools MCP"
echo ""
