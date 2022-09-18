return {
  "rebelot/terminal.nvim",
  keys = {
    { "n", "<leader>to" },
    { "n", "<leader>tO" },
    { "n", "<leader>tr" },
    { "n", "<leader>tR" },
    { "n", "<leader>tk" },
    { "n", "<leader>t]" },
    { "n", "<leader>t[" },
    { "n", "<leader>ts" },
    { "x", "<leader>ts" },
  },
  config = function()
    require("config.plugin.terminal.setup")
  end,
}
