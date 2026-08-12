local ensure_installed = {
  "bash",
  "css",
  "dockerfile",
  "html",
  "javascript",
  "json",
  "json5",
  "lua",
  "python",
  "vim",
  "yaml",
  "c",
  "go",
  "rust",
}

require("nvim-treesitter").setup()

require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local ok = pcall(vim.treesitter.start)
    if not ok then
      return
    end
  end,
})
