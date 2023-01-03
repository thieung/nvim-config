return {
	"j-hui/fidget.nvim", -- Display LSP status messages in a floating window
	config = {
		text = {
			spinner = "line",
			done = "",
		},
		window = {
			blend = 0,
		},
		sources = {
			["null-ls"] = {
				ignore = true, -- Ignore annoying code action prompts
			},
		},
	},
}
