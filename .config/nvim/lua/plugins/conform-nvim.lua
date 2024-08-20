return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      javascript = { 'deno_fmt' },
      typescript = { 'deno_fmt' },
      json = { 'deno_fmt' },
      csharp = { 'csharpier' },
      bash = { 'shfmt' },
      bicep = { 'bicep' },
    },
  },
}
