require("lualine").setup {
    options = {
        theme = "tokyonight",
        icons_enabled = true,
        component_separators = "|",
        section_separators = ""
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "filetype" },
        lualine_c = { "filename" },
        lualine_x = { "branch" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    }
}
