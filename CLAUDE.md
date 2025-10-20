# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration located at `/Users/tony/.config/nvim`. It's built from scratch following the "Neovim from Scratch" YouTube series by MrJakob and uses lazy.nvim as the plugin manager.

## Architecture

### Entry Point
- `init.lua` - Minimal entry point that only requires `config.lazy`

### Configuration Structure
```
lua/
├── config/           # Core Neovim configuration
│   ├── lazy.lua     # Plugin manager bootstrap & setup
│   ├── options.lua  # Vim options (indentation, display, behavior)
│   └── keymaps.lua  # Global keybindings
└── plugins/         # Individual plugin configurations (lazy.nvim auto-loads from here)
```

### Plugin Management
- Uses **lazy.nvim** as the plugin manager
- Each plugin has its own file in `lua/plugins/` (e.g., `lsp.lua`, `fzflua.lua`)
- lazy.nvim automatically imports all files from the `plugins/` directory
- Plugin lockfile: `lazy-lock.json` (git-ignored)

### Key Architecture Patterns

**Leader Keys:**
- `<Space>` is the leader key
- `\` is the local leader key
- Set in `lua/config/lazy.lua` before plugins load

**LSP Configuration:**
- LSP setup happens in `lua/plugins/lsp.lua`
- Uses Mason for automatic LSP server installation
- LSP keybindings are set via `LspAttach` autocmd (buffer-local)
- Configured servers: lua_ls, bashls, marksman, gopls
- Auto-installed tools: stylua, prettierd, gopls, delve

**Completion:**
- Uses **blink.cmp** (Rust-based completion engine)
- Configured in `lua/plugins/blink-cmp.lua`
- Sources: LSP, path, snippets, buffer, SQL
- Supports nvim-cmp sources via blink.compat

**Formatting:**
- Uses **conform.nvim** for code formatting
- Configured in `lua/plugins/conform.lua`
- Format on save enabled (500ms timeout)
- Formatters: stylua (Lua), rustfmt (Rust), gofmt (Go), prettierd/prettier (JS/TS)

**Terminal Integration:**
- Uses **toggleterm.nvim** for embedded terminals
- Configured in `lua/plugins/toggleterm.lua`
- Three terminal modes: floating, vertical, horizontal
- Custom terminal management to reuse existing terminals by direction
- Lazygit integration via floating terminal

**Fuzzy Finding:**
- Uses **fzf-lua** for fuzzy finding
- LSP navigation (gd, gr, gI) uses fzf-lua for results
- File finding, live grep, buffer switching all via fzf-lua

## Common Commands

### Plugin Management
```bash
# Open lazy.nvim UI (from within Neovim)
:Lazy

# Update plugins
:Lazy update

# Install new plugins
:Lazy install

# Clean unused plugins
:Lazy clean
```

### LSP & Tool Management
```bash
# Open Mason UI to manage LSP servers and tools
:Mason

# Check LSP status for current buffer
:LspInfo

# View installed Mason packages
:MasonLog
```

### Markdown Preview Theme
```bash
# Switch to dark theme
:MarkdownPreviewDark

# Switch to light theme
:MarkdownPreviewLight

# Auto-detect based on OS theme (default)
:MarkdownPreviewAuto

# Note: After changing theme, restart the preview (:MarkdownPreviewToggle twice)
```

### Key Mappings (Normal Mode)

**File Navigation:**
- `<leader>ff` - Find files in project
- `<leader>fg` - Live grep in project
- `<leader>fc` - Find files in Neovim config directory
- `<leader>fb` - Browse FZF builtin pickers
- `<leader><leader>` - Find existing buffers
- `<leader>/` - Live grep current buffer
- `-` - Open parent directory in Oil (file manager)

**LSP (when LSP is attached):**
- `gd` - Go to definition (fzf-lua)
- `gr` - Go to references (fzf-lua)
- `gI` - Go to implementation (fzf-lua)
- `gD` - Go to declaration
- `gl` - Open diagnostics float
- `<leader>D` - Type definition
- `<leader>ds` - Document symbols
- `<leader>ws` - Workspace symbols
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>th` - Toggle inlay hints

**Formatting & Editing:**
- `<leader>cf` - Format current file (conform.nvim)
- `<leader>h` - Clear search highlight

**Markdown:**
- `<leader>mp` - Toggle markdown preview in browser

**UI/Theme:**
- `<leader>uL` - Catppuccin Latte (light)
- `<leader>uF` - Catppuccin Frappé (dark soft)
- `<leader>uM` - Catppuccin Macchiato (dark medium)
- `<leader>uC` - Catppuccin Mocha (dark deep)

**Terminal:**
- `<C-\>` - Toggle default terminal
- `<leader>tf` - Toggle floating terminal
- `<leader>tv` - Toggle vertical terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>gg` - Toggle lazygit
- `<Esc>` (in terminal mode) - Exit to normal mode

**Clipboard-safe Delete:**
- `x`, `X`, `<Del>` - Delete without yanking (both normal & visual mode)

## Important Configuration Details

### Options (lua/config/options.lua)
- 4-space indentation (tabs converted to spaces)
- Relative line numbers with absolute current line
- Undo persistence across sessions
- Mouse enabled only in insert mode
- Case-insensitive search (unless uppercase present)
- System clipboard integration
- 5-line scrolloff

### Diagnostic Configuration
- Severity sorting enabled
- Only errors underlined
- Virtual text with custom icons
- Rounded float borders
- Icons: 󰅚 (error), 󰀪 (warn), 󰋽 (info), 󰌶 (hint)

### Terminal Behavior
- Vertical terminal: 50% of editor width
- Horizontal terminal: 15 rows
- Default direction: float
- Curved borders for floating terminals
- Auto-close on process exit

## Development Workflow

### Adding a New Plugin
1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/myplugin.lua`)
2. Return a lazy.nvim plugin spec table
3. Restart Neovim or run `:Lazy reload`

### Modifying LSP Servers
Edit the `servers` table in `lua/plugins/lsp.lua`:
```lua
local servers = {
    bashls = {},
    lua_ls = { settings = {...} },
    -- Add new server here
}
```

### Adding Formatters
Edit `formatters_by_ft` in `lua/plugins/conform.lua`:
```lua
formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },  -- Example
}
```

### Colorscheme
Current theme: **Catppuccin Mocha** (configured in `lua/plugins/catppuccin.lua`)

Available themes:
- **Catppuccin** - Main theme with 4 flavors (Latte, Frappé, Macchiato, Mocha)
- **tokyonight** - Alternative theme (configured in `lua/plugins/tokyonight.lua`)

#### Switching Catppuccin Flavors

**Via Commands:**
- `:CatppuccinLatte` - Light theme
- `:CatppuccinFrappe` - Dark theme (softer)
- `:CatppuccinMacchiato` - Dark theme (medium)
- `:CatppuccinMocha` - Dark theme (default, deepest)

**Via Keymaps:**
- `<leader>uL` - Switch to Latte (light)
- `<leader>uF` - Switch to Frappé
- `<leader>uM` - Switch to Macchiato
- `<leader>uC` - Switch to Mocha (dark)

**Default Flavor Configuration:**
Edit `flavour` in `lua/plugins/catppuccin.lua:6` to change the default (latte, frappe, macchiato, or mocha)

## Reference
- Configuration inspired by: [YouTube: Neovim from Scratch by MrJakob](https://youtu.be/g1gyYttzxcI?si=zTQLkcXjYp0pdVTE)
- Complete reference config: [GitHub: SarathLUN/my-neovim-config-2025](https://github.com/SarathLUN/my-neovim-config-2025)
