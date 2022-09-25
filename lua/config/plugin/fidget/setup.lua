local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  return
end

local config = {}

config.text = {
  spinner = "dots",
  done = "✓",
}

config.window = {
  relative = "editor",
  blend = vim.api.nvim_get_option("pumblend"),
}

config.fmt = {
  stack_upwards = false,
  task = function(task_name, message, percentage)
    local pct = percentage and string.format(" (%s%%)", percentage) or ""
    if task_name then
      return string.format("%s%s [%s]", message, pct, task_name)
    else
      return string.format("%s%s", message, pct)
    end
  end,
}

config.sources = {
  ["null-ls"] = {
    ignore = true,
  },
}

fidget.setup(config)
