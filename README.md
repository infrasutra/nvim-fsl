# nvim-fsl

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![FSL](https://img.shields.io/badge/fsl-github-black)](https://github.com/infrasutra/fsl)

Neovim support for [Flux Schema Language (FSL)](https://github.com/infrasutra/fsl) including syntax highlighting, LSP integration, and snippets.

Repository: https://github.com/infrasutra/nvim-fsl

## Requirements

- Neovim >= 0.9
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- `fsl` CLI installed and in PATH
- Optional: [LuaSnip](https://github.com/L3MON4D3/LuaSnip) for snippet support

### Installing the CLI

```bash
go install github.com/infrasutra/fsl/cmd/fsl@latest
```

Or download from [FSL Releases](https://github.com/infrasutra/fsl/releases).

## Installation

### Using lazy.nvim

```lua
{
  'infrasutra/nvim-fsl',
  config = function()
    require('lsp.fsl').setup({
      on_attach = your_on_attach_function,
      capabilities = your_capabilities,
    })
  end
}
```

### Using lazy.nvim with LuaSnip snippets

```lua
{
  'infrasutra/nvim-fsl',
  dependencies = { 'L3MON4D3/LuaSnip' },
  config = function()
    require('lsp.fsl').setup({
      on_attach = your_on_attach_function,
      capabilities = your_capabilities,
    })

    -- Load FSL snippets
    require('luasnip.loaders.from_lua').load({
      paths = { vim.fn.stdpath('data') .. '/lazy/nvim-fsl/snippets' }
    })
  end
}
```

### Manual Installation

1. Copy files to your Neovim config:

```bash
# Syntax highlighting and filetype settings
cp ftdetect/fsl.vim ~/.config/nvim/ftdetect/
cp syntax/fsl.vim ~/.config/nvim/syntax/
cp ftplugin/fsl.vim ~/.config/nvim/ftplugin/
mkdir -p ~/.config/nvim/after/ftplugin
cp after/ftplugin/fsl.vim ~/.config/nvim/after/ftplugin/

# LSP configuration
mkdir -p ~/.config/nvim/lua/lsp
cp lua/lsp/fsl.lua ~/.config/nvim/lua/lsp/

# Snippets (optional, requires LuaSnip)
mkdir -p ~/.config/nvim/snippets
cp snippets/fsl.lua ~/.config/nvim/snippets/
```

2. Add to your `init.lua`:

```lua
require('lsp.fsl').setup({
  on_attach = function(client, bufnr)
    -- Your on_attach function
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
```

## Features

### Syntax Highlighting

- Keywords (`type`, `enum`)
- Built-in types (`String`, `Int`, `RichText`, etc.)
- Decorators (`@unique`, `@maxLength`, etc.)
- Line comments (`//`) and block comments (`/* */`)
- Strings, numbers, booleans
- Operators (`!`, `?`, `|`, `=`, `:`)
- Array brackets (`[Type]`)
- Field definitions and type names

### LSP Features

- **Diagnostics**: Real-time error detection
- **Completion**: Types, decorators, and custom types
- **Hover**: Documentation for types and decorators
- **Go-to-definition**: Jump to type declarations
- **Document symbols**: Outline view of types and fields
- **Workspace symbols**: Cross-file symbol search
- **References**: Find all usages of a type
- **Rename**: Rename types and fields
- **Formatting**: Format FSL files to canonical style

### Snippets (21 snippets)

Requires [LuaSnip](https://github.com/L3MON4D3/LuaSnip). Available snippets:

| Prefix | Description |
|--------|-------------|
| `type` | Type definition |
| `typed` | Type with decorators |
| `enum` | Enum definition |
| `fstring` | String field |
| `ftext` | Text field |
| `fint` | Int field |
| `ffloat` | Float field |
| `fbool` | Boolean field |
| `fdatetime` | DateTime field |
| `fdate` | Date field |
| `frichtext` | RichText field |
| `fimage` | Image field |
| `ffile` | File field |
| `fslug` | Slug field |
| `farray` | Array field |
| `frelation` | Relation field |
| `finlineenum` | Inline enum field |
| `fjson` | JSON field |
| `typeblog` | Blog post type template |
| `typeauthor` | Author type template |
| `typesettings` | Settings singleton template |

### User Commands

| Command | Description |
|---------|-------------|
| `:FslValidate` | Validate all FSL schema files in the workspace |
| `:FslRestartLSP` | Restart the FSL language server |

### Filetype Settings

The plugin sets sensible defaults for FSL files:

- 2-space indentation (spaces, not tabs)
- Comment string: `// %s`
- Fold method: indent
- Auto-closing pairs for `{}`, `[]`, `()`

## Configuration Options

```lua
require('lsp.fsl').setup({
  -- Path to fsl CLI (default: 'fsl')
  -- The plugin checks if this binary exists before starting the server
  cmd = '/path/to/fsl',

  -- Standard LSP callbacks
  on_attach = function(client, bufnr)
    -- Enable completion, keymaps, etc.
  end,

  -- Capabilities from nvim-cmp or similar
  capabilities = capabilities,

  -- Additional server options passed to lspconfig
  server = {
    -- Any lspconfig options
  },
})
```

## Suggested Keymaps

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fsl',
  callback = function()
    local opts = { buffer = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
  end,
})
```

## Troubleshooting

### LSP not starting

1. Verify `fsl` is in PATH: `which fsl`
2. Test the LSP server: `fsl lsp --stdio`
3. Check Neovim logs: `:LspLog`
4. If using a custom binary path, ensure it's set via `cmd` option

### No syntax highlighting

Ensure the ftdetect and syntax files are in your runtimepath:

```vim
:echo &runtimepath
```

### Snippets not loading

1. Ensure LuaSnip is installed
2. Verify the snippet loader path points to the correct directory
3. Check `:LuaSnipListAvailable` for loaded snippets

## Related Projects

- [fsl](https://github.com/infrasutra/fsl) — FSL parser, LSP, and SDK codegen
- [vscode-fsl](https://github.com/infrasutra/vscode-fsl) — VS Code extension
- [Flux CMS](https://github.com/infrasutra/fluxcms) — Schema-first headless CMS

## License

Apache License 2.0 — see [LICENSE](LICENSE).
