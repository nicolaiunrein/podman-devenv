-- Tab / Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.opt.smartindent = false
vim.o.wrap = false
vim.o.expandtab = true

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
-- vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
-- vim.opt.cmdheight = 1
vim.opt.scrolloff = 8
-- vim.opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
vim.opt.hidden = true
vim.opt.errorbells = false
-- vim.opt.swapfile = false
-- vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.nvim-data/undodir")
vim.opt.undofile = true
vim.opt.backspace = "indent,eol,start"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autochdir = true
vim.opt.iskeyword:append("-")
-- vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
-- vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.opt.showmode = false

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- Shell
-- Windows specific
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
  vim.opt.shellxquote = ""
  vim.opt.shellquote = ""
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
end
-- Spelling
vim.opt.spelllang = "en_us"
-- TODO: Use something else
vim.opt.spell = false

-- Navigation
vim.opt.autochdir = false
