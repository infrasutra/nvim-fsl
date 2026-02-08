-- FSL Language Server configuration for Neovim
-- Add this to your Neovim configuration

local M = {}

-- Setup function to configure the FSL language server
function M.setup(opts)
  opts = opts or {}

  local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_ok then
    vim.notify('lspconfig not found. Please install neovim/nvim-lspconfig', vim.log.levels.ERROR)
    return
  end

  local configs = require('lspconfig.configs')

  -- Check if fsl config already exists
  if not configs.fsl then
    configs.fsl = {
      default_config = {
        cmd = { opts.cmd or 'fsl', 'lsp', '--stdio' },
        filetypes = { 'fsl' },
        root_dir = lspconfig.util.root_pattern('.fluxcms.yaml', '.fluxcms.yml', '.git'),
        settings = {},
        single_file_support = true,
      },
      docs = {
        description = [[
FSL Language Server for Flux CMS schemas.

Provides diagnostics, completion, hover, and go-to-definition.

Install the CLI:
  go install github.com/infrasutra/fsl/cmd/fsl@latest
]],
      },
    }
  end

  -- Setup with user options
  lspconfig.fsl.setup(vim.tbl_deep_extend('force', {
    on_attach = opts.on_attach,
    capabilities = opts.capabilities,
  }, opts.server or {}))
end

return M
