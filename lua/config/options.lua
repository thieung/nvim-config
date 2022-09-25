local o = vim.opt

-- TABS & INDENTATION
o.expandtab = true -- enable the use of space in tab
o.tabstop = 2 -- number of space in a tab
o.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
o.linebreak = true
o.breakindent = true
o.showbreak = "  ﬌"

-- NUMBER
o.number = true -- enable line number
o.numberwidth = 2
o.ruler = false -- hide line & column information, use g Ctrl + g instead
o.relativenumber = true -- show line number relative to the line with the cursor

-- STATUSLINE
o.laststatus = 3 -- use global status line

-- HIGHTLIGHT
o.cursorline = true
o.termguicolors = true
o.winblend = 0
o.wildoptions = "pum"
o.pumblend = 5
