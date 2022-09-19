local keymap = require("utils").Keymap
local map, mode, modifier = keymap.map, keymap.mode, keymap.modifier
local nop, leader, ex = modifier.nop, modifier.leader, modifier.ex
local n, i, v, s, c, t =
  mode.normal, mode.insert, mode.vselect, mode.select, mode.cmd, mode.terminal

keymap.bind({
  -- disable arrow keys in normal mode
  nop(map("<Up>")),
  nop(map("<Down>")),
  nop(map("<Left>")),
  nop(map("<Right>")),

  -- g{j,k} move to the first non-blank character of the line
  n(map("gj", "gj^")),
  n(map("gk", "gk^")),

  -- easy escape
  map("<M-q>", "<Esc>"),
  s(map("<M-q>", "<Esc>")),
  i(map("<M-q>", "<Esc>")),
  c(map("<M-q>", "<Esc>")),
  t(map("<M-q>", [[<C-\><C-n>]])),
  t(map("<Esc>", [[<C-\><C-n>]])),

  -- easy save & quit
  map(leader("<Space>"), ex("update!")),
  map("<C-s>", ex("update")),
  map(leader(";"), ex("x")),
  map(leader("'"), ex("wall")),
  map("[q", ex("q")),
  map("[Q", ex("xall")),

  -- easy select-all
  n(map("gA", "ggVG", { silent = true })),
  v(map("gA", "ggoG", { silent = true })),

  -- toggle number
  map(leader("nn"), ex("set relativenumber!")),
  map(leader("ln"), ex("set number!")),

  -- cursor movements
  map("H", "^"), -- To the first non-blank character of the line
  map("L", "g_"), -- To the last non-blank character of the line

  -- buffers
  n(map(leader("c"), ex("bdelete"))),
  n(map(leader("x"), ex("bdelete!"))),
  --n(map("<S-Tab>", ex("bprevious"))),
  --n(map("<Tab>", ex("bnext"))),

  --- window
  -- easy split
  n(map("|", ex("vsplit"))), -- vertical spilit
  n(map("\\", ex("split"))), -- horizontal spilit
  -- open terminal buffer at the bottom with 20 rows height
  n(map("<M-`>", ex("botright 20split term://$SHELL"))),

  --- search behavior
  -- map "/" to search current selected text
  v(map("/", [[y/<C-r>"<CR>]])),
  -- centering window when hit n/N
  n(map("n", "mnnzz")),
  n(map("N", "mnNzz")),
  -- if hlsearch is active, <CR> to clear it, otherwise <CR> is <CR>
  n(map("<CR>", function()
    if vim.v.hlsearch == 1 then
      return "<Cmd>nohlsearch<CR>"
    end
    return "<CR>"
  end, { expr = true })),
})
