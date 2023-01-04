local M = {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	module = 'diffview',
}

function M.init()
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
end

function M.config()
	require('diffview').setup({
		default_args = {
			DiffviewFileHistory = { '%' },
		},
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
		enhanced_diff_hl = true,
		keymaps = {
			view = { q = '<Cmd>DiffviewClose<CR>' },
			file_panel = { q = '<Cmd>DiffviewClose<CR>' },
			file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
		},
	})
end

return M
