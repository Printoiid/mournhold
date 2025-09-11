return {
	'folke/todo-comments.nvim',
	event = 'VimEnter',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	opts = {
		signs = true,
		keywords = {
			--  NOTE: Test Note
			NOTE = { icon = '󰎛', color = '#00F2FF' },
			--  FIX: Test Fix
			FIX = { icon = '', color = '#09FF00' },
			--  TODO: Test Todo
			TODO = { icon = '', color = '#FF00D4' },
			--  REWRITE: Test Rewrite
			REWRITE = { icon = '󰏫', color = '#FF4800' },
		},
	},
}
