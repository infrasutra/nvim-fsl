-- FSL Language Server configuration for Neovim

local M = {}

-- Check if an executable exists in PATH
local function executable_exists(name)
  return type(name) == 'string' and name ~= '' and vim.fn.executable(name) == 1
end

local function resolve_lsp_cmd(opts)
  local server_cmd = opts.server and opts.server.cmd
  if type(server_cmd) == 'table' and #server_cmd > 0 then
    return vim.deepcopy(server_cmd)
  end

  return { opts.cmd or 'fsl', 'lsp', '--stdio' }
end

local function resolve_cli_cmd(opts)
  local server_cmd = opts.server and opts.server.cmd
  if type(server_cmd) == 'table' and #server_cmd > 0 then
    local cli_cmd = vim.deepcopy(server_cmd)
    local argc = #cli_cmd
    if argc >= 2 and cli_cmd[argc - 1] == 'lsp' and cli_cmd[argc] == '--stdio' then
      table.remove(cli_cmd, argc)
      table.remove(cli_cmd, argc - 1)
    end
    return cli_cmd
  end

  return { opts.cmd or 'fsl' }
end

local function resolve_executable(cmd)
  if type(cmd) == 'table' and #cmd > 0 then
    return cmd[1]
  end

  if type(cmd) == 'string' and not cmd:find('%s') then
    return cmd
  end
end

local function detect_workspace_root(bufnr, find_root)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'fsl' })
  if clients[1] and clients[1].config.root_dir then
    return clients[1].config.root_dir
  end

  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname ~= '' then
    local root = find_root(bufname)
    if root then
      return root
    end
  end

  return vim.fn.getcwd()
end

-- Setup function to configure the FSL language server
function M.setup(opts)
  opts = opts or {}

  local lsp_cmd = resolve_lsp_cmd(opts)
  local cli_cmd = resolve_cli_cmd(opts)
  local executable = resolve_executable(lsp_cmd) or resolve_executable(cli_cmd)

  -- Check if the resolved binary exists before proceeding
  if executable and not executable_exists(executable) then
    vim.notify(
      string.format(
        'FSL language server binary "%s" not found in PATH.\n'
          .. 'Install it with: go install github.com/infrasutra/fsl/cmd/fsl@latest\n'
          .. 'Or set a custom path: require("lsp.fsl").setup({ cmd = "/path/to/fsl" })',
        executable
      ),
      vim.log.levels.WARN
    )
    return
  end

  local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
  if not lspconfig_ok then
    vim.notify('lspconfig not found. Please install neovim/nvim-lspconfig', vim.log.levels.ERROR)
    return
  end

  local configs = require('lspconfig.configs')
  local find_root = lspconfig.util.root_pattern('.fsl.yaml', '.fsl.yml', '.fluxcms.yaml', '.fluxcms.yml', '.git')

  -- Check if fsl config already exists
  if not configs.fsl then
    configs.fsl = {
      default_config = {
        cmd = lsp_cmd,
        filetypes = { 'fsl' },
        root_dir = find_root,
        settings = {},
        single_file_support = true,
      },
      docs = {
        description = [[
FSL Language Server for FSL schemas.

Provides diagnostics, completion, hover, go-to-definition, formatting, and rename.

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

  -- Register user commands
  vim.api.nvim_create_user_command('FslValidate', function()
    local root = detect_workspace_root(0, find_root)
    local validate_cmd = vim.list_extend(vim.deepcopy(cli_cmd), { 'validate', root })
    vim.cmd('botright new')
    vim.bo.bufhidden = 'wipe'
    vim.fn.termopen(validate_cmd)
  end, { desc = 'Validate all FSL schema files in the workspace' })

  vim.api.nvim_create_user_command('FslRestartLSP', function()
    vim.cmd('LspRestart fsl')
    vim.notify('FSL Language Server restarted', vim.log.levels.INFO)
  end, { desc = 'Restart the FSL language server' })
end

return M
