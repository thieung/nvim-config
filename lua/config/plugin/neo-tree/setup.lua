local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  return
end

local renderer = require("neo-tree.ui.renderer")
-- ascend to the parent or close it
local function float(state)
  local node = state.tree:get_node()
  if
    (node.type == "directory" or node:has_children()) and node:is_expanded()
  then
    state.commands.toggle_node(state)
  else
    renderer.focus_node(state, node:get_parent_id())
  end
end

-- toggle a node open or descend to it's first child
local function dive(state)
  local node = state.tree:get_node()
  if node.type == "directory" or node:has_children() then
    if not node:is_expanded() then
      if node.type == "directory" then
        require("neo-tree.sources.filesystem").toggle_directory(state, node)
      else
        state.commands.toggle_node(state)
      end
    else
      renderer.focus_node(state, node:get_child_ids()[1])
    end
  end
end

neotree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_diagnostics = false,
  source_selector = {
    winbar = true,
    content_layout = "center",
    tab_labels = {
      filesystem = " File",
      buffers = " Bufs",
      git_status = " Git",
      diagnostics = " Diagnostic",
    },
  },
  default_component_configs = {
    indent = {
      padding = 0,
      with_expanders = false,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
    },
    git_status = {
      symbols = {
        added = "",
        deleted = "",
        modified = "",
        renamed = "➜",
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    },
  },
  window = {
    position = "float",
    width = 40,
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = true,
      },
      o = "open",
      ["h"] = float,
      ["l"] = dive,
      ["c"] = {
        "copy",
        config = {
          show_path = "relative", -- "none", "relative", "absolute"
        },
      },
      ["Y"] = "copy_file_name",
      ["<C-y>"] = "copy_file_path",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    commands = {
      copy_file_name = function(state)
        local node = state.tree:get_node()
        vim.fn.setreg("+", node.name, "c")
      end,
      copy_file_path = function(state)
        local node = state.tree:get_node()
        local relative_path = node.path:sub(#state.path + 2)
        vim.fn.setreg("+", relative_path, "c")
      end,
    },
  },
  git_status = {
    window = {
      position = "float",
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(_)
        vim.opt_local.signcolumn = "auto"
      end,
    },
  },
})
