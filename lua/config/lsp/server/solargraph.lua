local bin = "solargraph"

return require("config.lsp.server").with(bin, {
  cmd = { bin, "stdio" },
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
})
