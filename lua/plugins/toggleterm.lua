return {
    "akinsho/toggleterm.nvim",
    version = "*", -- or specify a git tag like 'v2.9.0' if you encounter issues
    opts = {
        -- size can be a number or function which is passed the current terminal
        -- size = 20, -- You can uncomment and set a fixed size
        -- size = function(term)
        --   if term.direction == "horizontal" then
        --     return 15
        --   elseif term.direction == "vertical" then
        --     return vim.o.columns * 0.4
        --   end
        -- end,
        -- Use a function to determine size
        size = function(term)
            if term.direction == "vertical" then
                -- Example 1: Set vertical width to 100 columns
                -- return 100

                -- Example 2: Set vertical width to 50% of the editor width
                return math.floor(vim.o.columns * 0.5)
            elseif term.direction == "horizontal" then
                -- Set horizontal height (e.g., 15 rows)
                return 15
            else
                -- Default size for other types (like float) if needed
                return 20
            end
        end,
        open_mapping = [[<c-\>]], -- Keybind to toggle the terminal (Ctrl + \)
        hide_numbers = true, -- Hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true, -- Dim terminal background slightly
        -- shading_factor = 2, -- Darker shading factor
        start_in_insert = true, -- Start terminal in insert mode
        insert_mappings = true, -- Close terminal window with <C-\> while in insert mode
        terminal_mappings = true, -- Close terminal window with <C-\> while in terminal mode
        persist_size = true, -- Remember the size of the terminal window
        direction = "float", -- Default direction ('float', 'horizontal', 'vertical')
        close_on_exit = true, -- Close the terminal window when the process exits
        shell = vim.o.shell, -- Use Neovim's configured shell
        float_opts = {
            -- Options for floating window, similar to vim.api.nvim_open_win
            border = "curved", -- 'single', 'double', 'rounded', 'curved'
            -- width = <value>,
            -- height = <value>,
            winblend = 0, -- Transparency (0-100)
        },
    },
    config = function(_, opts)
        -- Ensure hidden is set, otherwise terminals might be discarded
        vim.opt.hidden = true
        require("toggleterm").setup(opts)

        -- Custom function to easily set terminal keymaps
        function _G.set_terminal_keymaps()
            local term_opts = { buffer = 0 } -- 0 means current buffer
            -- Exit terminal mode back to normal mode
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], term_opts)
            -- You can add more terminal-mode mappings here if needed
            -- Example: Navigate splits from terminal mode
            -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], term_opts)
            -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], term_opts)
            -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], term_opts)
            -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], term_opts)
        end

        -- Call the function when a terminal buffer is opened
        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
}
