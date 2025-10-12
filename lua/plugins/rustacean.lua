return {
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
  ft = { 'rust' }, -- Only load for Rust files
  init = function()
    -- Configure rustaceanvim via vim.g before it loads
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            check = {
              command = "clippy",
            },
          },
        },
      },
    }
  end,
}
