return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before other plugins
    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha (default flavor)
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = false,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            telescope = {
                enabled = true,
            },
            mason = true,
            which_key = true,
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)

        -- Set the colorscheme
        vim.cmd.colorscheme("catppuccin")

        -- Create user commands to switch between flavors
        vim.api.nvim_create_user_command("CatppuccinLatte", function()
            vim.cmd.colorscheme("catppuccin-latte")
            print("Switched to Catppuccin Latte")
        end, { desc = "Switch to Catppuccin Latte (light)" })

        vim.api.nvim_create_user_command("CatppuccinFrappe", function()
            vim.cmd.colorscheme("catppuccin-frappe")
            print("Switched to Catppuccin Frappé")
        end, { desc = "Switch to Catppuccin Frappé" })

        vim.api.nvim_create_user_command("CatppuccinMacchiato", function()
            vim.cmd.colorscheme("catppuccin-macchiato")
            print("Switched to Catppuccin Macchiato")
        end, { desc = "Switch to Catppuccin Macchiato" })

        vim.api.nvim_create_user_command("CatppuccinMocha", function()
            vim.cmd.colorscheme("catppuccin-mocha")
            print("Switched to Catppuccin Mocha (default dark)")
        end, { desc = "Switch to Catppuccin Mocha" })
    end,
}
