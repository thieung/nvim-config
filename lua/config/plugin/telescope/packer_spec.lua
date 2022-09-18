return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.0",
  requires = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      module = "telescope._extensions.file_browser",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
      module = "telescope._extensions.fzf",
    },
  },
  config = function()
    require("config.plugin.telescope.setup")
    require("config.plugin.telescope.keymap")
  end,
  cmd = "Telescope",
  keys = {
    "<Leader>ff",
    "<Leader>fa",
    "<Leader>fw",
    "<Leader>fW",
    "<Leader>fo",
    "<Leader>fc",
    "<Leader>fb",
    "<Leader>fe",
    "<Leader>gb",
    "<Leader>gc",
    "<Leader>gs",
  },
  module = "telescope",
}
