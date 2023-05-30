vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.laststatus = 0

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.clipboard:append("unnamedplus")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function()
        local cursorPos = vim.fn.getpos(".")
        vim.cmd [[%s/\s\+$//e]]
        vim.cmd [[%s/\n\+%$//e]]
        vim.fn.cursor(cursorPos[2], cursorPos[3])
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = "*",
    command = [[setlocal formatoptions-=o formatoptions-=r formatoptions-=c]],
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.xaml", "*.axaml" },
    command = [[setlocal filetype=xml]]
})
