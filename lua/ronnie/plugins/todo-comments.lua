return {
	"folke/todo-comments.nvim", -- Highlight and search for todo comments within the codebase
	cmd = { "TodoTrouble", "TodoTelescope" },
	init = function()
		require("legendary").keymaps({
			{
				"<Leader>t",
				"<cmd>TodoTelescope<CR>",
				description = "Search through all project todos with Telescope"
			},
			{
				"<Leader>T",
				"<cmd>TodoTrouble<CR>",
				description = "List all project todos in trouble.nvim"
			},
			{ "]t",
				function()
					require("todo-comments").jump_next()
				end,
				description = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				description = "Previous todo comment",
			},
		})
	end,
	config = {
		signs = false,
		highlight = {
			keyword = "bg",
		},
		keywords = {
			FIX = { icon = " " }, -- Custom fix icon
		},
	},
}
