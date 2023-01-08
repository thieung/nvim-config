return {
	"iamcco/markdown-preview.nvim",
	build = function() vim.fn["mkdp#util#install"]() end,
	ft = { 'markdown' },
	config = function()
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
	end,
}
