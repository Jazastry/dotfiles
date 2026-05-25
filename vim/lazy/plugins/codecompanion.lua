return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	-- Use coc.nvim for chat completion (/, @, etc.). If omitted, nvim-cmp wins when installed.
	-- Coc registers a custom source; the plugin writes ~/.config/nvim/autoload/coc/source/codecompanion.vim on VimEnter.
	opts = {
		interactions = {
			chat = {
				opts = {
					completion_provider = "coc",
				},
			},
		},
	},
	dependencies = {
		"neoclide/coc.nvim",
		{ "nvim-lua/plenary.nvim", branch = "master" },
		"nvim-treesitter/nvim-treesitter",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "codecompanion" }
		},{
			"OXY2DEV/markview.nvim",
			lazy = false,
			opts = {
				preview = {
					filetypes = { "markdown", "codecompanion" },
					ignore_buftypes = {},
				},
			},
		},{
			"HakonHarnes/img-clip.nvim",
			opts = {
				filetypes = {
					codecompanion = {
						prompt_for_file_name = false,
						template = "[Image]($FILE_PATH)",
						use_absolute_path = true,
					},
				},
			},
		},
	},
}

