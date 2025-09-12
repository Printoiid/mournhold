vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("set cmdheight=0")
	end,
})
