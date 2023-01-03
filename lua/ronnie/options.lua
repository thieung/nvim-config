--- Reference: https://neovim.io/doc/user/options.html
local g, bo, o, opt, wo, cmd, fn = vim.g, vim.bo, vim.o, vim.opt, vim.wo, vim.cmd, vim.fn

-- Create folders for our backups, undos, swaps and sessions if they don't exist
cmd("silent call mkdir(stdpath('data').'/undos', 'p', '0700')")
cmd("silent call mkdir(stdpath('data').'/backups', 'p', '0700')")
cmd("silent call mkdir(stdpath('data').'/swaps', 'p', '0700')")
cmd("silent call mkdir(stdpath('data').'/sessions', 'p', '0700')")

------------------------------GLOBAL VARIABLES------------------------------ {{{
Homedir = os.getenv("HOME")
Sessiondir = vim.fn.stdpath("data") .. "/sessions"
---------------------------------------------------------------------------- }}}

-------------------------------GLOBAL OPTIONS------------------------------- {{{
g.mapleader = " " -- Space is leader key
g.maplocalleader = "\\" -- \ is localleader key
g.loaded_perl_provider = 0 -- Do not load Perl
g.loaded_python_provier = 0 -- Do not load Python
g.loaded_python3_provider = 0 -- Do not load Python3
if fn.filereadable("~/.asdf/shims/python2") then
	g.python_host_prog = "~/.asdf/shims/python2"
end
if fn.filereadable("~/.asdf/shims/python3") then
	g.python3_host_prog = "~/.asdf/shims/python3"
end
---------------------------------------------------------------------------- }}}

-------------------------------BUFFER OPTIONS------------------------------- {{{
bo.autoindent = true
bo.copyindent = true -- Copy the previous indentation on autoindenting
bo.expandtab = true -- Enable the use of space in tab
bo.shiftwidth = 4 -- Number of space inserted for indentation
bo.smartindent = true -- Insert indents automatically
bo.softtabstop = 4 -- Number of spaces tabs count for
bo.tabstop = 4 -- Number of spaces in a tab
---------------------------------------------------------------------------- }}}

