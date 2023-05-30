require('rose-pine').setup({
    disable_background = true,
    disable_float_background = true,
    disable_italics = true,
})

require("tokyonight").setup({
    style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent",   -- style for floating windows
    },
    on_highlights = function(hl, c)
        hl.DiagnosticVirtualTextError = { bg = c.none, fg = c.error }
        hl.DiagnosticVirtualTextWarn = { bg = c.none, fg = c.warning }
        hl.DiagnosticVirtualTextInfo = { bg = c.none, fg = c.info }
        hl.DiagnosticVirtualTextHint = { bg = c.none, fg = c.hint }
        hl.DiagnosticVirtualTextUnnecessary = { bg = c.none, fg = c.terminal_black }

        hl.TreesitterContext = { bg = c.none }
    end
})

function ColorMyPencils(color)
    color = color or "tokyonight"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
