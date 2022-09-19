local key = require("utils").Keymap
local map, n = key.map, key.mode.normal

key.bind({
  -- resize
  n(map("<C-Up>", function()
    require("smart-splits").resize_up(2)
  end)), -- Resize split up
  n(map("<C-Down>", function()
    require("smart-splits").resize_down(2)
  end)), -- Resize split down
  n(map("<C-Left>", function()
    require("smart-splits").resize_left(2)
  end)), -- Resize split left
  n(map("<C-Right>", function()
    require("smart-splits").resize_right(2)
  end)), -- Resize split right

  -- navigation
  n(map("<C-h>", require("smart-splits").move_cursor_left)), -- move to left split
  n(map("<C-j>", require("smart-splits").move_cursor_down)), -- move to below split
  n(map("<C-k>", require("smart-splits").move_cursor_up)), -- move to above split
  n(map("<C-l>", require("smart-splits").move_cursor_right)), -- move to right split
})
