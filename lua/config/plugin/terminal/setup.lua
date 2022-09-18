local ok, terminal = pcall(require, "terminal")
if not ok then
  return
end

local term_map = require("terminal.mappings")

terminal.setup()

vim.keymap.set(
  { "n", "x" },
  "<leader>ts",
  term_map.operator_send,
  { expr = true }
)

vim.keymap.set("n", "<leader>to", term_map.toggle)
vim.keymap.set("n", "<leader>tO", term_map.toggle({ open_cmd = "enew" }))
vim.keymap.set("n", "<leader>tr", term_map.run)
vim.keymap.set(
  "n",
  "<leader>tR",
  term_map.run(nil, { layout = { open_cmd = "enew" } })
)
vim.keymap.set("n", "<leader>tk", term_map.kill)
vim.keymap.set("n", "<leader>t]", term_map.cycle_next)
vim.keymap.set("n", "<leader>t[", term_map.cycle_prev)

local lazygit = terminal.terminal:new({
  layout = { open_cmd = "float", height = 0.9, width = 0.9 },
  cmd = { "lazygit" },
  autoclose = true,
})
vim.env["GIT_EDITOR"] =
  "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"

vim.api.nvim_create_user_command("Lazygit", function(args)
  lazygit.cwd = args.args and vim.fn.expand(args.args)
  lazygit:toggle(nil, true)
end, { nargs = "?" })
