local M = {
	"numToStr/FTerm.nvim", -- Floating terminal
	event = "CursorHold",
	module = "FTerm",
}

function M.config()
	require("FTerm").setup({
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	})

	require("legendary").keymaps({
		{
			"<LocalLeader>'",
			'<CMD>lua require("FTerm").toggle()<CR>',
			description = "Toggle FTerm",
			mode = { "n", "t" },
		},
	})

end

-- function M.init()
-- end

return M
