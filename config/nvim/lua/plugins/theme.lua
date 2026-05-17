return {
  'everviolet/nvim', 
  name = 'evergarden',
  priority = 1000,
  opts = {
    theme = {
      variant = 'fall',
      accent = 'green',
    },
    editor = {
      transparent_background = true,
      sign = { color = 'none' },
      float = {
        color = 'mantle',
        solid_border = false,
      },
      completion = {
        color = 'surface0',
      },
    },
  },
  config = function(_, opts)
    require('evergarden').setup(opts) -- Activarlo
    vim.cmd.colorscheme 'evergarden'
  end,
}
