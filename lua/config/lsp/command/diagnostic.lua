local M = {}

local function opts(scope)
  return { scope = scope, focusable = false, border = "rounded" }
end

local scope = { cursor = "cursor", line = "line" }

function M.attach(bufnr)
  local api = vim.diagnostic
  local command = require("utils").Command

  command.group({
    prefix = "Diagnostic",
    buf = bufnr,
    cmds = {
      {
        name = "BufEnable",
        cmd = function()
          api.enable(0)
        end,
      },
      {
        name = "Enable",
        cmd = function()
          api.enable()
        end,
      },
      {
        name = "BufDisable",
        cmd = function(args)
          local display_opts = {}
          for _, arg in ipairs(args.fargs) do
            display_opts[arg] = false
          end

          if next(display_opts) then
            api.show(nil, 0, nil, display_opts)
          else
            api.disable(0)
          end
        end,
        opts = { nargs = "*" },
      },
      {
        name = "Disable",
        cmd = function(args)
          local display_opts = {}
          for _, arg in ipairs(args.fargs) do
            display_opts[arg] = false
          end

          if next(display_opts) then
            api.show(nil, nil, nil, display_opts)
          else
            api.disable()
          end
        end,
        opts = { nargs = "*" },
      },
      {
        name = "ShowInLine",
        cmd = function()
          api.open_float(0, opts(scope.line))
        end,
      },
      {
        name = "ShowOnCursor",
        cmd = function()
          api.open_float(0, opts(scope.cursor))
        end,
      },
      {
        name = "GoToNext",
        cmd = function()
          api.goto_next({ float = opts(scope.cursor) })
        end,
      },
      {
        name = "GoToPrev",
        cmd = function()
          api.goto_prev({ float = opts(scope.cursor) })
        end,
      },
      { name = "LocList", cmd = api.setloclist },
      { name = "QfList", cmd = api.setqflist },
    },
  })
end

return M
