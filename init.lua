require('options.vim-options')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  {
    { import = 'plugins' },
    { import = 'color' },
    { import = 'debuggers' },
    { import = 'formatters' },
    { import = 'langs' },
    { import = 'lspconfig' },
  },
  {
    change_detection = {
      notify = false,
    },
  })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
