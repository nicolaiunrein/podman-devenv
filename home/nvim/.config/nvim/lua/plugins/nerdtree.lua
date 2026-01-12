vim.api.nvim_create_user_command("NeotreeToggle", function()
  local manager = require("neo-tree.sources.manager")
  local renderer = require("neo-tree.ui.renderer")

  local fs = manager.get_state("filesystem")
  local git_status = manager.get_state("git_status")
  local buffers = manager.get_state("buffers")
  local window_exists = renderer.window_exists(fs)
      or renderer.window_exists(git_status)
      or renderer.window_exists(buffers)

  if window_exists then
    vim.cmd("Neotree close")
  else
    local p = vim.fn.expand("%:p")
    if vim.fn.filereadable(p) == 1 then
      vim.cmd("Neotree action=focus source=filesystem reveal_file=" .. p)
    else
      vim.cmd("Neotree action=focus source=filesystem")
    end
  end
end, {})

return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "jackielii/neo-tree-harpoon.nvim",
  },
  config = function()
    require("neo-tree").setup({
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      popup_border_style = "rounded",
      source_selector = {
        winbar = true,
      },
      close_if_last_window = false,
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        name = {
          trailing_slash = true,
          use_git_status_colors = false,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "➜",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        width = 50,
        mappings = {
          ["/"] = "noop",
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
      git_status = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    })
  end,
}
