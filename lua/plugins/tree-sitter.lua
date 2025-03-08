return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local conf = require("nvim-treesitter.configs")
      conf.setup({
        auto_install = true,
        hightlight = {
          enable = true
        },
        indent = {
          enable = true
        },
      })
    end
  }
}
