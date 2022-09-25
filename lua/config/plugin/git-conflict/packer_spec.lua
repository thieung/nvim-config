return {
  "akinsho/git-conflict.nvim",
  tag = "*",
  config = function()
    require("config.plugin.git-conflict.setup")
    require("config.plugin.git-conflict.keymap")
  end,
}
