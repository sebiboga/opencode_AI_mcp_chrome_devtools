# Chrome DevTools MCP - Documentatie

## Prerequisites

Inainte de a folosi acest proiect, asigura-te ca ai instalat:

| Cerinta | Versiune | Instalare |
|---------|----------|-----------|
| **Google Chrome** | Latest | [Download](https://www.google.com/chrome) |
| **Node.js** | 18+ | [Download](https://nodejs.org) |
| **opencode** | Latest | [Download](https://opencode.ai) |

## Setup

### 1. Configurare MCP (opencode.json)

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

### 2. Pornire Chrome in modul debug

```bash
# Windows
util\start-chrome-debug.bat

# Mac/Linux (prima data: chmod +x util/start-chrome-debug.sh)
./util/start-chrome-debug.sh
```

Sau manual:
```cmd
chrome.exe --remote-debugging-port=9222 --no-first-run --no-default-browser-check --user-data-dir=%TEMP%\chrome-debug
```

Verificare: mergi la http://localhost:9222/json

## Comenzi MCP disponibile

| Comanda | Descriere |
|---------|-----------|
| `chrome-devtools_new_page` | Deschide o pagina noua (parametru: url) |
| `chrome-devtools_take_snapshot` | Face snapshot paginii, afiseaza structura DOM |
| `chrome-devtools_click` | Da click pe un element (parametru: uid) |
| `chrome-devtools_fill` | Completeaza un camp text (parametre: uid, value) |
| `chrome-devtools_navigate_page` | Navigheaza la un URL (parametru: url) |
| `chrome-devtools_take_screenshot` | Face captura ecran |
| `chrome-devtools_hover` | Hover pe un element |
| `chrome-devtools_fill_form` | Completeaza mai multe campuri |

## Structura proiectului

```
C:\github\code\
├── AGENTS.md                  # Guidelines pentru agenti
├── opencode.json              # Configurare MCP
├── INSTRUCTIONS.md            # Documentatie
├── util\
│   ├── start-chrome-debug.bat # Pornire Chrome debug (Windows)
│   └── start-chrome-debug.sh # Pornire Chrome debug (Mac/Linux)
└── docs\
    └── index.html
```

## Troubleshooting

**Eroare: "Failed to fetch browser webSocket URL"**
- Ruleaza `util\start-chrome-debug.bat` mai intai
- Verifica Chrome ruleaza pe portul 9222

**VS Code: CMD nu se deschide automat**
- Settings → Terminal > Integrated > Default Profile: Windows → Command Prompt
