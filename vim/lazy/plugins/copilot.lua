return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  config = function()
    -- Setup copilot
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      -- filetypes = {
      --   yaml = true,
      --   markdown = true,
      -- },
      -- suggestion = {
      --   keymap = {
      --     accept = "<M-l>",
      --     next = "<M-n>",
      --     prev = "<M-p>",
      --   },
      -- },
    })
  end,
}
