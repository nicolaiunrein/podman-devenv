return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "gbrlsnchs/telescope-lsp-handlers.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { ".git/", "target/", "dist/", "node_modules/", ".cargo/" },
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 0.4,
        },
        border = {},
        borderchars = { "–", " ", " ", " ", " ", " ", " ", " " },
        sorting_strategy = "ascending",
        file_sorter = require("telescope.sorters").fuzzy_with_index_bias, -- or get_fzy_sorter
        generic_sorter = require("telescope.sorters").fuzzy_with_index_bias, -- or get_fzy_sorter
      },
    })
    telescope.load_extension("lsp_handlers")
  end,
}
