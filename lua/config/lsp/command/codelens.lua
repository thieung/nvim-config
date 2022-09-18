local M = {}

function M.attach(bufnr)
  local command = require("utils").Command
  command.group({
    prefix = "Codelens",
    buf = bufnr,
    cmds = {
      { name = "Refresh", cmd = vim.lsp.codelens.refresh },
      { name = "Run", cmd = vim.lsp.codelens.run },
    },
  })
end

return M
