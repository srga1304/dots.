
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local subtle_green_theme = {
      normal = {
        a = { fg = '#d8d8d8', bg = '#3a403a', gui = 'bold' },
        b = { fg = '#d8d8d8', bg = '#3a403a' },
        c = { fg = '#d8d8d8', bg = '#3a403a' },
      },
      insert  = { a = { fg = '#d8d8d8', bg = '#3a403a', gui = 'bold' } },
      visual  = { a = { fg = '#d8d8d8', bg = '#3a403a', gui = 'bold' } },
      replace = { a = { fg = '#d8d8d8', bg = '#3a403a', gui = 'bold' } },
      command = { a = { fg = '#d8d8d8', bg = '#3a403a', gui = 'bold' } },

      inactive = {
        a = { fg = '#6b6b6b', bg = '#181818' },
        b = { fg = '#6b6b6b', bg = '#181818' },
        c = { fg = '#6b6b6b', bg = '#181818' },
      }
    }

    require('lualine').setup {
      options = {
        theme = subtle_green_theme,
        globalstatus = true,
        icons_enabled = false,
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = '│', right = '│'},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {{'filename', path = 0}},
        lualine_x = {},
        lualine_y = {'diagnostics'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_c = {{'filename', path = 0}},
        lualine_x = {},
      }
    }
  end,
}
