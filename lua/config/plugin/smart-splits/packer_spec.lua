return {
  "mrjones2014/smart-splits.nvim",
  module = "smart-splits",
  config = function()
    require("config.plugin.smart-splits.setup")
    vim.defer_fn(function()
      require("config.plugin.smart-splits.keymap")
    end, 0)
  end,
  keys = {
    { "n", "<C-Up>" },
    { "n", "<C-Down>" },
    { "n", "<C-Left>" },
    { "n", "<C-Right>" },
    { "n", "<C-h>" },
    { "n", "<C-j>" },
    { "n", "<C-k>" },
    { "n", "<C-l>" },
  },
}
