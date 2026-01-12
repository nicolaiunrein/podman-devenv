------------------------------------------------------
--------------------- Buildin ------------------------
------------------------------------------------------

local function close_harpoon()
  if vim.bo.filetype == "harpoon" then
    vim.cmd("q")
  end
end

local function normal_esc()
  vim.cmd("nohlsearch")
  close_harpoon()
end

-- Basics
-- TODO: decide on a keybinding for this. For now keep both
vim.keymap.set("n", "<Leader>jk", function()
  normal_esc()
end, { desc = "Cleanup" })

vim.keymap.set("n", "<Leader><CR>", function()
  normal_esc()
end, { desc = "Cleanup" })

vim.keymap.set("n", "<CR>", function()
  close_harpoon()
end, { desc = "Close harpoon" })

vim.keymap.set("n", "s", "<C-^>", { desc = "Alternate buf" })

vim.keymap.set("v", "<TAB>", ">gv", { desc = "Indent xelection" })
vim.keymap.set("v", "<S-TAB>", "<gv", { desc = "Unindent selection" })

vim.keymap.set("n", "<Leader>w", "<CMD>:w<CR>", { desc = "Save" })
vim.keymap.set("n", "<Leader>q", "<CMD>:bd<CR>", { desc = "Close Buffer", noremap = true })
vim.keymap.set("n", "<Leader>Q", "<CMD>:%bdelete<CR>", { desc = "Close All Buffers", noremap = true })

