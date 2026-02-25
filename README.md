# Chrome Debug Mode Setup

Scripts and documentation for running Chrome in debug mode with the Chrome DevTools MCP.

## Prerequisites

Before using this project, ensure you have the following installed:

| Requirement | Version | Installation |
|-------------|---------|---------------|
| **Google Chrome** | Latest | [Download](https://www.google.com/chrome) |
| **Node.js** | 18+ | [Download](https://nodejs.org) |
| **opencode** | Latest | [Download](https://opencode.ai) |

## Quick Start

1. Start Chrome in debug mode:
   ```bash
   # Windows
   util\start-chrome-debug.bat

   # Mac/Linux (first time: chmod +x util/start-chrome-debug.sh)
   ./util/start-chrome-debug.sh
   ```

2. Verify Chrome is running correctly:
   ```
   http://localhost:9222/json
   ```

3. Use the Chrome DevTools MCP to control the browser.

## Documentation

See [docs/index.html](docs/index.html) for detailed information about required flags and troubleshooting.

## License

MIT
