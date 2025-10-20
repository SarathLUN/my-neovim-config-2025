return {
    "ahmedkhalf/project.nvim",
    init = function()
        -- Monkey-patch to fix deprecated vim.lsp.buf_get_clients() warning
        -- This is a workaround until project.nvim is updated
        -- Use rawget to avoid triggering the deprecation warning
        if vim.lsp.get_clients and not rawget(vim.lsp, 'buf_get_clients') then
            -- For Neovim 0.10+, create a compatibility shim
            vim.lsp.buf_get_clients = function(bufnr)
                return vim.lsp.get_clients({ bufnr = bufnr })
            end
        end

        require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}
