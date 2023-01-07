return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	module = 'diffview',
	init = function()
		require("legendary").keymaps({
			itemgroup = "Diffview",
			description = "Single tabpage interface to easily cycle through diffs",
			keymaps = {
				{
					"<LocalLeader>gd",
					"<cmd>DiffviewOpen<CR>",
					description = "Diffview: Open",
				},
				{
					"<LocalLeader>gh",
					"<cmd>DiffviewFileHistory<CR>",
					description = "Diffview: File history",
				},
			}
		})
	end,

	config = function()
		require('diffview').setup({
			default_args = {
				DiffviewFileHistory = { '%' },
			},
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
				},
			},
			hooks = {
				diff_buf_read = function()
					vim.wo.wrap = false
					vim.wo.list = false
					vim.wo.colorcolumn = ''
				end,
			},
			keymaps = {
				view = { q = '<Cmd>DiffviewClose<CR>' },
				file_panel = { q = '<Cmd>DiffviewClose<CR>' },
				file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
			},
		})
	end
}
