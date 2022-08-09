local opptogg = {

  opp_table = {
    ["True"]  = "False",
    ["true"]  = "false",
    ["0"]     = "1",
    ["yes"]   = "no",
    ["Yes"]   = "No",
    ["foo"]   = "bar",
    ["var1"]  = "var2",
    ["print"] = "input",

    -- TODO: the regex \k doesn't capture these
    -- opps["+"]    = "-"
    -- opps["*"]    = "/"
    -- opps["="]    = "!="
  },

  mapping = nil,

}

local type_check = function(table)
  if table == {} or nil then
    return false
  end
  for _, v in pairs(table) do

    if type(v) ~= "string" then
      error("[OppTogg] opp_table keys and values must be type 'string'")
      return false
    end
  end
end


-- TODO: move to the setup.lua file and then call the file here
function opptogg.setup(opts)
  opts = opts or {}

  if next(opts) == nil then
    return
  end

  for k, v in pairs(opts) do

    -- if opptogg[k] == nil then
    --   error(string.format('[OppTogg] Key %s does not exist in config values', k))
    --   return
    -- end

    -- if k == 'opp_table' then
    --   if not type_check(k) then
    --     return
    --   end
    -- end

    opptogg[k] = v
  end

  local mapping = opptogg['mapping']
  if mapping ~= nil and type(mapping) == "string" then
    vim.api.nvim_set_keymap('n', mapping, ':OppTogg<CR>', { noremap = true })
  else
    error("[OppTogg]: Key mapping must be type 'string'")
  end

end

function opptogg.return_opp_table()
  return opptogg['opp_table']
end

local user_cmd = vim.api.nvim_create_user_command

user_cmd(
  'OppTogg',
  function()
    require('opptogg.toggle').toggle()
  end,
  { nargs = 0 }
)




return opptogg
