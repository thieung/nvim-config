local client = require("config.lsp.server.tsserver")
if not client then
  return false
end

-- This prevents `tsserver` from running on non Node.js projects
-- (e.g. deno) by removing `.git` as `root_dir` and specifying it with
-- common Node.js project file such as `package.json`.
client.root_dir = require("lspconfig.util").root_pattern(
  "package.json",
  "tsconfig.json",
  "jsconfig.json"
)

require("typescript").setup({
  disable_formatting = true,
  server = client,
})
