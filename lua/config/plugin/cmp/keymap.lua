local M = {}

function M.setup(cmp, snippet)
  local map = cmp.mapping
  local select_only = { behavior = cmp.SelectBehavior.Select }
  local function termcode(key)
    return vim.api.nvim_replace_termcodes(key, true, true, true)
  end
  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match("%s")
        == nil
  end

  return {
    ["<Down>"] = map.select_next_item(select_only),
    ["<Up>"] = map.select_prev_item(select_only),
    ["<C-p>"] = map({
      i = map.select_prev_item(select_only),
      c = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          vim.api.nvim_feedkeys(termcode("<Up>"), "n", true)
        end
      end,
    }),
    ["<C-n>"] = map({
      i = map.select_next_item(select_only),
      c = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          vim.api.nvim_feedkeys(termcode("<Down>"), "n", true)
        end
      end,
    }),
    ["<C-b>"] = map.scroll_docs(-4),
    ["<C-f>"] = map.scroll_docs(4),
    ["<C-Space>"] = map.complete(),
    ["<C-e>"] = map(map.abort(), { "i", "c" }),
    ["<C-y>"] = map(map.confirm({ select = true }), { "i", "c" }),
    ["<CR>"] = map.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
    ["<C-j>"] = map(function(fallback)
      if snippet.expand_or_jumpable() then
        snippet.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = map(function(fallback)
      if snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = map(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippet.expandable() then
        snippet.expand()
      elseif snippet.expand_or_jumpable() then
        snippet.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = map(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

return M
