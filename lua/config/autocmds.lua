local augroup = require("utils").Augroup
local api = vim.api
local get_option = api.nvim_get_option
local set_option = api.nvim_set_option
local win_get_option = api.nvim_win_get_option
local win_set_option = api.nvim_win_set_option
local buf_get_option = api.nvim_buf_get_option
local buf_set_option = api.nvim_buf_set_option
local WinChanged = { "BufWinEnter", "WinEnter", "WinScrolled", "VimResized" }

local function is_normal_buf(nr)
  return buf_get_option(nr, "buftype") == "" and buf_get_option(nr, "buflisted")
end

-- This augroup sets 'scrolloff' and 'sidescrolloff' based on window dimensions,
-- this initial implementation sets them to 1/4 dimension.
augroup("adaptive_scrolloff", function(autocmd)
  autocmd(WinChanged, "*", function()
    local height = math.floor(vim.api.nvim_win_get_height(0) / 4)
    local width = math.floor(vim.api.nvim_win_get_width(0) / 8)

    if height ~= get_option("scrolloff") then
      set_option("scrolloff", math.max(height, 1))
    end

    if width ~= get_option("sidescrolloff") then
      set_option("sidescrolloff", math.max(width, 1))
    end
  end)
end)

-- Set 'pumheight' to 1/3 of window height
augroup("adaptive_pumheight", function(autocmd)
  autocmd(WinChanged, "*", function(args)
    if not is_normal_buf(args.buf) then
      return
    end

    local height = math.ceil(api.nvim_win_get_height(0) / 3)
    if height ~= get_option("pumheight") then
      set_option("pumheight", math.max(height, 3))
    end
  end)
end)

augroup("always_relativenumber", function(autocmd)
  autocmd("OptionSet", "number", function()
    win_set_option(0, "relativenumber", vim.v.option_new == "1")
  end)

  autocmd("OptionSet", "relativenumber", function()
    win_set_option(0, "number", vim.v.option_new == "1")
  end)
end)

augroup("highlight_postyank", function(autocmd)
  autocmd("TextYankPost", "*", function()
    vim.highlight.on_yank()
  end)
end)

augroup("macro_recording", function(autocmd)
  local opts = { title = "Macro", icon = "", timeout = 250 }

  autocmd("RecordingEnter", "*", function()
    local msg = (" 壘Recording @%s"):format(vim.fn.reg_recording())
    vim.notify(msg, vim.log.levels.INFO, opts)
  end)

  autocmd("RecordingLeave", "*", function()
    local msg = ("  Recorded @%s"):format(vim.v.event.regname)
    vim.notify(msg, vim.log.levels.INFO, opts)
  end)
end)

augroup("prewrite_action", function(autocmd)
  autocmd("BufWritePre", "*", function()
    local cursor = api.nvim_win_get_cursor(0)
    vim.cmd([[:%s/\s\+$//e]])
    api.nvim_win_set_cursor(0, cursor)
  end)
end)

augroup("cursorline_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function()
    win_set_option(0, "cursorline", not vim.w.nocursorline)
  end)

  autocmd("WinLeave", "*", function(args)
    if is_normal_buf(args.buf) and not vim.b.keep_cursor_on_leave then
      win_set_option(0, "cursorline", false)
    end
  end)
end)

augroup("relativenumber_on_current_window", function(autocmd)
  autocmd({ "BufWinEnter", "WinEnter" }, "*", function(args)
    if is_normal_buf(args.buf) and win_get_option(0, "number") then
      win_set_option(0, "relativenumber", true)
    end
  end)

  autocmd("WinLeave", "*", function(args)
    if is_normal_buf(args.buf) and win_get_option(0, "relativenumber") then
      win_set_option(0, "relativenumber", false)
    end
  end)
end)

augroup("terminalbuffer_action", function(autocmd)
  autocmd("TermOpen", "*", function(args)
    if buf_get_option(args.buf, "filetype") == "" then
      buf_set_option(args.buf, "filetype", "terminal")
    end
    vim.cmd.startinsert()
  end)
end)

augroup("disable_mini_indentscope", function(autocmd)
  autocmd({ "BufEnter", "TermOpen" }, "*", function()
    vim.b.miniindentscope_disable = vim.tbl_contains(
      { "help", "terminal", "nofile", "prompt" },
      vim.bo.buftype
    )
  end)
end)

augroup("set_tabline", function(autocmd)
  local tabline = [[%{%v:lua.require("config.extra.tabline").draw()%}]]

  -- Case: Starting with file
  autocmd("UIEnter", "*", function()
    if #vim.api.nvim_list_tabpages() > 1 then
      vim.api.nvim_set_option("tabline", tabline)
    end
  end)

  autocmd("TabNew", "*", function()
    vim.api.nvim_set_option("tabline", tabline)
  end)
end)

augroup("shiftwidth_sync", function(autocmd)
  autocmd("OptionSet", "shiftwidth", function(args)
    local shiftwidth = tonumber(vim.v.option_new)
    if shiftwidth > 0 and shiftwidth < 10000 then
      buf_set_option(args.buf, "tabstop", shiftwidth)
    end
  end)

  autocmd("OptionSet", "tabstop", function(args)
    local tabstop = tonumber(vim.v.option_new)
    buf_set_option(args.buf, "shiftwidth", tabstop)
  end)
end)

augroup("textwidth_sync", function(autocmd)
  autocmd("OptionSet", "textwidth", function(args)
    buf_set_option(args.buf, "synmaxcol", tonumber(vim.v.option_new))
  end)

  autocmd({ "BufNewFile", "BufEnter" }, "*", function(args)
    local textwidth = buf_get_option(args.buf, "textwidth")
    buf_set_option(args.buf, "synmaxcol", tonumber(textwidth))
  end)
end)
