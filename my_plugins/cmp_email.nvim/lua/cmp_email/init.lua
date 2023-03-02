local source = {}

local utils = require('cmp_email.utils')

function source.new()
  return setmetatable({}, {__index = source})
end

function source:get_keyword_pattern()
  -- Add dot to existing keyword characters (\k).
  return [[\%(\k\|\.\|[:blank:]\)\+]]
end

local function get_items()

  local items = {}

  local contacts = vim.fn.system('mu cfind --personal')

  -- go through the contacts line by line
  for contact in contacts:gmatch("[^\r\n]+") do

    local email = contact:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")

    if email ~= nil then
      local item = ""
      local display_item = ""

      local name = string.gsub(contact, email, "")

      if name ~= "" and name ~= " " then
        item = '\"' .. utils.trim(name) .. '\" '
        display_item = utils.trim(name) .. ', ' .. utils.trim(email)
      else
        item = ""
      end

      item = item .. '<' .. utils.trim(email) .. '>'

      table.insert(items, {
        label      = display_item,
        sortTex    = display_item,
        filterText = display_item,
        insertText = item,
        preselect = false,
      })
    end

  end

  return items
end

function source:complete(request, callback)

  local line = request.context.cursor_line

  if utils.is_address_line(line) then
    callback {
      items = get_items(),
      isIncomplete = true,
    }
  else
    callback({isIncomplete = true})
  end
end

return source
