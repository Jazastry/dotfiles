return {
  -- LSP and core Lua helpers
  { "neovim/nvim-lspconfig" },

  -- Editing helpers
  { "terryma/vim-multiple-cursors" },
  { "jiangmiao/auto-pairs" },
  { "tpope/vim-commentary" },

  -- File tree and navigation
  {
    "scrooloose/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTree" },
  },

  -- FZF is in plugins/fzf.lua
  -- Eager load so :Ack exists when <space>f fills the command line (lazy default can defer ack.vim).
  { "mileszs/ack.vim", lazy = false },

  -- UI / visuals
  { "lilydjwg/colorizer" },
  { "Valloric/MatchTagAlways" },
  { "airblade/vim-gitgutter" },
  { "tpope/vim-fugitive" },
  { "KabbAmine/vCoolor.vim" },

  -- Languages and tools
  { "mustache/vim-mustache-handlebars" },
  {
    "neoclide/coc.nvim",
    branch = "master",
    build = "npm install --frozen-lockfile",
  },
  { "jxnblk/vim-mdx-js" },
  {
    "fatih/vim-go",
    build = ":GoUpdateBinaries",
  },
  { "gpanders/editorconfig.nvim" },

  -- UI components
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- Search / Telescope
  { "sharkdp/fd" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { { "nvim-lua/plenary.nvim", branch = "master" } },
  },

  -- Search and replace / diagnostics
  { "folke/trouble.nvim" },
  { "nvim-pack/nvim-spectre" },

  -- Statusline and airline
  { "vim-airline/vim-airline" },
  { "vim-airline/vim-airline-themes" },

  -- Completion
  { "hrsh7th/nvim-cmp" },

  -- Copilot LSP bridge
  { "copilotlsp-nvim/copilot-lsp" },
}
