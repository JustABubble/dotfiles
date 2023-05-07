require("mason-nvim-dap").setup({
    ensure_installed = {
        'codelldb',
        'coreclr',
    },
})

local dap = require('dap')

-- Adapter setup
local port = '13000'
dap.adapters.codelldb = {
    type = 'server',
    port = '13000',
    executable = {
        command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        args = { '--port', port },

        -- On windows you may have to uncomment this:
        -- detached = false,
    }
}

dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
    args = { '--interpreter=vscode' },
}

-- Configuration setup
dap.configurations.rust = {
    {
        name = "Launch default project",
        type = "codelldb",
        request = "launch",
        program = function()
            local cwd = vim.fn.getcwd()
            local split_path = vim.fn.split(cwd, '/')
            local project_name = split_path[#split_path]
            return cwd .. '/target/debug/' .. project_name
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
    {
        name = "launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspacefolder}',
        stoponentry = false,
    },
}
dap.configurations.c = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}
dap.configurations.cpp = dap.configurations.c

dap.configurations.cs = {
    {
        name = "Launch solution project",
        type = "coreclr",
        request = "launch",
        program = function()
            local project_name = vim.fn.input('project name: ')
            return vim.fn.getcwd() .. '/' .. project_name .. '/bin/debug/net7.0/' .. project_name .. '.dll'
        end,
        cwd = '${workspacefolder}',
        stoponentry = false,
    },
    {
        name = "launch project",
        type = "coreclr",
        request = "launch",
        program = function()
            local cwd = vim.fn.getcwd()
            local split_path = vim.fn.split(cwd, '/')
            local project_name = split_path[#split_path]
            return cwd .. '/bin/debug/net7.0/' .. project_name .. '.dll'
        end,
        cwd = '${workspacefolder}',
        stoponentry = false,
    },
    {
        name = "Launch file",
        type = "coreclr",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

-- Start and stop dapui when debugging starts and stops
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>r", require('dap').continue)
vim.keymap.set("n", ";", require('dap').step_into)
vim.keymap.set("n", "<leader>;", require('dap').step_over)
vim.keymap.set("n", "<leader>b", require('dap').toggle_breakpoint)

vim.keymap.set("n", "<leader>D", require('dapui').toggle)

vim.keymap.set({ "n", "v" }, "<leader>e", require('dapui').eval)
