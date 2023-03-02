vim.api.nvim_buf_create_user_command(0, 'LtexSwitchLang', function()

  local ltex_clients = vim.lsp.get_active_clients({bufnr=0, name="ltex"})

  for _, ltex_client in ipairs(ltex_clients) do
    vim.lsp.stop_client(ltex_client.id, false)
  end

  local lang = vim.fn.input('Language: ')

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  require('lspconfig')['ltex'].setup({
    capabilities = capabilities,
    settings = {
      ltex = {
        enabled = { 'latex', 'tex', 'bib', 'markdown', 'text', 'mail' },
        language = lang,
      }
    }
  })

end, { desc = ' LSP: Change ltex language' })

require('which-key').register({
  ls = {'<cmd>LtexSwitchLang<cr>', ' Ltex: Switch language'}
}, { prefix = "<leader>" })
