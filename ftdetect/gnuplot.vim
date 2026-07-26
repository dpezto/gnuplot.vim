" Filetype detection for gnuplot scripts.
"
" The pattern list is comma separated with no spaces: a space after a comma
" becomes part of the next pattern and stops it matching anything.
augroup gnuplotFtdetect
  autocmd!
  autocmd BufNewFile,BufRead *.gnu,*.gnuplot,*.gp,*.gpi,*.pal,*.plot,*.plt
        \ setfiletype gnuplot
  " Scripts run through `gnuplot` with a shebang.
  autocmd BufNewFile,BufRead *
        \ if getline(1) =~# '^#!.*\<gnuplot\>' | setfiletype gnuplot | endif
augroup END
