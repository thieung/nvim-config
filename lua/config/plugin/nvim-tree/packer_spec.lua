return {
  "kyazdani42/nvim-tree.lua",
  requires = {
    "kyazdani42/nvim-web-devicons",
  },
  tag = "nightly",
  config = function()
    require("config.plugin.nvim-tree.setup")
    require("config.plugin.nvim-tree.keymap")
  end,
  cmd = {
    "NvimTreeToggle",
    "NvimTreeOpen",
    "NvimTreeFindFile",
    "NvimTreeClose",
  },
  keys = {
    -- { "n", "<Leader>e" },
    -- { "n", "<Leader>o" },
    { "n", "<Leader>kk" },
    { "n", "<Leader>kf" },
  },
}
