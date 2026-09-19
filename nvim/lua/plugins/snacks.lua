return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = function()
            return {
              preset = "sidebar",
              preview = false,
              layout = {
                -- Restores the session size if it exists, otherwise defaults to 30 columns
                width = (vim.g.snacks_explorer_size or {}).width or 30,
              },
            }
          end,
          on_close = function(picker)
            -- Captures the width right before the explorer window is closed
            vim.g.snacks_explorer_size = picker.layout.root:size()
          end,
        },
      },
    },
  },
}
