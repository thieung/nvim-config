return {
	"numToStr/FTerm.nvim", -- Floating terminal
	event = "CursorHold",
	module = "FTerm",
	init = function()
		local fterm = require("FTerm")
		require("legendary").keymaps({
			{
				"<A-i>",
				function()
					fterm.toggle()
				end,
				description = "Toggle FTerm",
				mode = { "n", "t" },
			},
			{
				"<A-g>",
				function()
					fterm:new({
						cmd = { 'gitui' },
						dimensions = { height = 0.9, width = 0.9 },
					}):open()
				end,
				description = "Open GitUI in a floating terminal"
			},
			{
				"<A-b>",
				function()
					fterm:new({
						cmd = "btop"
					}):open()
				end,
				description = "Open Btop in a floating terminal"
			}
		})
	end,
	config = {
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	},
}
