local null_ls = require("null-ls")

local formatters = {
  "fish_indent",
  "markdownlint",
  "prettierd",
  "shfmt",
  "stylelint",
  "stylua",
}

local diagnostics = {
  "eslint_d",
  "fish",
  "golangci_lint",
  "markdownlint",
  "shellcheck",
  "staticcheck",
  "stylelint",
  "write_good",
}

local code_actions = { "eslint_d", "gitrebase", "shellcheck" }

local registered_sources = {}

for builtin, sources in pairs({
  formatting = formatters,
  diagnostics = diagnostics,
  code_actions = code_actions,
}) do
  for _, source in ipairs(sources) do
    local config = require("config.plugin.null-ls.with")[source] or {}
    source = null_ls.builtins[builtin][source].with(config)
    table.insert(registered_sources, source)
  end
end

null_ls.setup({
  on_attach = function(client, bufnr)
    require("config.lsp.attach").with.all(client, bufnr)
  end,
  sources = registered_sources,
})
