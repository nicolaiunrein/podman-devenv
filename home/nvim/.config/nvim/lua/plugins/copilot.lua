return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    vim.g.copilot_no_tab_map = true

    local function SuggestOneWord()
      local bar = vim.fn["copilot#TextQueuedForInsertion"]()
      return vim.split(bar, "[ .]\zs")[0]
    end

    vim.keymap.set("i", "<alt-left>", SuggestOneWord, { expr = true, remap = false })
  end,
}
