return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("todo-comments").setup({ signs = false })

      local jump_opts = { keywords = { "TODO", "FIXME" } }
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next(jump_opts)
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev(jump_opts)
      end, { desc = "Previous todo comment" })
      -- TODO: Define a shortcut to show Telescope with TOODOs
    end
  },
}
