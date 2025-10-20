vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "Format current file" })
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search Hight-light" })

-- Prevent x and delete from overriding clipboard
vim.keymap.set("n", "x", '"_x', { desc = "Delete character without yanking" })
vim.keymap.set("n", "X", '"_X', { desc = "Delete character backwards without yanking" })
vim.keymap.set("n", "<Del>", '"_x', { desc = "Delete character without yanking" })
vim.keymap.set("v", "x", '"_x', { desc = "Delete selection without yanking" })
vim.keymap.set("v", "X", '"_X', { desc = "Delete selection backwards without yanking" })
vim.keymap.set("v", "<Del>", '"_x', { desc = "Delete selection without yanking" })

-- ToggleTerm Keymaps
local Terminal = require("toggleterm.terminal").Terminal

-- Helper function to toggle terminal with specific direction
local function toggle_term(direction)
    -- Check if a terminal with the specified direction exists
    local terms = require("toggleterm.terminal").get_all()
    local target_term = nil
    for _, term in ipairs(terms) do
        if term:is_open() and term.direction == direction then
            target_term = term
            break
        end
    end

    if target_term then
        -- If found and open, just toggle it
        target_term:toggle()
    else
        -- Otherwise, create a new one with the specified direction and toggle
        local new_term = Terminal:new({ direction = direction })
        new_term:toggle()
    end
end

-- Floating terminal
vim.keymap.set("n", "<leader>tf", function()
    toggle_term("float")
end, { desc = "Toggle Floating Terminal" })
-- Vertical terminal
vim.keymap.set("n", "<leader>tv", function()
    toggle_term("vertical")
end, { desc = "Toggle Vertical Terminal" })
-- Horizontal terminal
vim.keymap.set("n", "<leader>th", function()
    toggle_term("horizontal")
end, { desc = "Toggle Horizontal Terminal" })

-- Example: Lazygit in a floating terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
vim.keymap.set("n", "<leader>gg", function()
    lazygit:toggle()
end, { desc = "Toggle lazygit" })

-- Markdown Preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })

-- Catppuccin Theme Switching
vim.keymap.set("n", "<leader>uL", "<cmd>CatppuccinLatte<CR>", { desc = "UI: Catppuccin Latte (light)" })
vim.keymap.set("n", "<leader>uF", "<cmd>CatppuccinFrappe<CR>", { desc = "UI: Catppuccin Frappé" })
vim.keymap.set("n", "<leader>uM", "<cmd>CatppuccinMacchiato<CR>", { desc = "UI: Catppuccin Macchiato" })
vim.keymap.set("n", "<leader>uC", "<cmd>CatppuccinMocha<CR>", { desc = "UI: Catppuccin Mocha (dark)" })
