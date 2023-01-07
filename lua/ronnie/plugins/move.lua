return {
	"fedepujol/move.nvim", -- Move lines and blocks
	event = "BufReadPost",
	init = function()
		require("legendary").keymaps({
			{
				"<S-j>",
				{
					n = "<cmd>MoveLine(1)<CR>", x = ":'<,'>MoveBlock(1)<CR>"
				},
				hide = true,
				description = "Move text down",
				opts = { silent = true },
			},
			{
				"<S-k>",
				{
					n = "<cmd>MoveLine(-1)<CR>", x = ":'<,'>MoveBlock(-1)<CR>"
				},
				hide = true,
				description = "Move text up",
				opts = { silent = true },
			},
			{
				"<S-h>",
				{
					n = "<cmd>MoveHChar(-1)<CR>", x = ":'<,'>MoveHBlock(-1)<CR>"
				},
				hide = true,
				description = "Move text left",
				opts = { silent = true },
			},
			{
				"<S-l>",
				{
					n = "<cmd>MoveHChar(1)<CR>", x = ":'<,'>MoveHBlock(1)<CR>"
				},
				hide = true,
				description = "Move text right",
				opts = { silent = true },
			},
		})
	end,
}
