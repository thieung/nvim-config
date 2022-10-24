return {
  "lewis6991/gitsigns.nvim",
  ft = "gitcommit",
  setup = function()
    require("config.plugin.gitsigns.lazy_load")
  end,
  config = function()
    require("config.plugin.gitsigns.setup")
  end,
  keys = { "gs", "]c", "]C", "[c", "[C" },
}
