require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  -- your other treesitter config
})
-- Load theme after treesitter
require('espresso_libre').setup()

-- Highlight setup
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#4a0c0c" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#583312" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#1a334a" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#402414" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#3e3d30" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#481e3d" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#16363b" })
end)

require("ibl").setup { indent = { highlight = highlight } }
require("coverage").setup({
	commands = true, -- create commands
	highlights = {
		-- customize highlight groups created by the plugin
		covered = { fg = "#C3E88D" },   -- supports style, fg, bg, sp (see :h highlight-gui)
		uncovered = { fg = "#F07178" },
	},
	signs = {
		-- use your own highlight groups or text markers
		covered = { hl = "CoverageCovered", text = "▎" },
		uncovered = { hl = "CoverageUncovered", text = "▎" },
	},
	summary = {
		-- customize the summary pop-up
		min_coverage = 80.0,      -- minimum coverage threshold (used for highlighting)
	},
	lang = {
		-- customize language specific settings
	},
})

-- require("scrollbar").setup()
-- require('mini.map').setup()
-- require('mini.diff').setup()

vim.api.nvim_create_user_command('Restart', function()
  -- Save current session if you want
  vim.cmd('mksession! /tmp/nvim_restart_session.vim')
  
  -- Write all buffers
  vim.cmd('wall')
  
  -- Quit and restart
  if vim.fn.has('nvim') == 1 then
    vim.fn.system('nohup nvim --headless -c "source /tmp/nvim_restart_session.vim" &')
    vim.cmd('qall!')
  end
end, {})
