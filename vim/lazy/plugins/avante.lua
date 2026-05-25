return {
  "yetone/avante.nvim",
  branch = "main",
  build = "make",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
		{ "nvim-lua/plenary.nvim", branch = "master" },
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "hrsh7th/nvim-cmp",
    "HakonHarnes/img-clip.nvim",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "zbirenbaum/copilot.lua",
  },
  config = function()
    require("avante").setup({
      provider = "copilot",
      dependncies = {
        "zbirenbaum/copilot.lua",
      },
      -- provider = "ollama",
      -- providers = {
      --   ollama = {
      --     endpoint = "http://127.0.0.1:11434",
      --     model = "gemma3n:latest",
      --   },
      -- },
    })
  end,
}

