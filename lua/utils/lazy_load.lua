-- Reference: https://github.com/NvChad/NvChad/blob/main/lua/core/lazy_load.lua
local M = {}
local autocmd = vim.api.nvim_create_autocmd

-- require("packer").loader(tb.plugins)
-- This must be used for plugins that need to be loaded just after a file
-- ex : treesitter, lspconfig etc
M.lazy_load = function(tb)
  autocmd(tb.events, {
    group = vim.api.nvim_create_augroup(tb.augroup_name, { clear = true }),
    callback = function()
      if tb.condition() then
        vim.api.nvim_del_augroup_by_name(tb.augroup_name)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if tb.plugin ~= "nvim-treesitter" then
          vim.defer_fn(function()
            require("packer").loader(tb.plugin)
            if tb.plugin == "nvim-lspconfig" then
              vim.cmd("silent! do FileType")
            end
          end, 0)
        else
          require("packer").loader(tb.plugin)
        end
      end
    end,
  })
end

-- load certain plugins only when there's a file opened in the buffer
-- if "nvim filename" is executed -> load the plugin after nvim gui loads
-- This gives an instant preview of nvim with the file opened
M.on_file_open = function(plugin_name)
  M.lazy_load({
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    augroup_name = "file_plugin_lazy_load" .. plugin_name,
    plugin = plugin_name,
    condition = function()
      local file = vim.fn.expand("%")
      return file ~= "[packer]"
        and file ~= ""
        and not file:match("^neo%-tree%s+filesystem")
    end,
  })
end

return M