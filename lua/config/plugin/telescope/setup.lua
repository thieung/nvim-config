local telescope = require("telescope")
local actions = require("telescope.actions")

local defaults = {
  layout_strategy = "flex",
  layout_config = {
    horizontal = { preview_width = 80 },
  },
  prompt_prefix = "   ",
  selection_caret = " ",
  dynamic_preview_title = true,
  results_title = false,
  mappings = {
    n = {
      ["<esc>"] = actions.close,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
    },
    i = {
      ["<C-c>"] = actions.close,

      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<C-s>"] = actions.select_horizontal,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
    },
  },
  file_ignore_patterns = {
    "%.class",
    "%.gif",
    "%.jpg",
    "%.jpeg",
    "%.JPEG",
    "%.o",
    "%.out",
    "%.png",
    "%.PNG",
    "%.pyc",
    "%.pyi",
    "%.webp",
    "%.dart_tool/",
    "%.env/",
    "%.git/",
    "%.github/",
    "%.gradle/",
    "%.idea/",
    "%.settings/",
    "%.vscode/",
    "__pycache__/",
    "bin/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "obj/",
    "target/",
    "vendor/",
  },
}

local pickers = {}

pickers.find_files = {
  layout_config = { height = 0.50 },
  path_display = { "smart" },
  theme = "ivy",
  previewer = false,
}

pickers.buffers = {
  prompt_prefix = "   ",
  path_display = { "smart" },
  theme = "dropdown",
  previewer = false,
  mappings = {
    i = {
      ["<C-d>"] = actions.delete_buffer,
    },
  },
}

pickers.live_grep = {
  layout_config = {
    anchor = "N",
    height = 0.35,
    mirror = true,
    width = 0.55,
  },
  prompt_prefix = "   ",
  theme = "dropdown",
}

pickers.git_files = {
  prompt_prefix = "   ",
  path_display = { "smart" },
}

pickers.git_commits = {
  layout_config = pickers.live_grep.layout_config,
  prompt_prefix = "   ",
  theme = "dropdown",
}

pickers.git_branches = {
  prompt_prefix = "   ",
  theme = "dropdown",
  previewer = false,
}

pickers.git_status = {
  layout_config = {
    horizontal = {
      preview_width = 0.55,
    },
  },
  prompt_prefix = "   ",
  path_display = { "smart" },
}

pickers.lsp_document_symbols = {
  layout_config = {
    anchor = "N",
    mirror = true,
    width = 0.50,
  },
  previewer = false,
  prompt_prefix = "   ",
  theme = "dropdown",
}
pickers.lsp_workspace_symbols = {
  layout_config = { height = 0.5 },
  prompt_prefix = "   ",
  theme = "ivy",
}
pickers.lsp_references = { theme = "dropdown" }
pickers.lsp_implementations = pickers.lsp_references
pickers.lsp_definitions = pickers.lsp_references

pickers.diagnostics = {
  layout_config = { height = 0.5 },
  prompt_prefix = "   ",
  theme = "ivy",
  previewer = false,
}

local config = {
  defaults = defaults,
  pickers = pickers,
  extensions = {
    file_browser = {
      prompt_prefix = "   ",
      hide_parent_dir = true,
      collapse_dirs = true,
    },
    fzf = {},
  },
}

telescope.setup(config)

-- load extensions
local extensions = {
  "file_browser",
  "fzf",
}

for _, extension in ipairs(extensions) do
  telescope.load_extension(extension)
end
