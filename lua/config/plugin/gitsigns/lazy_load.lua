local augroup = require("utils").Augroup

augroup("GitSignsLazyLoad", function(autocmd)
  autocmd("BufRead", "*", function()
    vim.fn.system("git rev-parse " .. vim.fn.expand("%:p:h"))
    if vim.v.shell_error == 0 then
      vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
      vim.schedule(function()
        require("packer").loader("gitsigns.nvim")
      end)
    end
  end)
end)
