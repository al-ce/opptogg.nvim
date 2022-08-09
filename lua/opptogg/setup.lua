local opp_table = {
  ["True"] = "False",
  ["true"] = "false",
  ["0"]    = "1",
  ["yes"]  = "no",
  ["Yes"]  = "No",
  ["foo"]  = "bar",
  ["var1"] = "var2",
  ["print"] = "input",

  -- TODO: the regex \k doesn't capture these
  -- opps["+"]    = "-"
  -- opps["*"]    = "/"
  -- opps["="]    = "!="

}

return opp_table
