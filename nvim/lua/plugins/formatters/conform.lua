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
}
