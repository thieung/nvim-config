return {
	"NvChad/nvim-colorizer.lua", -- Highlight hex and rgb colors within Neovim
	cmd = "ColorizerToggle",
	init = function()
		require("legendary").commands({
			{
				":ColorizerToggle",
				description = "Colorizer toggle",
			},
		})
	end,
	config = {
		filetypes = {
			"css",
			eruby = { mode = "foreground" },
			html = { mode = "foreground" },
			"lua",
			"javascript",
			"vue",
		},
	},
}
