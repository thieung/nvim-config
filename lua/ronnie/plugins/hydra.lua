return {
	"anuvyklack/hydra.nvim",
	event = "VeryLazy",
	config = function()
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

		Hydra({
			name = 'Window management',
			config = {
				invoke_on_body = false,
				hint = hint_opts,
			},
			mode = 'n',
			body = '<C-w>',
			heads = {
				-- Split
				{ 's', '<C-w>s', { desc = 'split horizontally' } },
				{ 'v', '<C-w>v', { desc = 'split vertically' } },
				{ 'q', '<C-w>c', { desc = 'close window' } },
				-- Size
				{ 'j', '2<C-w>+', { desc = 'increase height' } },
				{ 'k', '2<C-w>-', { desc = 'decrease height' } },
				{ 'h', '5<C-w>>', { desc = 'increase width' } },
				{ 'l', '5<C-w><', { desc = 'decrease width' } },
				{ '=', '<C-w>=', { desc = 'equalize' } },
				--
				{ '<Esc>', nil, { exit = true } },
			},
		})
	end,
}
