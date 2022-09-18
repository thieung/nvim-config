return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("config.plugin.highlight-colors.setup")
    require("config.plugin.highlight-colors.keymap")
  end,
  cmd = {
    "HighlightColorsOn",
    "HighlightColorsOff",
    "HighlightColorsToggle",
  },
  keys = "<Leader>cc",
}
