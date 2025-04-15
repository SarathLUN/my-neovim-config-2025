return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
        vim.fn.system("cd app && yarn install")
    end,
    ft = { "markdown" },
    init = function()
        -- set default theme (dark or light)
        -- By default the theme is defined according to the preferences of the system
        vim.g.mkdp_theme = "light"
    end,
}
