return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    signs = true,
    TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
  },
  colors = {
    test = { 'Identifier', '#FF00FF' },
  },
}
