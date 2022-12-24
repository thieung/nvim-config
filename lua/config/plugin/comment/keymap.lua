local keymap = require("utils").Keymap
local map, modifier, mode = keymap.map, keymap.modifier, keymap.mode
local leader = modifier.leader
local n, v = mode.normal, mode.vselect
local api = require("Comment.api")

keymap.bind({
  n(map(leader("/"), function()
    api.toggle.linewise.current()
  end)),
  v(map(leader("/"), function()
    api.toggle.linewise(vim.fn.visualmode())
  end)),
})
