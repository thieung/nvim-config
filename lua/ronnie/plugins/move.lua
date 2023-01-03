return {
	"fedepujol/move.nvim", -- Move lines and blocks
	-- event = "BufReadPre",
	init = function()
		require("legendary").keymaps({
			{
				"<A-j>",
				{ n = "<cmd>MoveLine(1)<CR>", x = ":MoveBlock(1)<CR>" },
				hide = true,
				description = "Move text down",
				opts = { silent = true },
			},
			{
				"<A-k>",
				{ n = "<cmd>MoveLine(-1)<CR>", x = ":MoveBlock(-1)<CR>" },
				hide = true,
				description = "Move text up",
				opts = { silent = true },
			},
			{
				"<A-h>",
				{ n = "<cmd>MoveHChar(-1)<CR>", x = ":MoveHBlock(-1)<CR>" },
				hide = true,
				description = "Move text left",
				opts = { silent = true },
			},
			{
				"<A-l>",
				{ n = "<cmd>MoveHChar(1)<CR>", x = ":MoveHBlock(1)<CR>" },
				hide = true,
				description = "Move text right",
				opts = { silent = true },
			},
		})
	end,
}
