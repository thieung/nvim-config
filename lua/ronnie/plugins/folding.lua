return {
	"kevinhwang91/nvim-ufo", -- make fold looks modern
	event = "VeryLazy",
	dependencies = {
		"kevinhwang91/promise-async",
		"jghauser/fold-cycle.nvim", -- Optional
	},
	init = function()
		require("legendary").keymaps({
			{
				itemgroup = "Folding",
				description = "Improve folding for Neovim",
				icon = " ",
				keymaps = {
					{
						"zR",
						"<cmd>lua require('ufo').openAllFolds()<CR>",
						description = "Open all folds",
					},
					{
						"zM",
						"<cmd>lua require('ufo').closeAllFolds()<CR>",
						description = "Close all folds",
					},
					{
						"zP",
						"<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<CR>",
						description = "Preview fold"
					},
					{
						"<BS>",
						function()
							require("fold-cycle").open()
						end,
						description = "Fold-cycle: open the next level of (nested) folds",
					},
					{
						"zt",
						function()
							require("fold-cycle").toggle_all()
						end,
						description = "Fold-cycle: toggle a fold and its nested folds closed/open"
					}
				},
			},
		})
	end,

	config = function()
		local opt, strwidth = vim.opt, vim.api.nvim_strwidth

		local function handler(virt_text, _, end_lnum, width, truncate, ctx)
			local result = {}
			local padding = ''
			local cur_width = 0
			local suffix_width = strwidth(ctx.text)
			local target_width = width - suffix_width

			for _, chunk in ipairs(virt_text) do
				local chunk_text = chunk[1]
				local chunk_width = strwidth(chunk_text)
				if target_width > cur_width + chunk_width then
					table.insert(result, chunk)
				else
					chunk_text = truncate(chunk_text, target_width - cur_width)
					local hl_group = chunk[2]
					table.insert(result, { chunk_text, hl_group })
					chunk_width = strwidth(chunk_text)
					if cur_width + chunk_width < target_width then
						padding = padding .. (' '):rep(target_width - cur_width - chunk_width)
					end
					break
				end
				cur_width = cur_width + chunk_width
			end

			local end_text = ctx.get_fold_virt_text(end_lnum)
			-- reformat the end text to trim excess whitespace from indentation usually the first item is indentation
			if end_text[1] and end_text[1][1] then end_text[1][1] = end_text[1][1]:gsub('[%s\t]+', '') end

			table.insert(result, { ' ⋯ ', 'UfoFoldedEllipsis' })
			vim.list_extend(result, end_text)
			table.insert(result, { padding, '' })
			return result
		end

		local ft_map = {
			org = '',
			dart = { 'lsp', 'treesitter' },
		}

		require("ufo").setup({
			-- treesitter as a main provider instead
			-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
			-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
			provider_selector = function(_, filetype)
				return ft_map[filetype] or { 'treesitter', 'indent' } -- 1st is name of main provider, 2nd is fallback
			end,
			open_fold_hl_timeout = 0,
			fold_virt_text_handler = handler,
			enable_get_fold_virt_text = true,
			preview = {
				win_config = {
					winhighlight = 'Normal:Normal,FloatBorder:Normal'
				}
			},
		})

		require("fold-cycle").setup()
	end,
}
