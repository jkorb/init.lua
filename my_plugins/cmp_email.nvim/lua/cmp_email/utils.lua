local M = {}

function M.trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function M.is_address_line(line)
  local prefixes = { 'To:', 'From:', 'Cc:', 'Bcc:', 'Reply-To:' }
  for _, str in pairs(prefixes) do
    if vim.startswith(line, str) then
    -- if M.starts_with(line, str) then
      return true
    end
  end
  return false
end

return M
