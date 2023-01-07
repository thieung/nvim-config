return {
	"mrjones2014/smart-splits.nvim",
	event = "VeryLazy",
	init = function()
		local t = require("legendary.toolbox")
		require("legendary").keymaps({
			itemgroup = "Smart splits",
			icon = "ﭕ",
			description = "Better window movement and resize",
			keymaps = {
				{ '<C-h>', t.lazy_required_fn('smart-splits', 'move_cursor_left'), description = "Move to left split" },
				{ '<C-j>', t.lazy_required_fn('smart-splits', 'move_cursor_down'), description = "Move to below split" },
				{ '<C-k>', t.lazy_required_fn('smart-splits', 'move_cursor_up'), description = "Move to above split" },
				{ '<C-l>', t.lazy_required_fn('smart-splits', 'move_cursor_right'), description = "Move to right split" },
				{ '<C-Left>', t.lazy_required_fn('smart-splits', 'resize_left'), description = "Resize split left" },
				{ '<C-Right>', t.lazy_required_fn('smart-splits', 'resize_right'), description = "Resize split right" },
				{ '<C-Down>', t.lazy_required_fn('smart-splits', 'resize_down'), description = "Resize split down" },
				{ '<C-Up>', t.lazy_required_fn('smart-splits', 'resize_up'), description = "Resize split up" },
			},
		})
	end,
	config = function()
		require("smart-splits").setup({
			ignored_filetypes = {
				"nofile",
				"quickfix",
				"qf",
				"prompt",
			},
			ignored_buftypes = { "nofile" },
		})
	end,
}
