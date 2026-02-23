# Chrome Debug Mode Setup

Scripts and documentation for running Chrome in debug mode with the Chrome DevTools MCP.

## Quick Start

1. Start Chrome in debug mode:
   ```bash
   util\start-chrome-debug.bat
   ```

2. Verify Chrome is running correctly:
   ```
   http://localhost:9222/json
   ```

3. Use the Chrome DevTools MCP to control the browser.

## Documentation

See [docs/chrome-debug-mode.html](docs/chrome-debug-mode.html) for detailed information about required flags and troubleshooting.

## Requirements

- Google Chrome
- Chrome DevTools MCP configured to connect to `localhost:9222`

## License

MIT
