return {
	"ThePrimeagen/refactoring.nvim", -- Refactor code like Martin Fowler
	keys = "<LocalLeader>r",
	init = function()
		require("legendary").keymaps({
			{
				itemgroup = "Refactoring",
				icon = "",
				description = "Refactor code",
				keymaps = {
					{
						"<LocalLeader>re",
						function()
							require("telescope").extensions.refactoring.refactors()
						end,
						description = "Open Refactoring.nvim",
						mode = { "n", "v", "x" },
					},
					{
						"<LocalLeader>rd",
						function()
							require("refactoring").debug.printf({ below = false })
						end,
						description = "Insert Printf statement for debugging",
					},
					{
						"<LocalLeader>rv",
						{
							n = function()
								require("refactoring").debug.print_var({ normal = true })
							end,
							x = function()
								require("refactoring").debug.print_var({})
							end,
						},
						description = "Insert Print_Var statement for debugging",
						mode = { "n", "v" },
					},
					{
						"<LocalLeader>rc",
						function()
							require("refactoring").debug.cleanup()
						end,
						description = "Cleanup debug statements",
					},
				},
			},
		})
	end,
	config = true,
}
