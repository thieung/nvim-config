local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
  return
end

local current_colorscheme = os.getenv("NVIM_COLORSCHEME") or "onedark"
local C = require("colors.themes." .. current_colorscheme)
local hl_utils = require("utils").Highlight
local st_utils = require("utils").StatusLine

local function setup_colors()
  local StatusLine =
    hl_utils.get_hlgroup("StatusLine", { fg = C.white, bg = C.statusline_bg })
  local HeirlineNormal =
    hl_utils.get_hlgroup("HerlineNormal", { fg = C.blue, bg = C.statusline_bg })
  local HeirlineInsert = hl_utils.get_hlgroup(
    "HerlineInsert",
    { fg = C.green, bg = C.statusline_bg }
  )
  local HeirlineVisual = hl_utils.get_hlgroup(
    "HerlineVisual",
    { fg = C.purple, bg = C.statusline_bg }
  )
  local HeirlineReplace = hl_utils.get_hlgroup(
    "HerlineReplace",
    { fg = C.pink, bg = C.statusline_bg }
  )
  local HeirlineCommand = hl_utils.get_hlgroup(
    "HerlineCommand",
    { fg = C.yellow, bg = C.statusline_bg }
  )
  local HeirlineInactive = hl_utils.get_hlgroup(
    "HerlineInactive",
    { fg = C.special_grey, bg = C.statusline_bg }
  )
  local DiagnosticError = hl_utils.get_hlgroup("DiagnosticError")
  local DiagnosticWarn = hl_utils.get_hlgroup("DiagnosticWarn")
  local DiagnosticInfo = hl_utils.get_hlgroup("DiagnosticInfo")
  local DiagnosticHint = hl_utils.get_hlgroup("DiagnosticHint")
  local Folded = hl_utils.get_hlgroup("Folded")
  local Visual = hl_utils.get_hlgroup("Visual")

  local colors = {
    fg = StatusLine.fg,
    bg = StatusLine.bg,
    section_fg = StatusLine.fg,
    section_bg = StatusLine.bg,
    git_branch_fg = C.light_grey,
    git_branch_bg = C.statusline_bg,
    git_diff_fg = C.light_grey,
    git_diff_bg = C.statusline_bg,
    git_added = C.light_grey,
    git_changed = C.light_grey,
    git_removed = C.light_grey,
    normal = HeirlineNormal.fg,
    insert = HeirlineInsert.fg,
    visual = HeirlineVisual.fg,
    replace = HeirlineReplace.fg,
    command = HeirlineCommand.fg,
    inactive = HeirlineInactive.fg,
    blank_bg = Folded.fg,
    file_info_bg = Visual.bg,
    diag_error = DiagnosticError.fg,
    diag_warn = DiagnosticWarn.fg,
    diag_info = DiagnosticInfo.fg,
    diag_hint = DiagnosticHint.fg,
    scrollbar = StatusLine.fg,
    treesitter_fg = C.green,
  }

  for _, section in ipairs({
    "file_info",
    "git_diff",
    "diagnostics",
    "lsp",
    "treesitter",
    "nav",
  }) do
    if not colors[section .. "_bg"] then
      colors[section .. "_bg"] = colors["section_bg"]
    end
    if not colors[section .. "_fg"] then
      colors[section .. "_fg"] = colors["section_fg"]
    end
  end

  return colors
end

heirline.load_colors(setup_colors())

local heirline_opts = {
  -- first element is statusline
  {
    -- default highlight for the entire statusline
    hl = { fg = "fg", bg = "bg" },

    -- VIM mode component
    st_utils.component.mode({
      mode_text = {
        icon = { kind = "VIM", padding = { right = 1, left = 1 } },
      },
      hl = { fg = "bg", bold = true },
      surround = {
        separator = "left",
        color = function()
          return { main = st_utils.hl.mode_bg(), right = "blank_bg" }
        end,
      },
    }),

    -- Empty space component
    st_utils.component.builder({
      { provider = st_utils.provider.empty },
      surround = {
        separator = "left",
        color = { main = "blank_bg", right = "file_info_bg" },
      },
    }),

    -- FILE INFO  component
    st_utils.component.file_info({
      file_icon = { highlight = false, padding = { left = 0 } },
      padding = { right = 1 },
      surround = { separator = "left", condition = false },
      unique_path = {},
    }),

    -- GIT BRANCH component
    st_utils.component.git_branch({ surround = { separator = "none" } }),

    -- GIT DIFF component
    st_utils.component.git_diff({
      padding = { left = 1 },
      surround = { separator = "none" },
    }),

    -- fill the rest of the statusline
    -- the elements after this will appear in the right of the statusline
    st_utils.component.align(),

    -- DIAGNOSTICS component
    st_utils.component.diagnostics({ surround = { separator = "right" } }),

    -- LSP conponent
    st_utils.component.lsp({ surround = { separator = "right" } }),

    -- TREESITTER component
    st_utils.component.treesitter(),

    -- NAV component
    st_utils.component.nav(),
  },

  -- second element is winbar
  {
    fallthrough = false,
    {
      condition = function()
        return st_utils.condition.buffer_matches({
          buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
          filetype = {
            "NvimTree",
            "neo-tree",
            "dashboard",
            "Outline",
            "aerial",
          },
        })
      end,
      init = function()
        vim.opt_local.winbar = nil
      end,
    },
  },
}

heirline.setup(heirline_opts[1])

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Heirline",
  desc = "Refresh heirline colors",
  callback = function()
    heirline.reset_highlights()
    heirline.load_colors(setup_colors())
  end,
})
