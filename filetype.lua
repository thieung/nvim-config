if not vim.filetype then return end

local filename = {
	[".env"] = "config",
	[".envrc"] = "config",
	[".yaml.sample"] = "yaml",
}

vim.filetype.add({
	extension = {
		lock = 'yaml',
	},
	filename = {
		['go.mod'] = 'gomod',
		['.gitignore'] = 'conf',
		[".eslintrc"] = "jsonc",
		[".prettierrc"] = "jsonc",
		[".babelrc"] = "jsonc",
	},
	pattern = {
		['.*%.conf'] = 'conf',
		['.*%.theme'] = 'conf',
		['.*%.env%..*'] = 'env',
	},
})
