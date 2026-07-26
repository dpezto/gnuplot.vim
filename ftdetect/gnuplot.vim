" Filetype detection for gnuplot scripts (Vim).
"
" Neovim is handled by ftdetect/gnuplot.lua, which registers through
" vim.filetype.add() instead.
scriptencoding utf-8

if has('nvim')
  finish
endif

" The pattern list is comma separated with no spaces: a space after a comma
" becomes part of the next pattern and stops it matching anything.
augroup gnuplotFtdetect
  autocmd!
  " :setfiletype yields to a filetype another runtime file already set, which
  " is what we want: `.gp` belongs to PARI/GP in the stock runtimes and is left
  " to it.
  autocmd BufNewFile,BufRead *.gnu,*.gnuplot,*.gpi,*.plot,*.plt
        \ setfiletype gnuplot
  autocmd BufNewFile,BufRead gnuplotrc,.gnuplot setfiletype gnuplot
  " Scripts run through `gnuplot` with a shebang.
  autocmd BufNewFile,BufRead *
        \ if getline(1) =~# '^#!.*\<gnuplot\>' | setfiletype gnuplot | endif
augroup END
