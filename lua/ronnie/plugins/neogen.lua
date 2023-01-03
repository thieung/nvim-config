return {
	"danymat/neogen", -- Annotation generator
	cmd = "Neogen",
	init = function()
		require("legendary").commands({
			{
				":Neogen",
				description = "Generate annotation",
			},
		})
	end,
	config = {
		snippet_engine = "luasnip",
	},
}
