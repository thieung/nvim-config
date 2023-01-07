return {
	"stevearc/dressing.nvim", -- Utilises Neovim new UI hooks to manage inputs, selects etc
	event = "VeryLazy",
	init = function()
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.select(...)
		end
		vim.ui.input = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			return vim.ui.input(...)
		end
	end,
	config = function()
		require("dressing").setup({
			input = {
				default_prompt = "> ",
				relative = "editor",
				prefer_width = 50,
				prompt_align = "center",
				win_options = { winblend = 0 },
			},
			select = {
				get_config = function(opts)
					opts = opts or {}
					local config = {
						telescope = {
							layout_config = {
								width = 0.8,
							},
						},
					}
					if opts.kind == "legendary.nvim" then
						config.telescope.sorter =
						require("telescope.sorters").fuzzy_with_index_bias({})
					end
					return config
				end,
			},
		})
	end,
}
