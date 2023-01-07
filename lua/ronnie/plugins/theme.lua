return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000, -- Ensure it loads first
	init = function()
		require("legendary").commands({
			{
				":OnedarkproCache",
				description = "Cache the theme",
			},
			{
				":OnedarkproClean",
				description = "Clean the theme cache",
			},
			{
				":OnedarkproColors",
				description = "Show the theme's colors",
			},
		})
	end,
	config = function()
		local helper = require("onedarkpro.helpers")
		require("onedarkpro").setup({
			cache_path = vim.fn.expand(
				vim.fn.stdpath("cache") .. "/onedarkpro_dotfiles"
			),
			plugins = {
				barbar = false,
				copilot = false,
				lsp_saga = false,
				hop = false,
				marks = false,
				nvim_tree = false,
				polygot = false,
				op_nvim = false,
				packer = false,
				startify = false,
				telescope = false,
				toggleterm = false,
				vim_ultest = false,
				which_key = false,
			},
			styles = {
				comments = "italic",
				conditionals = "italic",
				keywords = "italic",
				virtual_text = "italic",
			},
			options = {
				cursorline = true,
				highlight_inactive_windows = false,
			},
			colors = {
				dark = {
					vim = "#81b766", -- green
					comment = "#5c6370", -- Revert back to original comment colors
					cursorline = "#2e323b",
					indentline = "#3c414d",
					buffer_color = "#939aa3",
					statusline_bg = "#2e323b", -- gray
					telescope_prompt = helper.darken('bg', 1, 'onedark'),
					telescope_results = helper.darken('bg', 4, 'onedark'),
					telescope_preview = helper.darken('bg', 6, 'onedark'),
					telescope_selection = helper.darken('bg', 8, 'onedark'),
					copilot = helper.darken('gray', 8, 'onedark'),
					breadcrumbs = helper.darken('gray', 10, 'onedark'),
				},
				light = {
					vim = "#029632", -- green
					comment = "#bebebe", -- Revert back to original comment colors
					scrollbar = "#eeeeee",
					buffer_color = "#6a6a6a",
					statusline_bg = "#f0f0f0", -- gray
					telescope_prompt = helper.darken('bg', 2, 'onelight'),
					telescope_results = helper.darken('bg', 5, 'onelight'),
					telescope_preview = helper.darken('bg', 7, 'onelight'),
					telescope_selection = helper.darken('bg', 9, 'onelight'),
					copilot = helper.lighten('gray', 8, 'onelight'),
					breadcrumbs = helper.lighten('gray', 8, 'onelight'),
				},
			},
			highlights = {
				CursorLineNr = { bg = "${cursorline}", fg = "${purple}", style = "bold" },
				DiffChange = { style = "NONE" },
				MatchParen = { fg = "${cyan}" },
				ModeMsg = { link = "LineNr" }, -- Make command line text lighter
				Search = { bg = "${selection}", fg = "${yellow}", style = "NONE" },
				TabLine = { fg = "${gray}", bg = "${bg}" },
				TabLineSel = { fg = "${bg}", bg = "${purple}" },

				-- Treesitter plugin
				["@text.todo.checked"] = { fg = "${bg}", bg = "${purple}" },

				-- Aerial plugin
				AerialClass = { fg = "${purple}", style = "bold,italic" },
				AerialClassIcon = { fg = "${purple}" },
				AerialConstructorIcon = { fg = "${yellow}" },
				AerialEnumIcon = { fg = "${blue}" },
				AerialFunctionIcon = { fg = "${red}" },
				AerialInterfaceIcon = { fg = "${orange}" },
				AerialMethodIcon = { fg = "${green}" },
				AerialStructIcon = { fg = "${cyan}" },

				-- Alpha (dashboard) plugin
				AlphaHeader = {
					fg = (vim.o.background == "dark" and "${green}" or "${red}"),
				},
				AlphaButtonText = {
					fg = "${blue}",
					style = "bold",
				},
				AlphaButtonShortcut = {
					fg = (vim.o.background == "dark" and "${green}" or "${yellow}"),
					style = "italic,bold",
				},
				AlphaFooter = { fg = "${gray}", style = "italic" },

				--Barbecue
				BarbecueModified = { fg = "${red}" },
				BarbecueEllipsis = { fg = "${breadcrumbs}", style = "italic" },
				BarbecueSeparator = { fg = "${breadcrumbs}", style = "italic" },
				BarbecueDirname = { fg = "${breadcrumbs}", style = "italic" },
				BarbecueBasename = { fg = "${breadcrumbs}", style = "italic" },
				BarbecueContext = { fg = "${breadcrumbs}", style = "italic" },

				-- Bufferline
				BufferlineVim = { fg = "${vim}" },
				BufferlineNormal = { bg = "${bg}", fg = "${gray}" },
				BufferlineSelected = { bg = "${statusline_bg}", fg = "${purple}" },
				BufferlineOffset = { fg = "${purple}", style = "bold" },

				-- Cmp
				CmpItemAbbrMatch = { fg = "${blue}", style = "bold" },
				CmpItemAbbrMatchFuzzy = { fg = "${blue}", style = "underline" },

				-- Copilot
				CopilotSuggestion = { fg = "${copilot}", style = "italic" },

				-- DAP
				DebugBreakpointLine = { fg = "${red}", style = "underline" },
				DebugHighlightLine = { fg = "${purple}", style = "italic" },
				NvimDapVirtualText = { fg = "${cyan}", style = "italic" },

				-- DAP UI
				DapUIBreakpointsCurrentLine = { fg = "${yellow}", style = "bold" },

				-- Fidget
				FidgetTask = { fg = "${gray}" },
				FidgetTitle = { fg = "${purple}", style = "italic" },

				-- Heirline
				Heirline = { bg = "${statusline_bg}" },
				HeirlineBufferline = { fg = "${buffer_color}" },

				-- Luasnip
				LuaSnipChoiceNode = { fg = "${yellow}" },
				LuaSnipInsertNode = { fg = "${yellow}" },

				-- Neotest
				NeotestAdapterName = { fg = "${purple}", style = "bold" },
				NeotestFocused = { style = "bold" },
				NeotestNamespace = { fg = "${blue}", style = "bold" },

				-- Neotree
				NeoTreeRootName = { fg = "${purple}", style = "bold" },
				NeoTreeFileNameOpened = { fg = "${purple}", style = "italic" },

				-- Telescope
				TelescopeBorder = {
					fg = "${telescope_results}",
					bg = "${telescope_results}",
				},
				TelescopePromptBorder = {
					fg = "${telescope_prompt}",
					bg = "${telescope_prompt}",
				},
				TelescopePromptCounter = { fg = "${fg}" },
				TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
				TelescopePromptPrefix = {
					fg = "${purple}",
					bg = "${telescope_prompt}",
				},
				TelescopePromptTitle = {
					fg = "${telescope_prompt}",
					bg = "${purple}",
				},

				TelescopePreviewTitle = {
					fg = "${telescope_results}",
					bg = "${green}",
				},
				TelescopeResultsTitle = {
					fg = "${telescope_results}",
					bg = "${telescope_results}",
				},

				TelescopeMatching = { fg = "${blue}" },
				TelescopeNormal = { bg = "${telescope_results}" },
				TelescopeSelection = { bg = "${telescope_selection}" },

				TelescopePreviewNormal = { bg = "${telescope_preview}" },
				TelescopePreviewBorder = {
					fg = "${telescope_preview}",
					bg = "${telescope_preview}",
				},
			},
		})
	end,
}
