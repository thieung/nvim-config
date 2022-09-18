return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  module = "neo-tree",
  cmd = "Neotree",
  requires = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("config.plugin.neo-tree.setup")
    require("config.plugin.neo-tree.keymap")
  end,
  keys = {
    { "n", "<Leader>e" },
    { "n", "<Leader>o" },
  },
}
