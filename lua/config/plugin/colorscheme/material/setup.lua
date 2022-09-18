vim.g.material_style = "deep ocean" -- deep ocean, oceanic, palenight, darker

require("material").setup({
  contrast = {
    sidebar = true,
  },
  italics = {
    comments = true,
    keywords = true,
  },
  async_loading = true,
  disable = {
    colored_cursor = true,
  },
})

vim.cmd("colorscheme material")

local c = require("material.colors")

require("utils").Highlight.colorscheme(function(h)
  local set, link, fg, bg, blend = h.set, h.link, h.fg, h.bg, h.blend

  -- highlight-default
  set("ColorColumn", { bg = blend(c.bg_alt, c.bg, 0.3) })
  set("CursorColumn", { bg = blend(c.highlight, c.bg, 0.3) })
  link("CursorLine", "CursorColumn")
  set("StatusLine", { fg = c.text, bg = c.bg_alt })
  link("TabLine", "StatusLine")
  link("TablineFill", "TabLine")
  set("TabLineSel", { inherit = "Normal", fg = c.accent })
  set("VertSplit", { fg = bg("StatusLine"), cterm = { reverse = true } })
  link("WinSeparator", "VertSplit")
end)
