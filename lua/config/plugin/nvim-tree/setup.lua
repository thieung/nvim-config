local tree_cb = require("nvim-tree.config").nvim_tree_callback
local configs = {
  filters = {
    dotfiles = true,
    exclude = {},
  },
  ignore_ft_on_setup = { "alpha" },
  open_on_tab = false,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_focused_file = {
    enable = false,
    update_cwd = false,
  },
  view = {
    side = "right",
    width = 35,
    hide_root_folder = true,
    mappings = {
      list = {
        { key = { "o", "<CR>", "<2-LeftMouse>" }, cb = tree_cb("edit") },
        { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
        { key = "<C-v>", cb = tree_cb("vsplit") },
        { key = "<C-x>", cb = tree_cb("split") },
        { key = "<C-t>", cb = tree_cb("tabnew") },
        { key = "<BS>", cb = tree_cb("close_node") },
        { key = "<S-CR>", cb = tree_cb("close_node") },
        { key = "<Tab>", cb = tree_cb("preview") },
        { key = "I", cb = tree_cb("toggle_ignored") },
        { key = "H", cb = tree_cb("toggle_dotfiles") },
        { key = "R", cb = tree_cb("refresh") },
        { key = "a", cb = tree_cb("create") },
        { key = "d", cb = tree_cb("remove") },
        { key = "r", cb = tree_cb("rename") },
        { key = "<C-r>", cb = tree_cb("full_rename") },
        { key = "x", cb = tree_cb("cut") },
        { key = "c", cb = tree_cb("copy") },
        { key = "p", cb = tree_cb("paste") },
        { key = "[c", cb = tree_cb("prev_git_item") },
        { key = "]c", cb = tree_cb("next_git_item") },
        { key = "-", cb = tree_cb("dir_up") },
        { key = "q", cb = tree_cb("close") },
        { key = "g?", cb = tree_cb("toggle_help") },
      },
    },
  },
  git = {
    enable = true,
    ignore = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    icons = {
      show = {
        git = false,
      },
    },
    indent_markers = {
      enable = false,
    },
  },
}

require("nvim-tree").setup(configs)

-- hide when last
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if
      #vim.api.nvim_list_wins() == 1
      and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
    then
      vim.cmd("quit")
    end
  end,
})
