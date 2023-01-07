-- Set the global variable
_G.rn = {}

-- Namespace the config in order to reload modules more easily
-- Ref: https://www.reddit.com/r/neovim/comments/puuskh/comment/he5vnqc
_G.namespace = "ronnie" -- name of my son <3

-- Load configurations
require(namespace .. ".globals")
require(namespace .. ".utils.functions")
require(namespace .. ".options")
require(namespace .. ".lazy")

if vim.o.background == "light" then
	vim.cmd([[colorscheme onelight]])
else
	vim.cmd([[colorscheme onedark]])
end
