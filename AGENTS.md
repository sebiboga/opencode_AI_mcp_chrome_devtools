# AGENTS.md - Project Guidelines

## Overview

This project provides scripts and configuration for running Chrome in debug mode with Chrome DevTools MCP (Model Context Protocol). It consists of:
- Windows batch scripts (`.bat`)
- Shell scripts (`.sh`) for Mac/Linux
- JSON configuration files
- Markdown and HTML documentation

## Project Structure

```
C:\github\code\
├── opencode.json              # MCP configuration for Chrome DevTools
├── README.md                  # Project overview (English)
├── INSTRUCTIONS.md            # Detailed documentation (Romanian)
├── AGENTS.md                  # This file
├── util\
│   ├── start-chrome-debug.bat # Chrome startup script (Windows)
│   └── start-chrome-debug.sh  # Chrome startup script (Mac/Linux)
└── docs\
    └── index.html             # HTML documentation
```

## No Build/Lint/Test Commands

This is a configuration and documentation project - there is no code to build, lint, or test. The batch script is tested manually by running it.

### Manual Testing

To test the scripts:
1. Ensure prerequisites are installed (Chrome, Node.js, opencode)
2. Run the appropriate script:
   - Windows: `util\start-chrome-debug.bat`
   - Mac/Linux: `chmod +x util/start-chrome-debug.sh && ./util/start-chrome-debug.sh`
3. Verify Chrome opens on port 9222
4. Navigate to http://localhost:9222/json to confirm

## Code Style Guidelines

### Batch Scripts (.bat)

- Use `setlocal enabledelayedexpansion` for variable expansion
- Always quote paths containing spaces
- Use `>nul 2>nul` to suppress output
- Check error levels with `%ERRORLEVEL%`
- Use clear step indicators: `[1/4]`, `[2/4]`, etc.
- Provide helpful error messages with installation links
- Exit with error code `1` on failure

**Example pattern:**
```batch
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: Node.js is not installed
    echo Please install from: https://nodejs.org
    exit /b 1
)
echo   - Node.js: OK
```

### Shell Scripts (.sh)

- Use `set -e` to exit on error
- Use `command -v` to check if command exists
- Use `$()` for command substitution
- Quote variables containing paths: `"$VAR"`
- Use clear step indicators: `[1/4]`, `[2/4]`, etc.
- Check prerequisites before running
- Exit with code `1` on failure

**Example pattern:**
```bash
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js is not installed"
    echo "Please install from: https://nodejs.org"
    exit 1
fi
echo "  - Node.js: OK"
```

### JSON Configuration

- Include `$schema` for validation
- Use 2-space indentation
- Trailing commas are allowed (JSON5-like)

**Example:**
```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "chrome-devtools": {
      "type": "local",
      "command": ["npx", "-y", "chrome-devtools-mcp@latest", "--browser-url=http://localhost:9222"],
      "enabled": true
    }
  }
}
```

### Markdown Documentation

- Use ATX-style headers (# ## ###)
- Use fenced code blocks with language identifier
- Use tables for structured information
- Include links to external resources
- Keep language consistent (English for README, Romanian for INSTRUCTIONS.md)

### HTML Documentation

- Use semantic HTML5 elements
- Include inline CSS for basic styling
- Use monospace font for code
- Include warning/note/success callout styles

## Prerequisites to Check

When modifying this project, always verify:

1. **Node.js** - Required for running `npx` commands
2. **opencode** - Required for MCP functionality
3. **Google Chrome** - Required for browser automation
4. **Port 9222** - Must be available (not used by another Chrome instance)

## Common Tasks

### Adding a new MCP tool

1. Update `opencode.json` with new MCP configuration
2. Document the new tool in `INSTRUCTIONS.md`
3. Test by running the batch script and verifying connection

### Updating the startup scripts

1. Test on all supported platforms (Windows, Mac, Linux)
2. Verify all error paths work correctly
3. Update documentation if behavior changes

### Updating documentation

1. Keep README.md in English
2. Keep INSTRUCTIONS.md in Romanian
3. Update docs/index.html for HTML version
4. Verify all links work

## Error Handling

- Always provide clear error messages
- Include suggested fix or installation link
- Exit with appropriate error code
- Log what was checked before failing

## Version History

- v1.0.0 - Initial project with Chrome debug script
- v1.1.0 - Added prerequisite checks and port verification
- v1.2.0 - Added cross-platform support (Mac/Linux shell script)
