local o = vim.opt

-- GENERAL
o.ignorecase = true -- use case-insensitive in search
o.guicursor = "n-c:hor50,i-ci-ve:ver25" -- horizontal in normal, vertical in insert
o.clipboard = "unnamedplus" -- connection to the system clipboard
o.conceallevel = 2 -- hide concealed text unless it has a custom replacement

-- TABS & INDENTATION
o.expandtab = true -- enable the use of space in tab
o.tabstop = 2 -- number of space in a tab
o.shiftwidth = 2 -- number of spaces to use for each step of (auto)indent
o.linebreak = true
o.breakindent = true
o.showbreak = "  ﬌"
o.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  foldopen = "",
  foldclose = "",
  diff = "/",
  eob = " ", -- use 'space' for lines after the last buffer line in a window
}

-- BUFFERS
o.hidden = true -- enable switching unsaved buffer

-- NUMBER
o.number = true -- enable line number
o.numberwidth = 2
o.ruler = false -- hide line & column information, use g Ctrl + g instead
o.relativenumber = true -- show line number relative to the line with the cursor
o.pumheight = 20 -- maximum number of items to show in the pop-up menu

-- STATUSLINE
o.laststatus = 3 -- use global status line

-- HIGHTLIGHT
o.cursorline = true
o.termguicolors = true
o.winblend = 0
o.wildoptions = "pum"
o.pumblend = 5

-- COMPLETION
o.completeopt:append({
  "menuone", -- use the popup menu also when there is only one match
  "noinsert", -- do not insert any text for a match until the user selects a match from the menu
})
