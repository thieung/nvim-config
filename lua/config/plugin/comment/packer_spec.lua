return {
  "numToStr/Comment.nvim",
  module = "Comment",
  config = function()
    require("config.plugin.comment.setup")
    require("config.plugin.comment.keymap")
  end,
  keys = {
    "gc",
    "gb",
    { "n", "<Leader>/" },
    { "v", "<Leader>/" },
  },
}
