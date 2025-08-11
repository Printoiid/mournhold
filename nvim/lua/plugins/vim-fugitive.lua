return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gp', ':Git push', desc = 'Push with message' },
    { '<leader>gu', ':Git pull<cr>', desc = 'Pull' },
    { '<leader>gs', ':Git<cr>', desc = 'Status' },
    { '<leader>gd', ':vert Gdiff HEAD<cr>', desc = 'Diff current file' },
    { '<leader>gb', ':Telescope git_branches<cr>', desc = 'Branches' },
    { '<leader>gl', ':Telescope git_commits<cr>', desc = 'Commit List' },
    { '<leader>gq', ':Telescope git_bcommits<cr>', desc = 'Commit List' },
    { '<leader>gj', '<cmd>diffget //2<cr>', desc = 'Merge Left' },
    { '<leader>gl', '<cmd>diffget //3<cr>', desc = 'Merge Right' },
    { '<leader>gm', '<cmd>Gvdiffsplit!<cr>', desc = 'Merge' },
    { '<leader>gf', '<cmd>Git fetch --prune<cr>', desc = 'Fetch & Prune' },
    { '<leader>gn', ':Git checkout -b ' },
  },
}

