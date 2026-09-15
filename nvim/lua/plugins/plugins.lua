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
      ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
      ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
      ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
      ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    },
  },
}
