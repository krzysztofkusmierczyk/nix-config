return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require("telescope").setup {
        -- pickers = {
        --   find_files = {
        --     theme = "ivy"
        --   }
        -- },
        extensions = {
          fzf = {}
        },
      }
      local builtin = require 'telescope.builtin'
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind files" })
      vim.keymap.set("n", "<leader>fn",
        function()
          builtin.find_files { cwd = vim.fn.stdpath("config") }
        end,
        { desc = "[F]ind [N]vim config files" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind help tags" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    end
  }
}
