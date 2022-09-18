local keymap = require("utils").Keymap
local map, modifier, n = keymap.map, keymap.modifier, keymap.mode.normal
local leader, ex = modifier.leader, modifier.ex

keymap.bind({
  -- n(map(leader("e"), ex("NvimTreeToggle"))),
  -- n(map(leader("o"), ex("NvimTreeFocus"))),
  n(map(leader("kk"), ex("NvimTreeToggle"))),
  n(map(leader("kf"), ex("NvimTreeFindFile"))),
}, {})
