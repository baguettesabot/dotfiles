M = {}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_pending_mode = "o"
}


local defaults = {
  normal_mode = {
    --window navigation
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    --resize windows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>"
  }
}

function M.set_keymaps(mode, key, value)
  vim.keymap.set(mode, key, value, { silent = true, noremap = true })
end

function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode]
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

function M.load(keymaps)
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

function M.load_defaults()
  M.load(M.get_defaults())
end

function M.get_defaults()
  return defaults
end

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

function M.on_attach(client, bufnr)
  opts.buffer = bufnr
  local builtin = require "telescope.builtin"

  opts.desc = "Show LSP references"
  keymap.set("n", "gR", function() builtin.lsp_references() end, opts) --show definition, references

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts) --go to declaration

  opts.desc = "Show LSP definition"
  keymap.set("n", "gd", function() builtin.lsp_definitions() end, opts) --show lsp definitions

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", function() builtin.lsp_implementations() end, opts) --show lsp implementations

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", function() builtin.lsp_type_definitions() end, opts) --show lsp type definitions

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) --see available code actions, in visual mode will apply

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) --smart rename

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", function() builtin.diagnostics({bufnr = 0}) end, opts) --show diagnostics for file

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) --show diagnostics for line

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) --jump to previous diagnostic in buffer

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts) --jump to next diagnostic in buffer

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, opts) --show documentation for what is under cursor

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) --mapping to restart lsp if necessary
end

return M

