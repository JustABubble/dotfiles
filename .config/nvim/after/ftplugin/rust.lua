vim.cmd[[packadd termdebug]]
vim.g.termdebugger = "rust-gdb"

local split_path = vim.fn.split(vim.fn.getcwd(), '/')
local project_path = split_path[#split_path]
local bin_path = 'target/debug/' .. project_path

vim.keymap.set("n", ";", "<CMD>Step<CR>")
vim.keymap.set("n", "<leader>;", "<CMD>Over<CR>")
vim.keymap.set("n", "<leader>b", "<CMD>Break<CR>")
vim.keymap.set("n", "<leader>B", "<CMD>Clear<CR>")
vim.keymap.set("n", "<leader>c", "<CMD>Continue<CR>")
