# Custom Banner Extension

## Context

Pi's interactive mode displays a **startup header** (banner) showing shortcuts, loaded AGENTS.md files, prompt templates, skills, and extensions. The `ctx.ui.setHeader()` API allows extensions to fully replace this built-in header with a custom component. This plan produces a pi extension that lets the user customize the initial banner via a configuration file and a `/banner` command.

The extension will:
1. Replace the default pi startup header with a user-defined banner
2. Support ASCII art, text, and color theming via a `banner.json` config file
3. Provide a `/banner` command to toggle between custom and built-in headers
4. Provide a `/banner-edit` command to interactively edit the banner text

## API Surface

Key pi APIs used:
- `ctx.ui.setHeader(factory | undefined)` — replace or restore the built-in startup header
- `pi.on("session_start", ...)` — load banner config and apply on startup
- `pi.registerCommand(name, ...)` — register `/banner` and `/banner-edit` commands
- `ctx.ui.editor(title, prefill)` — multi-line editor for banner text editing
- `ctx.ui.notify(msg, level)` — feedback notifications
- `theme.fg(color, text)` / `theme.bold(text)` — themed styling

Reference: `examples/extensions/custom-header.ts` demonstrates `setHeader()` with a mascot graphic.

## Files to Create

### 1. `.pi/extensions/custom-banner.ts` (~120 lines)

The extension module. Exports a default function receiving `ExtensionAPI`.

**On load (`session_start`):**
- Read `banner.json` from `.pi/banner.json` (project) falling back to `~/.pi/agent/banner.json` (global)
- If config exists, parse it and call `ctx.ui.setHeader()` with a factory that renders the configured banner
- If no config exists, create a default `banner.json` with a simple ASCII banner and apply it

**Banner config shape (`BannerConfig`):**

```typescript
interface BannerConfig {
  enabled: boolean;           // Master toggle
  lines: string[];            // Raw text lines (supports \n in each)
  color: string;              // Theme color key: "accent", "success", "warning", "error", "muted", "dim"
  bold: boolean;              // Apply bold styling
  subtitle?: string;          // Optional subtitle line below the banner
  subtitleColor?: string;     // Theme color for subtitle (default: "muted")
}
```

**`setHeader` factory implementation:**
- Receives `(tui, theme)`, returns `{ render(width), invalidate() }`
- `render(width)`:
  - Map each `config.lines` entry through `theme.fg(config.color, ...)` and optionally `theme.bold(...)`
  - If `config.subtitle` is set, append a styled subtitle line
  - Truncate each line to `width` using `truncateToWidth` from `@mariozechner/pi-tui`
  - Return the styled string array
- `invalidate()`: no-op (stateless rendering)

**Commands:**

| Command | Description |
|---------|-------------|
| `/banner` | Toggle between custom banner and built-in header. Updates `enabled` in config and persists. |
| `/banner-edit` | Opens `ctx.ui.editor()` pre-filled with current `lines` joined by `\n`. On submit, updates config, persists, and re-applies header. |

**Helper functions:**
- `loadConfig(cwd: string): BannerConfig | null` — Read and parse banner.json from project then global location
- `saveConfig(cwd: string, config: BannerConfig): void` — Write banner.json back to the location it was loaded from (or project default)
- `applyBanner(ctx, config, pi)` — Call `ctx.ui.setHeader()` with the config, or `ctx.ui.setHeader(undefined)` if `!config.enabled`

### 2. `.pi/banner.json` (new)

Default project-level banner configuration:

```json
{
  "enabled": true,
  "lines": [
    "┌─────────────────────────────────┐",
    "│     🚀  Sandboxes Project  🚀    │",
    "└─────────────────────────────────┘"
  ],
  "color": "accent",
  "bold": true,
  "subtitle": "Ruska AI Development Environment",
  "subtitleColor": "muted"
}
```

## Implementation Details

### `custom-banner.ts` Structure

```
import type { ExtensionAPI, ExtensionContext, Theme } from "@mariozechner/pi-coding-agent";
import { truncateToWidth } from "@mariozechner/pi-tui";
import { readFileSync, writeFileSync, existsSync } from "node:fs";
import { join } from "node:path";

interface BannerConfig { ... }

const PROJECT_CONFIG = ".pi/banner.json";
const GLOBAL_CONFIG_DIR = process.env.PI_CODING_AGENT_DIR || join(process.env.HOME!, ".pi", "agent");
const GLOBAL_CONFIG = join(GLOBAL_CONFIG_DIR, "banner.json");

function loadConfig(cwd: string): { config: BannerConfig; path: string } | null { ... }
function saveConfig(filePath: string, config: BannerConfig): void { ... }
function applyBanner(ctx: ExtensionContext, config: BannerConfig): void { ... }

export default function (pi: ExtensionAPI) {
  let currentConfig: BannerConfig | null = null;
  let configPath: string | null = null;

  pi.on("session_start", async (_event, ctx) => {
    if (!ctx.hasUI) return;
    const result = loadConfig(ctx.cwd);
    if (result) {
      currentConfig = result.config;
      configPath = result.path;
    } else {
      // Create default config in project
      currentConfig = { ...DEFAULT_CONFIG };
      configPath = join(ctx.cwd, PROJECT_CONFIG);
      saveConfig(configPath, currentConfig);
    }
    if (currentConfig.enabled) {
      applyBanner(ctx, currentConfig);
    }
  });

  pi.registerCommand("banner", { ... });      // Toggle enabled
  pi.registerCommand("banner-edit", { ... });  // Edit lines via ctx.ui.editor
}
```

### `applyBanner` implementation

```typescript
function applyBanner(ctx: ExtensionContext, config: BannerConfig): void {
  ctx.ui.setHeader((_tui, theme) => ({
    render(width: number): string[] {
      const result: string[] = [""];
      for (const line of config.lines) {
        let styled = theme.fg(config.color as any, line);
        if (config.bold) styled = theme.bold(styled);
        result.push(truncateToWidth(styled, width));
      }
      if (config.subtitle) {
        const subColor = (config.subtitleColor || "muted") as any;
        result.push(theme.fg(subColor, config.subtitle));
      }
      result.push("");
      return result;
    },
    invalidate() {},
  }));
}
```

## Implementation Order

1. Create `.pi/banner.json` with default project banner config
2. Create `.pi/extensions/custom-banner.ts` with full extension logic
3. Test with `pi -e .pi/extensions/custom-banner.ts` to verify header replacement
4. Test `/banner` toggle and `/banner-edit` editing

## Verification

1. Start pi in the project — custom banner replaces the default startup header
2. `/banner` — toggles back to built-in header, notification confirms
3. `/banner` again — restores custom banner
4. `/banner-edit` — opens editor with current lines, edit and submit → banner updates immediately
5. Restart pi — banner persists from `.pi/banner.json`
6. Delete `.pi/banner.json`, restart — extension creates default config automatically
7. `pi -p "hello"` (print mode) — extension skips UI (`ctx.hasUI` check), no errors
