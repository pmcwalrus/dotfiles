require "nvchad.autocmds"

local api = vim.api
local fn = vim.fn

api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if fn.argc() ~= 1 then
      return
    end

    local arg = fn.argv(0)
    if fn.isdirectory(arg) == 0 then
      return
    end

    vim.cmd.cd(arg)
    vim.cmd.enew()

    vim.schedule(function()
      local ok, nvim_tree = pcall(require, "nvim-tree.api")
      if ok then
        nvim_tree.tree.open()
      end
    end)
  end,
})
