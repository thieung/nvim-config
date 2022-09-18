return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("config.plugin.null-ls.setup")
  end,
  ft = {
    "css",
    "fish",
    "go",
    "gomod",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "markdown",
    "scss",
    "sh",
    "svelte",
    "typescript",
    "typescriptreact",
  },
}
