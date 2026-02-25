@echo off
setlocal enabledelayedexpansion

set USER_DATA_DIR=%TEMP%\chrome-debug

echo ========================================
echo   Chrome Debug Mode Starter
echo ========================================
echo.

echo [1/4] Checking prerequisites...

where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please install Node.js from: https://nodejs.org
    exit /b 1
)
echo   - Node.js: OK

where opencode >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: opencode is not installed or not in PATH
    echo Please install opencode from: https://opencode.ai
    exit /b 1
)
echo   - opencode: OK

set CHROME_PATH=
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="C:\Program Files\Google\Chrome\Application\chrome.exe"
) else if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    set CHROME_PATH="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
)

if not defined CHROME_PATH (
    echo ERROR: Google Chrome not found
    echo Please install Google Chrome from: https://www.google.com/chrome
    exit /b 1
)
echo   - Chrome: OK

echo.
echo [2/4] Checking if port 9222 is available...
netstat -ano | findstr :9222 >nul
if %ERRORLEVEL% equ 0 (
    echo ERROR: Port 9222 is already in use. Another Chrome instance may be running in debug mode.
    echo Please close the existing Chrome debug instance or stop the process using port 9222.
    echo To check: netstat -ano ^| findstr :9222
    exit /b 1
)
echo   - Port 9222: Available

echo.
echo [3/4] Starting Chrome in Debug mode on port 9222...
start "" %CHROME_PATH% --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir=%USER_DATA_DIR%

echo.
echo Waiting for Chrome to initialize...
timeout /t 3 /nobreak >nul

echo.
echo [4/4] Verifying connection...
powershell -Command "try { Invoke-WebRequest -Uri 'http://localhost:9222/json' -TimeoutSec 5 -UseBasicParsing | Out-Null; exit 0 } catch { exit 1 }"
if %ERRORLEVEL% neq 0 (
    echo WARNING: Could not verify Chrome debug port. Chrome may not be responding.
    echo You can verify manually at: http://localhost:9222/json
) else (
    echo   - Connection verified: OK
)

echo.
echo ========================================
echo   Chrome is ready!
echo ========================================
echo.
echo Now run 'opencode' to use Chrome DevTools MCP
echo.
pause
