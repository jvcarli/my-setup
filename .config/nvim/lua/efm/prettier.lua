-- return {
--     formatCommand = ([[
--         prettier
--         ${--config-precedence:configPrecedence}
--         ${--tab-width:tabWidth}
--         ${--single-quote:singleQuote}
--         ${--trailing-comma:trailingComma}
--     ]]):gsub(
--         "\n",
--         ""
--     )
-- }

return {
  formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}
