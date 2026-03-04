# nvim-fsl

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![FSL](https://img.shields.io/badge/fsl-github-black)](https://github.com/infrasutra/fsl)

Neovim support for [Flux Schema Language (FSL)](https://github.com/infrasutra/fsl) including syntax highlighting and LSP integration.

Repository: https://github.com/infrasutra/nvim-fsl

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

### Using packer.nvim

```lua
use {
  'infrasutra/nvim-fsl',
  config = function()
    require('lsp.fsl').setup()
  end
}
```

### Manual Installation

1. Copy files to your Neovim config:

```bash
# Syntax highlighting
cp ftdetect/fsl.vim ~/.config/nvim/ftdetect/
cp syntax/fsl.vim ~/.config/nvim/syntax/

# LSP configuration
mkdir -p ~/.config/nvim/lua/lsp
cp lua/lsp/fsl.lua ~/.config/nvim/lua/lsp/
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

## Requirements

- Neovim 0.8+
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- `fsl` CLI installed and in PATH

### Installing the CLI

```bash
go install github.com/infrasutra/fsl/cmd/fsl@latest
```

Or download from [FSL Releases](https://github.com/infrasutra/fsl/releases).

## Features

### Syntax Highlighting

- Keywords (`type`, `enum`)
- Built-in types (`String`, `Int`, `RichText`, etc.)
- Decorators (`@unique`, `@maxLength`, etc.)
- Comments, strings, numbers
- Field definitions

### LSP Features

- **Diagnostics**: Real-time error detection
- **Completion**: Types, decorators, and custom types
- **Hover**: Documentation for types and decorators
- **Go-to-definition**: Jump to type declarations
- **Document symbols**: Outline view of types and fields
- **References**: Find all usages of a type

## Configuration Options

```lua
require('lsp.fsl').setup({
  -- Path to fsl CLI (default: 'fsl')
  cmd = '/path/to/fsl',

  -- Standard LSP callbacks
  on_attach = function(client, bufnr)
    -- Enable completion, keymaps, etc.
  end,

  -- Capabilities from nvim-cmp or similar
  capabilities = capabilities,

  -- Additional server options
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
  end,
})
```

## Troubleshooting

### LSP not starting

1. Verify `fsl` is in PATH: `which fsl`
2. Test the LSP server: `fsl lsp --stdio`
3. Check Neovim logs: `:LspLog`

### No syntax highlighting

Ensure the ftdetect and syntax files are in your runtimepath:

```vim
:echo &runtimepath
```

## Related Projects

- [fsl](https://github.com/infrasutra/fsl) — FSL parser, LSP, and SDK codegen
- [vscode-fsl](https://github.com/infrasutra/vscode-fsl) — VS Code extension
- [Flux CMS](https://github.com/infrasutra/fluxcms) — Schema-first headless CMS

## License

Apache License 2.0 — see [LICENSE](LICENSE).
