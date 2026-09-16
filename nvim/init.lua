-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- https://madhavkrishangoswami.hashnode.dev/setting-up-my-neovim-config-with-lazyvim-and-tmux-on-macos
vim.g.tmux_navigator_no_mappings = 1

vim.opt.spelllang = { "ru", "en" }
