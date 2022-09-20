return {
  "echasnovski/mini.nvim",
  modules = {
    "mini.ai",
    "mini.bufremove",
    "mini.comment",
    "mini.indentscope",
    "mini.jump",
    "mini.jump2d",
    "mini.pairs",
    "mini.sessions",
    "mini.starter",
    "mini.surround",
    "mini.trailspace",
  },
  event = { "VimEnter" },
  config = function()
    require("config.plugin.mini.setup")
  end,
}
