" Filetype detection for gnuplot scripts (Vim).
"
" Neovim is handled by ftdetect/gnuplot.lua, which registers with
" vim.filetype.add() instead — that is the only way to take an extension the
" stock runtime already claims, since :setfiletype will not override one.
if has('nvim')
  finish
endif

" The pattern list is comma separated with no spaces: a space after a comma
" becomes part of the next pattern and stops it matching anything.
augroup gnuplotFtdetect
  autocmd!
  autocmd BufNewFile,BufRead *.gnu,*.gnuplot,*.gp,*.gpi,*.plot,*.plt
        \ setfiletype gnuplot
  autocmd BufNewFile,BufRead gnuplotrc,.gnuplot setfiletype gnuplot
  " Scripts run through `gnuplot` with a shebang.
  autocmd BufNewFile,BufRead *
        \ if getline(1) =~# '^#!.*\<gnuplot\>' | setfiletype gnuplot | endif
augroup END
