-- TODO: docs

local opptogg = {

  opp_table = {
    ["True"]  = "False",
    ["true"]  = "false",
    ["0"]     = "1",
    ["yes"]   = "no",
    ["Yes"]   = "No",
    ["foo"]   = "bar",
    ["var1"]  = "var2",

    -- TODO: the regex \k doesn't capture these
    -- opps["+"]    = "-"
    -- opps["*"]    = "/"
    -- opps["="]    = "!="
  },
  mapping = '',
}


-- If there's a user config, pass it and override defaults

local exists = function(key)
  for k, _ in pairs(opptogg) do
    if key == k then
      return true
    end
  end
  error(string.format("[OppTogg]: '%s' is not a configurable value", key))
  return false
end


local type_check = function(table)
  if table == {} or nil then
    return true
  end

  for _, v in pairs(table) do
    if type(v) ~= "string" then
      error("[OppTogg]: opp_table values must be type 'string'")
      return false
    end
  end

  return true
end


local remap = function()
  local mapping = opptogg['mapping']
  if mapping ~= '' and type(mapping) == "string" then
    vim.api.nvim_set_keymap('n', mapping, ':OppTogg<CR>', { noremap = true })
  else
    error("[OppTogg]: Key mapping must be type 'string'")
  end
end


function opptogg.setup(opts)
  opts = opts or {}

  if next(opts) == nil then
    return
  end

  for k, v in pairs(opts) do
    if not exists(k) then
      return
    end

    if k == 'opp_table' then
      if not type_check(v) then
        return
      end
    end

    opptogg[k] = v
  end

  remap()
end


function opptogg.return_opp_table()
  return opptogg['opp_table']
end


-- Define a vim command to call the toggle function.
local user_cmd = vim.api.nvim_create_user_command
user_cmd(
  'OppTogg',
  function()
    require('opptogg.toggle').toggle()
  end,
  { nargs = 0 }
)


return opptogg