-- Search
vim.keymap.set("n", "f", "/<C-r><C-w><CR>", { desc = "Search under cursor" })
vim.keymap.set("n", "F", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", { desc = "Search and replace under cursor" })
vim.keymap.set("v", "f", "y/<C-R>=substitute(escape(@\",'/'),'\\n','\\\\n','g')<CR><CR>", { desc = "search selection" })
vim.keymap.set(
  "v",
  "F",
  "y:%sno/\\V<C-R>=substitute(escape(@\",'/'),'\\n','\\\\n','g')<CR>//g<Left><Left>",
  { desc = "search and replace selection" }
)

-- Navigation
vim.keymap.set("n", "j", "gj", { desc = "Move down visual line" })
vim.keymap.set("n", "k", "gk", { desc = "Move up visual line" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split", noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split", noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split", noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split", noremap = true })

-- -- Code Navigation
-- vim.keymap.set("n", "aaa", function()
-- 	require("nvim-treesitter/nvim-treesitter")
-- 	local ts = require("nvim-treesitter.incremental-selection")
-- 	print(vim.inspect(ts))
-- end, { desc = "Incremental selection", noremap = true })
-- vim.keymap.set("n", "-", function()
-- 	require("nvim-treesitter.incremental-selection").scope_incremental()
-- end, { desc = "Scope incremental selection", noremap = true })
-- vim.keymap.set("n", "<C-'>", function()
-- 	require("nvim-treesitter.incremental-selection").node_decremental()
-- end, { desc = "Node decremental selection", noremap = true })
--
-- vim.keymap.set("v", "<C-;>", function()
-- 	require("nvim-treesitter.incremental-selection").node_incremental()
-- end, { desc = "Incremental selection", noremap = true })
-- vim.keymap.set("v", "-", function()
-- 	require("nvim-treesitter.incremental-selection").scope_incremental()
-- end, { desc = "Scope incremental selection", noremap = true })
-- vim.keymap.set("v", "<C-'>", function()
-- 	require("nvim-treesitter.incremental-selection").node_decremental()
-- end, { desc = "Node decremental selection", noremap = true })

-- TODO: Is this correct?
-- NOTE: "<C-[>" sends the <Esc> key-code
-- https://www.reddit.com/r/neovim/comments/zxup26/how_to_map_c_without_affecting_esc/
vim.keymap.set("n", "<[>", "<C-o>", { desc = "Jump back", noremap = true })
vim.keymap.set("n", "<{>", "<C-i>", { desc = "Jump next", noremap = true })

-- same key for german layout
vim.keymap.set("n", "ü", "<C-o>", { desc = "Jump next", noremap = true })
vim.keymap.set("n", "Ü", "<C-i>", { desc = "Jump back", noremap = true })

vim.keymap.set("v", "<", function()
  vim.api.nvim_feedkeys("y", "v", false)
  vim.api.nvim_feedkeys("`<", "n", false)
end, { desc = "Goto start of node", noremap = true })

vim.keymap.set("v", ">", function()
  vim.api.nvim_feedkeys("y", "v", false)
  vim.api.nvim_feedkeys("`>", "n", false)
end, { desc = "Goto end of node", noremap = true })

-- Indent Blankline
vim.keymap.set("n", "<space>i", function()
  local config = require("ibl.config").default_config
  local node = require("ibl.scope").get(0, config)
  if not node then
    return
  end
  local start = node:start()
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
  vim.cmd([[normal! _]])
end)

-- smarter line movements
vim.keymap.set("n", "H", function()
  -- get position of first non-whitespace character
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local s = vim.api.nvim_buf_get_lines(0, line - 1, line, ".")
  local jump_to = vim.fn.match(s[1], "\\S")

  if jump_to >= col then
    jump_to = 0
  end

  vim.api.nvim_win_set_cursor(0, { line, jump_to })
end, { desc = "Move to start of line (smart)", noremap = true })

vim.keymap.set("n", "L", function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local s = vim.api.nvim_buf_get_lines(0, line - 1, line, ".")
  local jump_to = vim.fn.match(s[1], "\\S")

  if jump_to <= col then
    jump_to = #s[1]
  end

  vim.api.nvim_win_set_cursor(0, { line, jump_to })
end, { desc = "Move to end of line (smart)", noremap = true })

-- GIT
-- m is chosen because it is next to n for next prev and g for git is taken in vim already
vim.keymap.set("n", "m", "<CMD>Gitsigns next_hunk<CR>", { desc = "Goto next hunk" })
vim.keymap.set("n", "M", "<CMD>Gitsigns prev_hunk<CR>", { desc = "Goto prev hunk" })
vim.keymap.set("n", "<Leader>gp", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })
vim.keymap.set("n", "<Leader>gpp", "<CMD>Gitsigns preview_hunk_inline<CR>", { desc = "Git preview hunk" })
vim.keymap.set("n", "<Leader>gr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })

-- Spelling
vim.keymap.set("n", "zx", function()
  vim.opt.spell = not vim.opt.spell
end, { desc = "Toggle spelling" })

-- trigger spelling suggestions more easily
vim.keymap.set("n", ",,,", "<CMD>1z=<CR>", { desc = "Spelling suggestions" })

------------------------------------------------------
--------------------- Plugins ------------------------
------------------------------------------------------

-- Fidget
vim.keymap.set("n", "<Leader>hi", "<CMD>Fidget history<CR>", { desc = "Fidget history" })

-- Easypick

-- convert the following
vim.keymap.set("n", "<Leader><Leader><Leader>", function()
  vim.cmd("Easypick changed_files")
end, { desc = "Pick changed files against master/main" })

-- Neotree
vim.keymap.set("n", "<CR>", "<cmd>NeotreeToggle<cr>", { desc = "Toggle neotree", noremap = true })

-- Telescope
vim.keymap.set("n", "<Leader><Leader>", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<Leader>ts", "<CMD>Telescope git_status<CR>", { desc = "Pick changed files" })
vim.keymap.set("n", "<Leader>tt", "<CMD>Telescope treesitter<CR>", { desc = "Pick changed files" }) -- TODO: helpful ?
vim.keymap.set("n", "<Leader>tg", "<CMD>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<Leader>tb", "<CMD>Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<Leader>th", "<CMD>Telescope help_tags<CR>", { desc = "Find help tags" })
vim.keymap.set("n", "<Leader>tc", "<CMD>Telescope commands<CR>", { desc = "Find commands" })
-- vim.keymap.set("n", "<Leader>tr", "<CMD>Telescope registers<CR>", { desc = "Find registers" })
-- vim.keymap.set("n", "<Leader>tm", "<CMD>Telescope marks<CR>", { desc = "Find marks" })
vim.keymap.set("n", "<Leader>th", "<CMD>Telescope oldfiles<CR>", { desc = "Telescope file history" })
-- vim.keymap.set("n", "<Leader>tl", "<CMD>Telescope loclist<CR>", { desc = "Find loclist" })
-- vim.keymap.set("n", "<Leader>tq", "<CMD>Telescope quickfix<CR>", { desc = "Find quickfix" })
vim.keymap.set("n", "<Leader>ts", "<CMD>Telescope spell_suggest<CR>", { desc = "Find spell suggestions" })
-- vim.keymap.set("n", "<Leader><Leader><Leader>", "<CMD>Telescope builtin<CR>", { desc = "Find files" })
vim.keymap.set("n", "<Leader>tt", "<CMD>Telescope builtin<CR>", { desc = "Find filetypes" })
vim.keymap.set("n", "<Leader>le", "<CMD>Telescope diagnostics<CR>", { desc = "Telescope diagnostics" })

local function notify_git_branch(branch)
  vim.notify(branch, nil, { timeout = 3000, title = "Diff against", level = "normal", icon = "" })
end

vim.keymap.set("n", "<Leader>0", "<CMD>Neotree focus harpoon-buffers reveal<CR>", { desc = "Neotree harpoon" })
vim.keymap.set("n", "<Leader>1", "<CMD>Neotree focus filesystem reveal<CR>", { desc = "Neotree fs" })
vim.keymap.set("n", "<Leader>2", "<CMD>Neotree focus buffers reveal<CR>", { desc = "Neotree buffers" })
vim.keymap.set("n", "<Leader>3", "<CMD>Neotree focus git_status git_base=HEAD reveal<CR>", { desc = "Neotree git" })
vim.keymap.set("n", "<Leader>4", function()
  local current_upstream = vim.fn.system('git rev-parse --abbrev-ref --symbolic-full-name "@{u}"')
  notify_git_branch(current_upstream)
  vim.cmd("Neotree focus git_status reveal git_base=" .. current_upstream)
end, { desc = "Neotree git upstream" })

vim.keymap.set("n", "<Leader>5", function()
  local branches = vim.fn.system("git branch --list")
  if string.find(branches, "master") then
    notify_git_branch("master")
    vim.cmd("Neotree focus git_status git_base=master reveal")
  elseif string.find(branches, "main") then
    notify_git_branch("main")
    vim.cmd("Neotree focus git_status git_base=main reveal")
  end
end, { desc = "Neotree git master" })

vim.keymap.set("n", "<Leader>6", function()
  local branches = vim.fn.system("git branch --list")
  if string.find(branches, "origin/main") then
    notify_git_branch("origin/main")
    vim.cmd("Neotree focus git_status git_base=origin/main reveal")
  elseif string.find(branches, "master") then
    notify_git_branch("origin/master")
    vim.cmd("Neotree focus git_status git_base=origin/master reveal")
  end
end, { desc = "Neotree git master" })

-- Plugins
vim.keymap.set("i", "<C-L>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

-- Git
vim.keymap.set("n", "<Leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git toggle current line Blame" })

vim.keymap.set("n", "<Leader>gB", function()
  require("gitsigns").blame()
end, { desc = "Git toggle Blame" })

vim.keymap.set("n", "e", function()
  local has_next = vim.diagnostic.get_next_pos({ wrap = false })
  if has_next then
    vim.diagnostic.goto_next({ wrap = false })
  else
    require("telescope.builtin").diagnostics({ sort_by = "severity" })
  end
end, { desc = "Go to next diagnostic or open telescope if no diagnostics in buffer", noremap = true })

vim.keymap.set("n", "E", function()
  local has_next = vim.diagnostic.get_prev_pos({ wrap = false })
  if has_next then
    vim.diagnostic.goto_prev({ wrap = false })
  else
    require("telescope.builtin").diagnostics({ sort_by = "severity" })
  end
end, { desc = "Go to prev diagnostic or open telescope if no diagnostics in buffer", noremap = true })

vim.keymap.set("n", "<Leader>e", function()
  require("telescope.builtin").diagnostics({ sort_by = "severity" })
end, { desc = "Open telescope diagnostics", noremap = true })
