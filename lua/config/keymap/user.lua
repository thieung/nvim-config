local keymap = require("utils").Keymap
local map, mode, modifier = keymap.map, keymap.mode, keymap.modifier
local n, ex = mode.normal, modifier.ex

keymap.bind({
  -- Float terminal for some cool tools (lazygit, htop)
  n(map("lg", ex("Lazygit"))),
  n(map("bt", ex("Btop"))),
})
