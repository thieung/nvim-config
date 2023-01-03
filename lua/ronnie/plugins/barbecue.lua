local M = {
	"utilyre/barbecue.nvim", -- A VS Code like winbar for Neovim
	event = "BufReadPre",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim_navic",
	},
}

function M.config()
	require("barbecue").setup({
		exclude_filetypes = { "netrw", "toggleterm", "FTerm" },
		symbols = {
			separator = "",
			ellipsis = "",
		},
		modifiers = {
			dirname = ":~:.:s?.config/nvim/lua?Neovim?",
		},
	})
end

function M.init()
	require("legendary").commands({
		{
			":Barbecue toggle",
			description = "Toggle Barbecue's winbar",
		},
	})
end

return M
