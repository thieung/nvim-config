local present, blankline = pcall(require, "indent_blankline")
if not present then
  return
end

local options = {
  filetype_exclude = {
    "help",
    "terminal",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "NvimTree",
    "neo-tree",
    "Trouble",
  },
  buftype_exclude = {
    "terminal",
    "nofile",
  },
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
  show_trailing_blankline_indent = false,
  show_current_context = true,
  use_treesitter = true,
  char = "▏",
  context_char = "▏",
}

blankline.setup(options)
