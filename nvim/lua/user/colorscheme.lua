local colors = {
  nightfox = function()
    require('nightfox').setup({
      options = {
        dim_inactive = false,
      },
      groups = {
        all = {
          -- border line
          VertSplit = { fg = 'bg4' },
        }
      },
    })

    -- terafox, duskfox, nightfox, carbonfox
    vim.cmd [[colorscheme duskfox]]
  end,

  ['rose-pine'] = function()
    require('rose-pine').setup({
      --- @usage 'main' | 'moon'
      dark_variant = 'main',
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = false,
      disable_float_background = false,
      disable_italics = false,

      --- @usage string hex value or named color from rosepinetheme.com/palette
      groups = {
        background = 'base',
        panel = 'surface',
        border = 'highlight_high',
        comment = 'muted',
        link = 'iris',
        punctuation = 'subtle',

        error = 'love',
        hint = 'iris',
        info = 'foam',
        warn = 'gold',

        headings = {
          h1 = 'iris',
          h2 = 'foam',
          h3 = 'rose',
          h4 = 'gold',
          h5 = 'pine',
          h6 = 'foam',
        }
        -- or set all headings at once
        -- headings = 'subtle'
      },

      -- Change specific vim highlight groups
      highlight_groups = {
        ColorColumn = { bg = 'rose' }
      }
    })

    vim.cmd [[colorscheme rose-pine]]
  end
}

local M = {
  set_color = function(name)
    colors[name]()
  end
}

M.set_color('nightfox')
-- M.set_color('rose-pine')

return M
