return {
  enabled = true,
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup({
      input = {
        border = { "", " ", "", "", "", "", "", "" },
      },
      select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return {
              backend = "telescope",
              telescope = require("telescope.themes").get_cursor(),
            }
          end
        end,
      },
    })
  end,
}
