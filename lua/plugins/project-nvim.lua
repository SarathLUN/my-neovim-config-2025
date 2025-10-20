return {
    "ahmedkhalf/project.nvim",
    config = function()
        -- Directly patch the project_nvim module to fix deprecated vim.lsp.buf_get_clients()
        local project = require("project_nvim.project")

        -- Override the find_lsp_root function with the fixed version
        local original_find_lsp_root = project.find_lsp_root
        project.find_lsp_root = function()
            -- Get lsp client for current buffer using the new API
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then
                return nil
            end

            local config = require("project_nvim.config")
            for _, client in pairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.tbl_contains(filetypes, buf_ft) then
                    if not vim.tbl_contains(config.options.ignore_lsp, client.name) then
                        return client.config.root_dir, client.name
                    end
                end
            end

            return nil
        end

        require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}
