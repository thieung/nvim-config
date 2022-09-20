local keymap = require("utils").Keymap
local map, modifier = keymap.map, keymap.modifier
local leader, ex = modifier.leader, modifier.ex

keymap.bind(map(leader("cc"), ex("ColorizerToggle")))
