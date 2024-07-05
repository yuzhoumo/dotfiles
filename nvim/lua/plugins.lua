-- install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- extend % to match more pairs such as html tags
vim.cmd("runtime macros/matchit.vim")

return require("lazy").setup("config", {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = { -- disable plugins from runtime path
        "gzip",
        "health",
        "man",
        "matchparen",
        "netrwPlugin",
        "nvim",
        "rplugin",
        "shada",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      }
    }
  }
})
