_default:
  @just --list

icons:
  #!/usr/bin/env bash
  data=$(curl https://raw.githubusercontent.com/nvim-tree/nvim-web-devicons/master/lua/nvim-web-devicons/icons-default.lua | sed 's/return {/local tbl = {/g')
  script="$data
  for main_key, main_table in pairs(tbl) do
    local key_table = {}
    for key in pairs(main_table) do
      table.insert(key_table, key)
    end
    table.sort(key_table)
    setmetatable(tbl[main_key], { __jsonorder = key_table })
  end
  print(require('dkjson').encode(tbl, { indent = false }))"
  echo "$script" | lua > icons.json

build:
  #!/usr/bin/env bash
  whiskers yazi.tera
  deno task icons
