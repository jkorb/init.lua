local utils = require('email.utils')

vim.o.tw = 0
-- using comments for quotes
vim.opt_local.commentstring=">%s"
-- vim.o.spell = true


local cmd_params = {
  {
    cmd   = 'EmailGoFrom',
    field = 'From:',
    desc  = 'Go to the From field'
  },
  {
    cmd   = 'EmailGoTo',
    field = 'To:',
    desc  = 'Go to the To field'
  },
  {
    cmd   = 'EmailGoCc',
    field = 'Cc:',
    desc  = 'Go to the Cc field'
  },
  {
    cmd   = 'EmailGoBcc',
    field = 'Bcc:',
    desc  = 'Go to the Bcc field'
  },
  {
    cmd   = 'EmailGoSubject',
    field = 'Subject:',
    desc  = 'Go to the subject field'
  },
}

for _,params in pairs(cmd_params) do
  vim.api.nvim_buf_create_user_command(0, params['cmd'], function(_)
    local lnum = utils.get_header_field(params['field'])
    local line = vim.fn.getline(lnum)
    local len = string.len(line)
    vim.fn.cursor( lnum, len )
  end,  { desc = params['desc'] })
end

local wk = require("which-key")

local opts = { noremap = true, silent = true }

wk.register({
  g = {
    f = { 
      name = "[f]ields",
      f = { "<cmd>EmailGoFrom<CR>"    , " [F]rom field"    , opts },
      t = { "<cmd>EmailGoTo<CR>"      , " [T]o field"      , opts },
      c = { "<cmd>EmailGoCc<CR>"      , " [C]c field"      , opts },
      b = { "<cmd>EmailGoBcc<CR>"     , " [B]cc field"     , opts },
      s = { "<cmd>EmailGoSubject<CR>" , " [S]ubject field" , opts },
    },
  },
})

local to_lnum = utils.get_header_field("To:")
local to_line = vim.fn.getline(to_lnum)
local subject_lnum = utils.get_header_field("Subject:")
local subject_line = vim.fn.getline(subject_lnum)

if string.len(to_line) == string.len("To:") then
  vim.fn.cursor(to_lnum, string.len("To:"))
elseif string.len(subject_line) == string.len('Subject:') then
  vim.fn.cursor(subject_lnum, string.len("Subject:"))
else
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  for num, line in ipairs(lines) do
    -- if vim.startswith(line, "") then
    if line == "" then
      vim.fn.cursor(num,1)
      break
    end
  end

end
vim.fn.feedkeys("a", n)
