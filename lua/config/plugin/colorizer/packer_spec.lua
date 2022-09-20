return {
  "NvChad/nvim-colorizer.lua",
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
  keys = "<Leader>cc",
  config = function()
    require("config.plugin.colorizer.setup")
    require("config.plugin.colorizer.keymap")
  end,
}
