return {
	"cshuaimin/ssr.nvim", -- Advanced search and replace using Treesitter
	init = function()
		require("legendary").keymaps({
			itemgroup = "Find and Replace",
			keymaps = {
				{
					"<LocalLeader>sr",
					function() require("ssr").open() end,
					description = "Structured search and replace",
				},
			},
		})
	end,
	config = {
		keymaps = {
			replace_all = "<C-CR>",
		},
	},
}
