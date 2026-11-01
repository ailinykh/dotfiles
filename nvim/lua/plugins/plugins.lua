return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window right" },
    },
  },
  -- Configure LazyVim to load catppuccin
  --{ "catppuccin/nvim", name = "catppuccin", opts = { flavour = "mocha", transparent_background = false } },
  --{ "LazyVim/LazyVim", opts = { colorscheme = "catppuccin-mocha" } },
  --
  --  -- configure `tokyonight` theme
  --  {
  --    "folke/tokyonight.nvim",
  --    opts = {
  --      transparent = true,
  --      styles = { sidebars = "transparent", floats = "transparent" },
  --    },
  --  },
}
