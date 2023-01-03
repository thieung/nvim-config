local M = {
	"anuvyklack/hydra.nvim",
	event = "VeryLazy",
}

function M.config()
	local Hydra = require("hydra")
	local hint_opts = {
		position = 'bottom',
		type = 'window',
	}

	Hydra({
		name = 'Folds',
		mode = 'n',
		body = '<leader>z',
		color = 'teal',
		config = {
			invoke_on_body = true,
			hint = hint_opts,
			on_enter = function() vim.cmd('BeaconOff') end, -- require DanilaMihailov/beacon.nvim plugin
			on_exit = function() vim.cmd('BeaconOn') end, -- require DanilaMihailov/beacon.nvim plugin
		},
		heads = {
			{ 'j', 'zj', { desc = 'next fold' } },
			{ 'k', 'zk', { desc = 'previous fold' } },
			{ 'l', require('fold-cycle').open_all, { desc = 'open folds underneath' } }, -- require fold-cycle plugin
			{ 'h', require('fold-cycle').close_all, { desc = 'close folds underneath' } }, -- require fold-cycle plugin
			{ '<Esc>', nil, { exit = true, desc = 'Quit' } },
		},
	})
end

return M
