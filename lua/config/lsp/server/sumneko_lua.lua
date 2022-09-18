-- ensure lua-language-server is installed
return require("config.lsp.server").with("lua-language-server", {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Both",
        keywordSnippet = "Both",
      },
      diagnostics = { globals = { "vim" } },
      format = { enable = false },
      hint = { enable = true, setType = true },
      runtime = {
        version = "LuaJIT",
      },
      telemetry = { enable = false },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
        preloadFileSize = 1000,
      },
    },
  },
})
