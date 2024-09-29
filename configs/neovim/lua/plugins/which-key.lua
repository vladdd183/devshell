return {
  {
    "folke/which-key.nvim",
    opts_extend = { "spec" },
    opts = {
      spec = {
        {
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "yellow" } },
          { "<leader>h", group = "fdssf", icon = { icon = "󱖫 ", color = "green" } },
        },
      },
    },
  },
}
