return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },

  config = function()
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = "1"

    vim.keymap.set("n", "z?", function()
      require("ufo").peekFoldedLinesUnderCursor()
    end, { desc = "Peek folded lines", noremap = true })

    vim.keymap.set("n", "zM", function()
      require("ufo").closeFoldsWith(0)
    end, { desc = "Close folds", noremap = true })

    vim.keymap.set("n", "zR", function()
      require("ufo").openAllFolds()
    end, { desc = "Open all folds", noremap = true })

    vim.keymap.set("n", "zm", ":foldclose<cr>", { desc = "Close fold under cursor", noremap = true })
    vim.keymap.set("n", "zr", ":foldopen<cr>", { desc = "Open fold under cursor", noremap = true })
    vim.keymap.set("n", "zz", "za", { desc = "Toggle fold under cursor", noremap = true })

    require("ufo").setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
  end,
}