---------------------------------VIM OPTIONS-------------------------------- {{{
opt.background = "dark"
opt.cmdheight = 0 -- Hide the command bar
opt.clipboard = "unnamedplus" -- Use the system clipboard
opt.completeopt = { "menuone", "noselect" } -- Options for insert mode completion
opt.cursorlineopt = "screenline,number" -- Highlight the screen line of the cursor with CursorLine and the line number with CursorLineNr
opt.diffopt = opt.diffopt -- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
		+ {
			'vertical',
			'iwhite',
			'hiddenoff',
			'foldcolumn:0',
			'context:4',
			'algorithm:histogram',
			'indent-heuristic',
		}
opt.emoji = false -- Turn off emojis
opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	fold = ' ',
	eob = ' ', -- suppress ~ at EndOfBuffer
	diff = '╱', -- alternatives = ⣿ ░ ─
	msgsep = ' ', -- alternatives: ‾ ─
	foldopen = '▾',
	foldsep = '│',
	foldclose = '▸',
}
opt.formatoptions = {
	["1"] = true,
	["2"] = false, -- Don't use indent from 2nd line of a paragraph
	q = true, -- continue comments with gq"
	c = true, -- Auto-wrap comments using textwidth
	o = false, -- Don't continue comments
	r = true, -- Continue comments when pressing Enter
	n = true, -- Recognize numbered lists
	t = false, -- autowrap lines using text width value
	j = true, -- remove a comment leader when joining lines.
	-- Only break if the line was not longer than 'textwidth' when the insert
	-- started and only at a white character that has been entered during the
	-- current insert command.
	l = true,
	v = true,
}
opt.guicursor = {
	"n-v:block",
	"i-c-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}
opt.ignorecase = true -- Case insensitive searching
opt.laststatus = 3 -- Use global statusline
opt.list = true -- Invisible chars
opt.listchars = {
	eol = "↵",
	tab = '  ', -- Alternatives: '▷▷',
	extends = '›', -- Alternatives: … »
	precedes = '‹', -- Alternatives: … «
	trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}
opt.modelines = 1 -- Use for folding
opt.mouse = "a" -- Use the mouse in all modes
opt.sessionoptions = { -- Session options to store in the session
	"globals", -- global variables that start with an uppercase letter and contain at least one lowercase letter. Only String and Number types are stored.
	"buffers", -- hidden and unloaded buffers, not just those in windows
	"curdir", -- the current directory
	"winpos", -- position of the whole Vim window
	"winsize", -- window sizes
	"tabpages", -- all tab pages; without this only the current tab page is restored, so that you can make a session for each tab page separately
}
opt.scrolloff = 5 -- Set the cursor 5 lines down instead of directly at the top of the file
opt.shada = "!,'0,f0,<50,s10,h"
opt.shell = "/usr/local/bin/fish"
opt.shiftround = true -- Round indent
opt.shortmess = {
	A = true, -- Ignore annoying swap file messages
	c = true, -- Do not show completion messages in command line
	F = true, -- Do not show file info when editing a file, in the command line
	I = true, -- Do not show the intro message
	W = true, -- Do not show "written" in command line when writing
}
opt.showmatch = true -- Show matching brackets by flickering
opt.showmode = false -- Dksable showing modes in command line
opt.sidescrolloff = 8 -- The minimal number of columns to keep to the left and to the right of the cursor if 'nowrap' is set
opt.smartcase = true -- Case sensitivie searching
opt.splitbelow = true -- Splitting a new window below the current one
opt.splitright = true -- Splitting a new window at the right of the current one
opt.termguicolors = true -- True color support
opt.textwidth = 120 -- Total allowed width on the screen
opt.timeout = true -- This option and 'timeoutlen' determine the behavior when part of a mapped key sequence has been received. This is on by default but being explicit!
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.ttimeoutlen = 10 -- Time in milliseconds to wait for a key code sequence to complete
opt.updatetime = 100 -- If in this many milliseconds nothing is typed, the swap file will be written to disk. Also used for CursorHold autocommand and set to 100 as per https://github.com/antoinemadec/FixCursorHold.nvim
opt.wildmode = "longest:full,full" -- Shows a menu bar as opposed to an enormous list
opt.wildignore = {
	-- Binary
	"*.aux",
	"*.out",
	"*.toc",
	"*.o",
	"*.obj",
	"*.dll",
	"*.jar",
	"*.pyc",
	"*.rbc",
	"*.class",
	"*.gif",
	"*.ico",
	"*.jpg",
	"*.jpeg",
	"*.png",
	"*.avi",
	"*.wav",
	"*.zip",
	-- Temp/System
	"*.*~",
	"*~ ",
	"*.swp",
	".lock",
	".DS_Store",
	"tags.lock",
	-- Git
	"*/.git/*",
	-- Node modules
	"*/node_modules/*",
	-- Others
	"**/undo/**",
	"*[Cc]ache/",
} -- Ignore these files/folders

-- Backups and Swaps
opt.backupdir = vim.fn.stdpath("data") .. "/backups" -- Use backup files
opt.directory = vim.fn.stdpath("data") .. "/swaps" -- Use Swap files
opt.undofile = true -- Maintain undo history between sessions
opt.undolevels = 1000 -- Ensure we can undo a lot!
opt.undodir = vim.fn.stdpath("data") .. "/undos" -- Set the undo directory

-- Folds
o.foldlevelstart = 2
o.foldexpr = 'nvim_treesitter#foldexpr()' -- require nvim-ufo
o.foldmethod = 'expr' -- require nvim-ufo
---------------------------------------------------------------------------- }}}

-------------------------------WINDOW OPTIONS------------------------------- {{{
wo.colorcolumn = "80,120" -- Make a ruler at 80px and 120px
wo.list = true -- Show some invisible characters like tabs etc
wo.numberwidth = 2 -- Make the line number column thinner
---Note: Setting number and relative number gives you hybrid mode
---https://jeffkreeftmeijer.com/vim-number/
wo.number = true -- Set the absolute number
wo.relativenumber = true -- Set the relative number
wo.signcolumn = "yes" -- Show information next to the line numbers
wo.wrap = false -- Do not display text over multiple lines
---------------------------------------------------------------------------- }}}
