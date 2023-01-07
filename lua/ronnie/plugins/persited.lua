return {
	"olimorris/persisted.nvim", -- Session management
	event = "BufReadPre",
	init = function()
		require("legendary").keymaps({
			{
				itemgroup = "Persisted",
				icon = "",
				description = "Session management",
				keymaps = {
					{
						"<Leader>s",
						'<cmd>lua require("persisted").toggle()<CR>',
						description = "Toggle a session",
						opts = { silent = true },
					},
				},
			},
		})

		require("legendary").commands({
			{
				itemgroup = "Persisted",
				commands = {
					{
						":Sessions",
						function() vim.cmd([[Telescope persisted]]) end,
						description = "List sessions",
					},
					{
						":SessionSave",
						description = "Save the session",
					},
					{
						":SessionStart",
						description = "Start a session",
					},
					{
						":SessionStop",
						description = "Stop the current session",
					},
					{
						":SessionDelete",
						description = "Delete the current session",
					},
				},
			},
		})
	end,
	config = function()
		local persisted = require("persisted")
		persisted.setup({
			save_dir = Sessiondir .. "/",
			branch_separator = "@@",
			use_git_branch = true,
			silent = true,
			should_autosave = function()
				if vim.bo.filetype == "alpha" then return false end
				return true
			end,
			telescope = {
				before_source = function()
					vim.api.nvim_input("<ESC>:%bd!<CR>")
					persisted.stop()
				end,
			},
		})

		require("telescope").load_extension("persisted")
	end,
}
