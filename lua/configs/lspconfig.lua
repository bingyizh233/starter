-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "pylsp"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--

lspconfig.mlir_lsp_server.setup {
  on_attach = nvlsp.on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  cmd = {"./build/bin/triton-lsp"},
  filetypes = {"mlir"},
  single_file_support = {true},
  root_dir = function(fname)
      return lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
}



lspconfig.tblgen_lsp_server.setup {
  on_attach = nvlsp.on_attach,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  cmd = {"/scratch/triton-home/.triton/llvm/llvm-36adf8ec-ubuntu-x64/bin/tblgen-lsp-server", "--tablegen-compilation-database=./build/tablegen_compile_commands.yml"},
  filetypes = {"tablegen"},
  single_file_support = {true},
  root_dir = function(fname)
      return lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
}
