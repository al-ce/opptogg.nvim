local api = vim.api

local M = {}

function M.main()
  local opp_table = require('opptogg').return_opp_table()

  -- Set word under cursor to 'cursorword'
  -- NOTE: this code came from:
  -- https://github.com/xiyaowong/nvim-cursorword/blob/master/plugin/nvim-cursorword.lua

  local function matchstr(...)
    local ok, ret = pcall(vim.fn.matchstr, ...)
    return ok and ret or ""
  end

  local column = api.nvim_win_get_cursor(0)[2]
  local line = api.nvim_get_current_line()

  local left = matchstr(line:sub(1, column + 1), [[\k*$]])
  local right = matchstr(line:sub(column + 1), [[^\k*]]):sub(2)

  local cursorword = left .. right


  -- Toggle the word under the cursor and put the cursor back in position

  local function toggle_word(output)
    local cursor = api.nvim_win_get_cursor(0)
    vim.cmd({
      cmd = 'norm', args = { 'ciw' .. output }
    })
    api.nvim_win_set_cursor(0, cursor)
  end

  for k, v in pairs(opp_table) do
    if cursorword == k then
      toggle_word(v)
      return
    elseif cursorword == v then
      toggle_word(k)
      return
    end

  end

  -- If nothing matched the opposites table, notify
  vim.notify('[OppTogg]: no opposing value found under cursor', 3)

end

return M
