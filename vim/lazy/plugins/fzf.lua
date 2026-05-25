-- FZF: file finder and buffer list. Config and keymaps ported from init.vim.
return {
  "junegunn/fzf",
  build = "./install --all",
  -- Load at startup so :FZF and keymaps work (no cmd lazy).
  config = function()
    -- FZF colors to match color scheme
    vim.g.fzf_colors = {
      fg = { "fg", "Normal" },
      bg = { "bg", "Normal" },
      hl = { "fg", "Comment" },
      ["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
      ["bg+"] = { "bg", "CursorLine", "CursorColumn" },
      ["hl+"] = { "fg", "Statement" },
      info = { "fg", "PreProc" },
      border = { "fg", "Ignore" },
      prompt = { "fg", "Conditional" },
      pointer = { "fg", "Exception" },
      marker = { "fg", "Keyword" },
      spinner = { "fg", "Label" },
      header = { "fg", "Comment" },
    }

    vim.g.fzf_history_dir = vim.fn.expand("~/.local/share/fzf-history")
    vim.env.FZF_DEFAULT_COMMAND =
      "find . \\! \\( -type d -path ./.git -prune \\) \\! -type d \\! -name '*.tags' -printf '%P\\n'"

    -- <space>p: open FZF file search
    vim.keymap.set("n", "<space>p", ":FZF<CR>", { silent = true, desc = "FZF files" })

    -- <space><Enter>: FZF buffer list
    vim.keymap.set("n", "<space><Enter>", function()
      local lines = vim.fn.split(vim.fn.execute("silent ls"), "\n")
      vim.fn["fzf#run"]({
        source = vim.fn.reverse(lines),
        sink = function(e)
          local n = string.match(e, "^%s*(%d+)")
          if n then
            vim.cmd("buffer " .. n)
          end
        end,
        options = "+m",
        down = #lines + 2,
      })
    end, { silent = true, desc = "FZF buffers" })
  end,
}
