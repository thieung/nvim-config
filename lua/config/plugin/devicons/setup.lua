local nonicons = require("config.plugin.devicons.nonicons")
local devicons = require("nvim-web-devicons")

local function get(name)
  return vim.fn.nr2char(nonicons[name])
end

-- https://github.com/yamatsum/nvim-nonicons/blob/main/lua/nvim-web-devicons/override.lua
devicons.set_icon({
  ["svg"] = {
    icon = get("image"),
    color = "#FFB13B",
    name = "Svg",
  },
  ["git"] = {
    icon = get("git-commit"),
    color = "#F14C28",
    name = "GitLogo",
  },
  [".gitattributes"] = {
    icon = get("git-commit"),
    color = "#41535b",
    name = "GitAttributes",
  },
  [".gitconfig"] = {
    icon = get("git-commit"),
    color = "#41535b",
    name = "GitConfig",
  },
  [".gitignore"] = {
    icon = get("git-commit"),
    color = "#41535b",
    name = "GitIgnore",
  },
  [".gvimrc"] = {
    icon = get("vim"),
    color = "#019833",
    name = "Gvimrc",
  },
  [".npmignore"] = {
    icon = get("npm"),
    color = "#E8274B",
    name = "NPMIgnore",
  },
  [".vimrc"] = {
    icon = get("vim"),
    color = "#019833",
    name = "Vimrc",
  },
  [".zshrc"] = {
    icon = get("terminal"),
    color = "#89e051",
    name = "Zshrc",
  },
  ["Dockerfile"] = {
    icon = get("docker"),
    color = "#384d54",
    name = "Dockerfile",
  },
  ["Gemfile$"] = {
    icon = get("ruby"),
    color = "#701516",
    name = "Gemfile",
  },
  ["LICENSE"] = {
    icon = get("file-badge"),
    color = "#d0bf41",
    name = "License",
  },
  ["bash"] = {
    icon = get("terminal"),
    color = "#89e051",
    name = "Bash",
  },
  ["c"] = {
    icon = get("c"),
    color = "#599eff",
    name = "C",
  },
  ["c++"] = {
    icon = get("c-plusplus"),
    color = "#f34b7d",
    name = "CPlusPlus",
  },
  ["cc"] = {
    icon = get("c-plusplus"),
    color = "#f34b7d",
    name = "CPlusPlus",
  },
  ["conf"] = {
    icon = get("gear"),
    color = "#6d8086",
    name = "Conf",
  },
  ["cp"] = {
    icon = get("c-plusplus"),
    color = "#519aba",
    name = "Cp",
  },
  ["cpp"] = {
    icon = get("c-plusplus"),
    color = "#519aba",
    name = "Cpp",
  },
  ["css"] = {
    icon = get("css"),
    color = "#563d7c",
    name = "Css",
  },
  ["dart"] = {
    icon = get("dart"),
    color = "#03589C",
    name = "Dart",
  },
  ["db"] = {
    icon = get("database"),
    color = "#dad8d8",
    name = "Db",
  },
  ["dockerfile"] = {
    icon = get("docker"),
    color = "#384d54",
    name = "Dockerfile",
  },
  ["fish"] = {
    icon = "",
    color = "#59ccff",
    name = "Fish",
  },
  ["go"] = {
    icon = get("go"),
    color = "#519aba",
    name = "Go",
  },
  ["htm"] = {
    icon = get("html"),
    color = "#e34c26",
    name = "Htm",
  },
  ["html"] = {
    icon = get("html"),
    color = "#e34c26",
    name = "Html",
  },
  ["ico"] = {
    icon = get("image"),
    color = "#cbcb41",
    name = "Ico",
  },
  ["java"] = {
    icon = get("java"),
    color = "#cc3e44",
    name = "Java",
  },
  ["jpeg"] = {
    icon = get("image"),
    color = "#a074c4",
    name = "Jpeg",
  },
  ["jpg"] = {
    icon = get("image"),
    color = "#a074c4",
    name = "Jpg",
  },
  ["js"] = {
    icon = get("javascript"),
    color = "#cbcb41",
    name = "Js",
  },
  ["json"] = {
    icon = get("json"),
    color = "#cbcb41",
    name = "Json",
  },
  ["jsx"] = {
    icon = get("react"),
    color = "#519aba",
    name = "Jsx",
  },
  ["license"] = {
    icon = get("file-badge"),
    color = "#cbcb41",
    name = "License",
  },
  ["lua"] = {
    icon = get("lua"),
    color = "#51a0cf",
    name = "Lua",
  },
  ["makefile"] = {
    icon = get("terminal"),
    color = "#6d8086",
    name = "Makefile",
  },
  ["markdown"] = {
    icon = get("markdown"),
    color = "#519aba",
    name = "Markdown",
  },
  ["md"] = {
    icon = get("markdown"),
    color = "#519aba",
    name = "Md",
  },
  ["mdx"] = {
    icon = get("markdown"),
    color = "#519aba",
    name = "Mdx",
  },
  ["node_modules"] = {
    icon = get("npm"),
    color = "#E8274B",
    name = "NodeModules",
  },
  ["php"] = {
    icon = get("php"),
    color = "#a074c4",
    name = "Php",
  },
  ["pl"] = {
    icon = get("perl"),
    color = "#519aba",
    name = "Pl",
  },
  ["png"] = {
    icon = get("image"),
    color = "#a074c4",
    name = "Png",
  },
  ["py"] = {
    icon = get("python"),
    color = "#3572A5",
    name = "Py",
  },
  ["pyc"] = {
    icon = get("python"),
    color = "#519aba",
    name = "Pyc",
  },
  ["pyd"] = {
    icon = get("python"),
    color = "#519aba",
    name = "Pyd",
  },
  ["pyo"] = {
    icon = get("python"),
    color = "#519aba",
    name = "Pyo",
  },
  ["r"] = {
    icon = get("r"),
    color = "#358a5b",
    name = "R",
  },
  ["rake"] = {
    icon = get("ruby"),
    color = "#701516",
    name = "Rake",
  },
  ["rakefile"] = {
    icon = get("ruby"),
    color = "#701516",
    name = "Rakefile",
  },
  ["rb"] = {
    icon = get("ruby"),
    color = "#701516",
    name = "Rb",
  },
  ["rs"] = {
    icon = get("rust"),
    color = "#dea584",
    name = "Rs",
  },
  ["rss"] = {
    icon = get("rss"),
    color = "#FB9D3B",
    name = "Rss",
  },
  ["scala"] = {
    icon = get("scala"),
    color = "#cc3e44",
    name = "Scala",
  },
  ["sh"] = {
    icon = get("terminal"),
    color = "#4d5a5e",
    name = "Sh",
  },
  ["sql"] = {
    icon = get("database"),
    color = "#dad8d8",
    name = "Sql",
  },
  ["swift"] = {
    icon = get("swift"),
    color = "#e37933",
    name = "Swift",
  },
  ["toml"] = {
    icon = get("toml"),
    color = "#6d8086",
    name = "Toml",
  },
  ["ts"] = {
    icon = get("typescript"),
    color = "#519aba",
    name = "Ts",
  },
  ["tsx"] = {
    icon = get("react"),
    color = "#519aba",
    name = "Tsx",
  },
  ["vim"] = {
    icon = get("vim"),
    color = "#019833",
    name = "Vim",
  },
  ["vue"] = {
    icon = get("vue"),
    color = "#8dc149",
    name = "Vue",
  },
  ["webp"] = {
    icon = get("image"),
    color = "#a074c4",
    name = "Webp",
  },
  ["yaml"] = {
    icon = get("yaml"),
    color = "#6d8086",
    name = "Yaml",
  },
  ["yml"] = {
    icon = get("yaml"),
    color = "#6d8086",
    name = "Yml",
  },
  ["zsh"] = {
    icon = get("terminal"),
    color = "#89e051",
    name = "Zsh",
  },
  ["terminal"] = {
    icon = get("terminal"),
    color = "#31B53E",
    name = "Terminal",
  },
})

devicons.set_default_icon(get("file"), "#6d8086")
