-- Load before colorscheme so theme's treesitter highlight groups apply (init.lua order).
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  priority = 2000,
  config = function()
    -- Setup nvim-treesitter (new simplified API)
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "json",
        "html",
        "css",
        "lua",
        "vim",
      },
    })

    -- Enable treesitter highlighting (built into Neovim 0.9+)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()

        -- Only start treesitter if not already active and parser exists
        if vim.treesitter.highlighter.active[buf] == nil then
          -- Wrap in pcall to gracefully handle missing parsers (e.g., fugitive)
          pcall(vim.treesitter.start, buf)
        end
      end,
    })

    -- Disable legacy vim syntax (optional, but recommended for performance)
    vim.g.do_filetype_lua = 1
    vim.g.did_load_filetypes = 0
  end,
}
