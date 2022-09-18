local augroup = require("utils").Augroup

augroup("HighlightOnYank", function(autocmd)
  autocmd("TextYankPost", "*", function()
    vim.highlight.on_yank()
  end)
end)

augroup("CursorlineOnCurrentWindow", function(autocmd)
  autocmd({ "BufEnter", "WinEnter" }, "*", function()
    vim.api.nvim_win_set_option(0, "cursorline", not vim.w.nocursorline)
  end)

  autocmd({ "BufLeave", "WinLeave" }, "*", function()
    if vim.b.keep_cursor_on_leave then
      return
    end
    vim.api.nvim_win_set_option(0, "cursorline", false)
  end)
end)

augroup("RelativeNumberOnCurrentWindow", function(autocmd)
  autocmd({ "BufEnter", "WinEnter" }, "*", function()
    if vim.api.nvim_win_get_option(0, "number") then
      vim.api.nvim_win_set_option(0, "relativenumber", true)
    end
  end)

  autocmd({ "BufLeave", "WinLeave" }, "*", function()
    vim.api.nvim_win_set_option(0, "relativenumber", false)
  end)

  autocmd("OptionSet", "number", function()
    local v = vim.api.nvim_win_get_option(0, "number")
    vim.api.nvim_win_set_option(0, "relativenumber", v)
  end)
end)

augroup("OnTerminalBuffer", function(autocmd)
  autocmd("TermOpen", "*", {
    function()
      if vim.api.nvim_buf_get_option(0, "filetype") == "" then
        vim.api.nvim_buf_set_option(0, "filetype", "terminal")
      end
    end,
    "startinsert",
  })
end)
