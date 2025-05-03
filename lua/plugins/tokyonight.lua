return {
    "folke/tokyonight.nvim",
    lazy = false, -- Load the theme early
    priority = 1000, -- Make sure it loads before other plugins that determine syntax highlighting
    opts = {
        -- You can configure options here, like:
        -- style = "storm" | "night" | "day" | "moon"
        -- transparent = true,
        -- terminal_colors = true,
        -- ... see the plugin documentation for more options
    },
    config = function(_, opts)
        require("tokyonight").setup(opts)
        -- Load the colorscheme here
        vim.cmd.colorscheme("tokyonight")
    end,
}
