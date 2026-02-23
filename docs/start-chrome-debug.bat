@echo off
set CHROME_PATH="C:\Program Files\Google\Chrome\Application\chrome.exe"
set USER_DATA_DIR=%TEMP%\chrome-debug

echo Starting Chrome in Debug mode on port 9222...
start "" %CHROME_PATH% --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir=%USER_DATA_DIR%

echo.
echo Waiting for Chrome to initialize...
ping -n 4 127.0.0.1 >nul

echo Chrome should be running on ws://localhost:9222
echo You can verify at: http://localhost:9222/json
echo.
echo Now run 'opencode' to use Chrome DevTools MCP
