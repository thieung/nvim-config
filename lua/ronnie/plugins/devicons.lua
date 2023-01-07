return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		-- https://github.com/yamatsum/nvim-nonicons/blob/main/lua/nvim-web-devicons/override.lua
		local palette = {
			orange = "#d18616",
			black = "#586069",
			bright_black = "#959da5",
			white = "#d1d5da",
			bright_white = "#fafbfc",
			red = "#ea4a5a",
			bright_red = "#f97583",
			green = "#34d058",
			bright_green = "#85e89d",
			yellow = "#ffea7f",
			bright_yellow = "#ffea7f",
			blue = "#2188ff",
			bright_blue = "#79b8ff",
			magenta = "#b392f0",
			bright_magenta = "#b392f0",
			cyan = "#39c5cf",
			bright_cyan = "#56d4dd",
		}
		-- https://github.com/yamatsum/nvim-nonicons/blob/main/lua/nvim-nonicons/mapping.lua
		local mapping = {
			["lua"] = "61826",
			["ruby"] = "61880",
			["rust"] = "61881",
			["vue"] = "61940",
			["eslint"] = "61981",
			["prettier"] = "61982",
			["babel"] = "61989",
			["svelte"] = "61992",
		}
		local function get(name)
			return vim.fn.nr2char(mapping[name])
		end

		require("nvim-web-devicons").setup({
			override = {
				["lua"] = {
					icon = get("lua"),
					color = palette.bright_blue,
					name = "Lua",
				},
				["rake"] = {
					icon = get("ruby"),
					color = palette.bright_red,
					name = "Rake",
				},
				["rakefile"] = {
					icon = get("ruby"),
					color = palette.bright_red,
					name = "Rakefile",
				},
				["rb"] = {
					icon = get("ruby"),
					color = palette.bright_red,
					name = "Rb",
				},
			}
		})
	end,
}
