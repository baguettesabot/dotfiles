vim.g.mapleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
-- opt.tabstop = 2
-- opt.shiftwidth = 2
-- opt.expandtab = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { noremap = true, silent = true }
		opts.buffer = bufnr
		local builtin = require "telescope.builtin"

		opts.desc = "Show LSP references"
		vim.keymap.set("n", "gR", function() builtin.lsp_references() end, opts) --show definition, references

		opts.desc = "Go to declaration"
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) --go to declaration

		opts.desc = "Show LSP definition"
		vim.keymap.set("n", "gd", function() builtin.lsp_definitions() end, opts) --show lsp definitions

		opts.desc = "Show LSP implementations"
		vim.keymap.set("n", "gi", function() builtin.lsp_implementations() end, opts) --show lsp implementations

		opts.desc = "Show LSP type definitions"
		vim.keymap.set("n", "gt", function() builtin.lsp_type_definitions() end, opts) --show lsp type definitions

		opts.desc = "See available code actions"
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) --see available code actions, in visual mode will apply

		opts.desc = "Smart rename"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) --smart rename

		opts.desc = "Show buffer diagnostics"
		vim.keymap.set("n", "<leader>D", function() builtin.diagnostics({bufnr = 0}) end, opts) --show diagnostics for file

		opts.desc = "Show line diagnostics"
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) --show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) --jump to previous diagnostic in buffer

		opts.desc = "Go to next diagnostic"
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) --jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) --show documentation for what is under cursor

		opts.desc = "Restart LSP"
		vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) --mapping to restart lsp if necessary
	end
})

require("config/keymappings").load_defaults()
