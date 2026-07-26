" Filetype detection for gnuplot scripts (Vim).
"
" Neovim is handled by ftdetect/gnuplot.lua, which registers through
" vim.filetype.add() instead. That is the only way to claim an extension the
" stock runtime already assigns: ftdetect scripts are sourced after the builtin
" detection autocmd, and :setfiletype does nothing once a filetype is set.
scriptencoding utf-8

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
