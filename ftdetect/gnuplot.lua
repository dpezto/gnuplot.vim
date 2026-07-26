-- Filetype detection for gnuplot scripts (Neovim).
--
-- Registered through vim.filetype.add() rather than an autocmd. Neovim resolves
-- the filetype itself in vim.filetype.match(), consulting entries added here
-- before its own tables, so this is the only way to claim an extension the
-- stock runtime already assigns. `.gp` is the case that matters: the runtime
-- gives it to PARI/GP, and an ftdetect autocmd calling :setfiletype would be a
-- no-op because the filetype is already set by the time it runs.
--
-- The stock runtime already maps `.gpi` and `.gnuplot`; the rest are added
-- here.
vim.filetype.add({
  extension = {
    gnu = 'gnuplot',
    gnuplot = 'gnuplot',
    gp = 'gnuplot',
    gpi = 'gnuplot',
    plot = 'gnuplot',
    plt = 'gnuplot',
  },
  filename = {
    ['gnuplotrc'] = 'gnuplot',
    ['.gnuplot'] = 'gnuplot',
  },
})
