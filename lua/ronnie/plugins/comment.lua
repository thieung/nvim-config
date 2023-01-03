return {
	"numToStr/Comment.nvim", -- Comment out lines with gcc
	event = "VeryLazy",
	init = function()
		require("legendary").keymaps({
			{
				":Comment",
				{
					n = "gcc",
					v = "gc",
				},
				description = "Toggle comment",
			},
		})
	end,
	config = true,
}
