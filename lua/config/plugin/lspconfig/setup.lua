local lsp = require("lspconfig")
local server_config = require("config.lsp.server")

local servers = {
  -- denols = require("config.lsp.server.denols"),
  -- gopls = require("config.lsp.server.gopls"),
  -- jsonls = require("config.lsp.server.jsonls"),
  sumneko_lua = require("config.lsp.server.sumneko_lua"),
  -- svelte = require("config.lsp.server.svelte"),
  -- tailwindcss = require("config.lsp.server.tailwindcss"),
  --yamlls = server_config.with("yaml-language-server"),
  solargraph = require("config.lsp.server.solargraph"),
}

for server, config in pairs(servers) do
  if config then
    lsp[server].setup(config)
  end
end
