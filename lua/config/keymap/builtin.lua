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
  map(leader("<Space>"), ex("w")), -- save
  map("<C-s>", ex("w!")), -- force write
  map(leader(";"), ex("x")),
  map(leader("'"), ex("wall")),
  map(leader("q"), ex("q")), -- quit
  map("<C-q>", ex("q!")), -- force quit
  map("[Q", ex("xall")), -- save tabs/unchanged buffers and exit vim

  -- command mode without arrows and tab
  nop(c(map("<Tab>"))),
  nop(c(map("<S-Tab>"))),
  c(map("<C-a>", "<Home>")),
  c(map("<C-f>", "<Right>")),
  c(map("<C-b>", "<Left>")),
  c(map("<M-f>", "<S-Right>")),
  c(map("<M-b>", "<S-Left>")),
  c(map("<C-p>", "<Up>")),
  c(map("<C-n>", "<Down>")),
  c(map("<C-k>", "<Up>")),
  c(map("<C-j>", "<Down>")),

  -- easy select-all
  n(map("gA", "ggVG", { silent = true })),
  v(map("gA", "ggoG", { silent = true })),

  -- better increment/decrement
  n(map("-", "C-x")),
  n(map("+", "C-a")),

  -- toggle number
  map(leader("nn"), ex("set relativenumber!")),
  map(leader("ln"), ex("set number!")),

  -- cursor movements
  map("H", "^"), -- To the first non-blank character of the line
  map("L", "g_"), -- To the last non-blank character of the line

  -- buffers
  n(map(leader("X"), ex("bdelete!"))), -- close buffer
  n(map(leader("x"), ex("enew<BAR>bdelete #"))), -- close buffer without close window
  n(map("<C-w>B", ex("bprevious<BAR>bdelete #"))), -- delete current buffer and move to the previous buffer
  n(map(leader("ca"), ex("%bd"))), -- close all buffers
  n(map("<S-Tab>", ex("bprevious"))), -- navigate to previous buffer
  n(map("<Tab>", ex("bnext"))), -- navigate to next buffer

  -- tabs
  n(map("<C-w>O", ex("tabonly"))),
  n(map(leader("t"), ex("tabnew"))),
  n(map(leader("["), ex("-tabmove"))),
  n(map(leader("]"), ex("+tabmove"))),

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

  -- moves line
  n(map("<S-Down>", ":m .+1<CR>==", { silent = true })),
  i(map("<S-Down>", "<Esc>:m .+1<CR>==gi", { silent = true })),
  v(map("J", ":m '>+1<CR>gv=gv", { silent = true })),
  n(map("<S-Up>", ":m .-2<CR>==", { silent = true })),
  i(map("<S-Up>", "<Esc>:m .-2<CR>==gi", { silent = true })),
  v(map("K", ":m '<-2<CR>gv=gv", { silent = true })),
  n(map("J", "'mz' . v:count1 . 'J`z'", { expr = true })), -- join lines without changing cursor position

  -- Paste-Yank behavior
  -- By default, in visual-line mode, the selected line will be yanked,
  -- and replace the previous yanked line. This map to imporve that behaviour,
  -- after paste, select the yanked line, so it's easy to yank that line again
  v(map("p", "pgv")),
  -- yank-Paste from clipboard
  n(map(leader("p"), '"+p')),
  v(map(leader("p"), '"+p')),
  n(map(leader("P"), '"+P')),
  v(map(leader("P"), '"+P')),
  n(map(leader("y"), '"+y')),
  v(map(leader("y"), '"+y')),
  n(map(leader("Y"), '"+y$')),
  n(map(leader("d"), '"+d')),

  -- reselect indented line
  v(map("<", "<gv")),
  v(map(">", ">gv")),
  v(map("=", "=gv")),
  v(map("<BS>", "<gv")),
  v(map("<TAB>", ">gv")),
})
