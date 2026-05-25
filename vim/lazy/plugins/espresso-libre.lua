-- Depends on nvim-treesitter so it loads after; theme defines treesitter highlight groups.
return {
  "jazastry/espresso-libre",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- Load theme after treesitter (guaranteed by dependency + priority)
    require("espresso-libre").setup({})

    -- In some projects typescriptreact/typescript should be aliased so treesitter works fine
    vim.filetype.add({
      extension = {
        tsx = "typescriptreact",
        ts = "typescript",
      },
    })

    -- Highlight overrides from init.vim (apply after colorscheme so they stick)
    vim.api.nvim_set_hl(0, "TabLine", { bg = "#808080", ctermbg = 248 })
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#7E7E7E" })
    vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ff0000", ctermbg = 9 })
    vim.fn.matchadd("ExtraWhitespace", "\\s\\+$")
  end,
}

