return {
	{
		name = "ColorSchemeChanges",
		{
			"ColorScheme",
			function() require(namespace .. ".plugins.heirline").load() end,
			opts = {
				pattern = { "*" },
			},
		},
	},
	{
		name = "ReturnToLastEditingPosition",
		{
			"BufReadPost",
			function()
				if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
					vim.fn.setpos(".", vim.fn.getpos("'\""))
					vim.api.nvim_feedkeys("zz", "n", true)
					vim.cmd('silent! foldopen')
				end
			end,
		},
	},
	{
		name = "GitTrackRemoteBranch",
		{
			{ "TermLeave" },
			function()
				rn.GitRemoteSync()
			end,
			opts = {
				pattern = { "*" },
			},
		},
		{
			{ "VimEnter" },
			function()
				local timer = vim.loop.new_timer()
				timer:start(0, 120000, function()
					rn.GitRemoteSync()
				end)
			end,
			opts = {
				pattern = { "*" },
			},
		},
	},
	{
		name = "FiletypeOptions",
		{
			"FileType",
			":setlocal shiftwidth=2 tabstop=2",
			opts = {
				pattern = {
					"css",
					"eruby",
					"html",
					"lua",
					"javascript",
					"json",
					"ruby",
					"vue",
				},
			},
		},
		{
			"FileType",
			":setlocal shiftwidth=4 softtabstop=4 tabstop=4",
			opts = {
				pattern = {
					"go",
				},
			},
		},
		{
			"FileType",
			":setlocal wrap linebreak",
			opts = { pattern = "markdown" },
		},
		{
			"FileType",
			":setlocal showtabline=0",
			opts = { pattern = "alpha" },
		},
	},
	{
		name = "QuickfixFormatting",
		{
			{ "BufEnter", "WinEnter" },
			":if &buftype == 'quickfix' | setlocal nocursorline | setlocal number | endif",
			opts = {
				pattern = { "*" },
			},
		},
	},
	{
		name = "AddRubyFiletypes",
		{
			{ "BufNewFile", "BufRead" },
			":set ft=ruby",
			opts = {
				pattern = { "*.json.jbuilder", "*.jbuilder", "*.rake" },
			},
		},
	},
	{
		name = "ChangeMappingsInTerminal",
		{
			"TermOpen",
			function()
				if vim.bo.filetype == "" or vim.bo.filetype == "FTerm" then
					local opts = { silent = false, buffer = 0 }
					vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
					vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				end
			end,
			opts = {
				pattern = "term://*",
			},
		},
	},
	{
		name = "RemoveWhitespaceOnSave",
		{
			{ "BufWritePre" },
			[[%s/\s\+$//e]],
			opts = {
				pattern = { "*" },
			},
		},
	},
	-- Highlight text when yanked
	{
		name = "HighlightYankedText",
		{
			"TextYankPost",
			function()
				vim.highlight.on_yank()
			end,
			opts = { pattern = "*" },
		},
	},
	{
		name = "Telescope",
		{
			"User",
			":setlocal wrap",
			opts = { pattern = "TelescopePreviewerLoaded" },
		},
	},
	{
		name = "TurnOffBeaconInNorg",
		{
			"BufReadPre",
			function() require("beacon").beacon_off() end,
			opts = {
				pattern = "*.norg"
			}
		}
	}
}
