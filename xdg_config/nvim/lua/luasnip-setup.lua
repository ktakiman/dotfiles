local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "n" }, "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/luasnip-setup.lua<cr>")

--[[
ls.snippets = {
  all = {
    -- comment header
    ls.parser.parse_snippet("header", "--------------------------------------------------------------------------------\n$0\n--------------------------------------------------------------------------------\n"),
    ls.parser.parse_snippet("hl", "hello"),
  },
  javascript = {
    ls.parser.parse_snippet("cl", "console.log({ $0 });"),
  },
  rust = {
    ls.parser.parse_snippet("pl", "println!(\"{:?}\", $0);"),
  }
}
--]]

ls.add_snippets("all", { 
  ls.parser.parse_snippet("header", "--------------------------------------------------------------------------------\n$0\n--------------------------------------------------------------------------------\n"),
});

ls.add_snippets("cpp", { 
  ls.parser.parse_snippet("pl", "std::cout << $0 << std::endl;"),
});

-- ls.add_snippets("javascript", {
--   ls.parser.parse_snippet("cl", "console.log({ $0 });"),
-- });

-- ls.add_snippets("rust", {
--   ls.parser.parse_snippet("pl", "println!(\"{:?}\", $0);"),
-- });
