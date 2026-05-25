return {
  "nvim-mini/mini.nvim",
  branch = "stable",
  config = function()
    local animate = require("mini.animate")
    require("mini.animate").setup({
      -- Vertical scroll
      scroll = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
      },

      -- Window resize
      resize = {
        -- Whether to enable this animation
        enable = false,
      },
    })
  end,
}
