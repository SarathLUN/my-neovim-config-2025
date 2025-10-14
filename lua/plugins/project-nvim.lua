return {
    "ahmedkhalf/project.nvim",
    init = function()
        -- Monkey-patch to fix deprecated vim.lsp.buf_get_clients() warning
        -- This is a workaround until project.nvim is updated
        local _buf_get_clients = vim.lsp.buf_get_clients
        if not _buf_get_clients and vim.lsp.get_clients then
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
