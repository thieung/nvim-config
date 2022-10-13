local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, snippet = pcall(require, "luasnip")
local loader_ok, loader = pcall(require, "luasnip/loaders/from_vscode")

if not (cmp_ok and luasnip_ok and loader_ok) then
  return
end

snippet.config.set_config({ history = true })

-- Load available snippets
loader.lazy_load({ paths = { "./misc/snippets" } })
loader.lazy_load()

local COMPLETION_KIND = require("const.LSP_KIND").Completion

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local config = {
  preselect = cmp.PreselectMode.None, -- preselect mode (none | item)
  mapping = require("config.plugin.cmp.keymap").setup(cmp, snippet),
  experimental = { ghost_text = true }, -- experimental config
  completion = { keyword_length = 2 }, -- completion config
}

-- Snippet configuration
config.snippet = {
  expand = function(args)
    snippet.lsp_expand(args.body) -- set snippet engine is luasnip
  end,
}

-- Formatting configuration
local formatting = {}
formatting.fields = { "kind", "abbr", "menu" }
formatting.format = function(_, item)
  local kind = item.kind
  local kind_hl_group = ("CmpItemKind%s"):format(kind)

  item.kind_hl_group = kind_hl_group
  item.kind = (" %s "):format(COMPLETION_KIND[kind].icon)

  item.menu_hl_group = kind_hl_group
  item.menu = kind

  local half_win_width = math.floor(vim.api.nvim_win_get_width(0) / 2)
  if vim.api.nvim_strwidth(item.abbr) > half_win_width then
    item.abbr = ("%s…"):format(item.abbr:sub(1, half_win_width))
  end
  item.abbr = ("%s "):format(item.abbr)

  return item
end
config.formatting = formatting

-- Sources configuration
local max = vim.api.nvim_get_option("pumheight")
local half = math.floor(max / 2)
config.sources = {
  { name = "luasnip", max_item_count = max, group_index = 1 },
  { name = "nvim_lsp", max_item_count = half, group_index = 1 },
  { name = "path", keyword_length = 1, max_item_count = max, group_index = 2 },
  { name = "buffer", max_item_count = half, group_index = 3 },
}

-- Window configuration
config.window = {
  completion = {
    border = border("CmpBorder"),
    winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    col_offset = -3,
    side_padding = 0,
  },
  documentation = {
    border = "rounded",
    winhighlight = "Search:None",
    max_width = 80,
    max_height = 12,
  },
}

cmp.setup(config)

-- Set configuration for specific filetype
cmp.setup.filetype("lua", {
  sources = {
    { name = "nvim_lsp", max_item_count = max, group_index = 1 },
    { name = "nvim_lua", max_item_count = max, group_index = 1 },
    { name = "luasnip", max_item_count = half, group_index = 2 },
    { name = "path", max_item_count = max, group_index = 3 },
    { name = "buffer", max_item_count = half, group_index = 4 },
  },
})

-- Use buffer & nvim_lsp_document_symbol source for `/`
cmp.setup.cmdline("/", {
  completion = { keyword_length = 1 },
  sources = {
    { name = "nvim_lsp_document_symbol", max_item_count = max },
    { name = "buffer", max_item_count = half },
  },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  completion = { keyword_length = 1 },
  formatting = {
    fields = { "abbr" },
    format = function(_, item)
      item.kind = nil
      return item
    end,
  },
  sources = { { name = "cmdline" }, { name = "path" } },
  window = {
    completion = {
      side_padding = 1,
    },
  },
})
