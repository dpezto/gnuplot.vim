-- Filetype detection for gnuplot scripts (Neovim).
--
-- Registered through vim.filetype.add() rather than an autocmd, which is how
-- Neovim resolves filetypes: vim.filetype.match() consults entries added here
-- before its own tables.
--
-- The stock runtime already maps `.gpi` and `.gnuplot`; the rest are added
-- here. `.gp` is left alone, since PARI/GP owns it in the stock runtimes.
vim.filetype.add({
  extension = {
    gnu = 'gnuplot',
    gnuplot = 'gnuplot',
    gpi = 'gnuplot',
    plot = 'gnuplot',
    plt = 'gnuplot',
  },
  filename = {
    ['gnuplotrc'] = 'gnuplot',
    ['.gnuplot'] = 'gnuplot',
  },
})
