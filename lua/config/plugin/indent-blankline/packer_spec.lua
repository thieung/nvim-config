return {
  "lukas-reineke/indent-blankline.nvim",
  opt = true,
  setup = function()
    require("utils").Lazyload.on_file_open("indent-blankline.nvim")
  end,
  config = function()
    require("config.plugin.indent-blankline.setup")
  end,
}
