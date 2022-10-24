local Highlight = {}

--- Get highlight properties for a given highlight name
-- @param name highlight group name
-- @return table of highlight group properties
function Highlight.get_hlgroup(name, fallback)
  local hl = vim.fn.hlexists(name) == 1
      and vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
    or {}
  return require("utils").General.default_tbl(
    vim.o.termguicolors
        and { fg = hl.foreground, bg = hl.background, sp = hl.special }
      or { cterfm = hl.foreground, ctermbg = hl.background },
    fallback
  )
end

return Highlight
