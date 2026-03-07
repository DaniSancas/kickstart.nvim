-- Side file explorer
return {
  'nvim-tree/nvim-tree.lua',
  ops = {},
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
  end,
  renderer = {
    --note on icons:
    --in some terminals, some patched fonts cut off glyphs if not given extra space
    --either add extra space, disable icons, or change font
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = true,
      },
    },
  },
  view = {
    width = 25,
    side = 'left',
  },
  sync_root_with_cwd = true, --fix to open cwd with tree
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = true,
  },

  -- use g? for bindings help while in tree
}
