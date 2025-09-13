return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			html = {
				lsp_format = "fallback",
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
			lsp_format = "if_nil_then_conform",
			async = false,
		},
	},
	config = function()
		require("conform").setup({
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})
	end,
}
