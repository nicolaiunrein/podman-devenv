local FileFormat = {
  hl = { fg = "gray" },
  provider = function()
    local fmt = " [" .. vim.bo.fileformat:upper() .. "]"
    return fmt
  end,
}

local function relative_to_git_root()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root and git_root ~= "" then
    local file_path = vim.fn.expand("%:p")
    return file_path:sub(#git_root + 2) -- +2 to remove trailing `/`
  end
  return vim.fn.expand("%:p")         -- Fallback to absolute path if not in a Git repo
end

local FileName = {
  hl = { fg = "gray" },
  provider = function()
    local fmt = " " .. relative_to_git_root()
    return fmt
  end,
}

return {
  "rebelot/heirline.nvim",
  lazy = false,
  dependencies = { "Zeioth/heirline-components.nvim" },
  config = function()
    vim.o.laststatus = 3 -- global statusline
    vim.o.showtabline = 2
    local heirline = require("heirline")
    local lib = require("heirline-components.all")
    local conditions = require("heirline.conditions")

    heirline.load_colors(lib.hl.get_colors())
    lib.init.subscribe_to_events()

    heirline.setup({
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.file_info(),
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp({
          lsp_progress = false, -- handled by fidget
        }),
        lib.component.compiler_state(),
        lib.component.virtual_env(),
        lib.component.nav(),
        FileFormat,
        lib.component.mode({ surround = { separator = "right" } }),
      },
      statuscolumn = {
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        lib.component.signcolumn(),
        lib.component.numbercolumn(),
        lib.component.foldcolumn(),
        {
          provider = function()
            return " "
          end,
        },
      },
      -- winbar = { -- UI breadcrumbs bar
      -- 	fallthrough = false,
      -- 	{
      -- 		condition = function()
      -- 			local show = not conditions.buffer_matches({
      -- 				buftype = { "nofile", "prompt", "help", "quickfix", "pum" },
      -- 				filetype = { "^git.*", "fugitive", "term", "startify", "harpoon" },
      -- 			})
      -- 			if not show then
      -- 				vim.o.winbar = ""
      -- 			else
      -- 			end
      -- 			return show
      -- 		end,
      -- 		lib.component.neotree(),
      -- 		{
      -- 			hl = "Comment",
      -- 			provider = function()
      -- 				return vim.fn.expand("%:p")
      -- 			end,
      -- 		},
      -- 	},
      -- },
      tabline = { -- UI upper bar
        hl = "TabLineFill",
        lib.component.tabline_conditional_padding({ hl = "TabLineFill" }),
        lib.component.tabline_buffers(),
        lib.component.fill(),
        FileName,
        lib.component.tabline_tabpages(),
      },
    })
  end,
}
