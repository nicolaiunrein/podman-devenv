-- local LspGroup = vim.api.nvim_create_augroup("Custom", {})
--
vim.api.nvim_create_autocmd("LspAttach", {
  group = LspGroup,
  callback = function(e)
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    -- 	buffer = e.buf,
    -- 	callback = function()
    -- 		vim.lsp.buf.format()
    -- 	end,
    -- 	group = LspGroup,
    -- })

    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, { desc = "Goto definition", buffer = e.buf })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, { desc = "Hover Lsp", buffer = e.buf })

    vim.keymap.set("n", "<Leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle inlay hints", buffer = e.buf })

    vim.keymap.set("n", "<leader>la", function()
      vim.lsp.buf.code_action()
    end, { desc = "Code action", buffer = e.buf })

    vim.keymap.set("n", "<leader>lR", function()
      vim.cmd(":Telescope lsp_references show_line=false layout_strategy=vertical")
    end, { desc = "Lsp References", buffer = e.buf })

    vim.keymap.set("n", "<leader>lr", function()
      vim.lsp.buf.rename()
    end, { desc = "Lsp Rename", buffer = e.buf })
  end,
})

return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false,   -- This plugin is already lazy
}
