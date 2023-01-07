return {
	"utilyre/barbecue.nvim", -- A VS Code like winbar for Neovim
	event = "BufReadPre",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim_navic",
	},
	init = function()
		require("legendary").commands({
			{
				":Barbecue toggle",
				description = "Toggle Barbecue's winbar",
			},
		})
	end,
	config = function()
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
	end,
}
