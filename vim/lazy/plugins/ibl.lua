return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      local nontext = vim.api.nvim_get_hl(0, { name = "NonText", link = false })
      local nontext_fg = nontext.fg or 0x7E7E7E

      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#4a0c0c" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#583312" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1a334a" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#402414" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#3e3d30" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#481e3d" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#16363b" })

      -- Keep indent guides subtle and avoid background tints that wash out code colors.
      vim.api.nvim_set_hl(0, "IblIndent", { fg = nontext_fg, nocombine = true })
      vim.api.nvim_set_hl(0, "IblWhitespace", { fg = nontext_fg, nocombine = true })
    end)

    require("ibl").setup({ indent = { highlight = highlight } })
  end,
}
