return {
	"rainbowhxch/beacon.nvim", -- see your cursor jump
	event = "BufReadPre",
	config = function()
		require("beacon").setup({
			minimal_jump = 20,
			ignore_buffers = {
				"terminal",
				"nofile",
				"neorg://Quick Actions"
			},
			ignore_filetypes = {
				"qf",
				"neo-tree",
				"trouble",
				"fterm"
			},
		})
	end,
}
