return{
  "nvim-treesitter/nvim-treesitter", 
  branch = 'master', 
  lazy = false, 
  build = ":TSUpdate",
  configuration = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"lua", "c", "markdown", "markdown_inline"},
      highlight = { enable = true},
      indent = { enable = true}
    })
  end
}
