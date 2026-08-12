-- Language servers

vim.lsp.config("pyright", {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
})

vim.lsp.config("ts_ls", {})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {},
  },
})

vim.lsp.config("ruff", {
  init_options = {
    settings = {
      args = {
        "--select=E,F,UP,N,I,ASYNC,S,PTH",
        "--line-length=79",
        "--respect-gitignore",
        "--target-version=py311",
      },
    },
  },
})

-- JSON
vim.lsp.config("jsonls", {})

-- YAML
vim.lsp.config("yamlls", {})

-- TOML
vim.lsp.config("taplo", {})

-- Bash
vim.lsp.config("bashls", {})

-- HTML
vim.lsp.config("html", {})

-- CSS
vim.lsp.config("cssls", {})

-- Docker
vim.lsp.config("dockerls", {})

-- Java
vim.lsp.config("jdtls", {})

vim.lsp.enable({
  "pyright",
  "ts_ls",
  "rust_analyzer",
  "ruff",

  "jsonls",
  "yamlls",
  "taplo",
  "bashls",
  "html",
  "cssls",
  "dockerls",
  "jdtls",
})

-- Diagnostics
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set("n", "Ld", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "Lk", vim.lsp.buf.hover, opts)
    vim.keymap.set({ "n", "v" }, "<space>r", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
