local ts_utils = require"nvim-treesitter.ts_utils"

local p_bufnr = vim.api.nvim_get_current_buf()

local parser = vim.treesitter.get_parser(p_bufnr, 'apex')
local root = parser:parse()[1]:root()

local query = vim.treesitter.parse_query('apex', [[
value: (query_literal) @foo
]])

for _, node in query:iter_captures(root, p_bufnr) do
    ts_utils.update_selection(p_bufnr, node)
    vim.api.nvim_command('normal! gU<CR>')
    vim.api.nvim_command('normal! i***')
end
