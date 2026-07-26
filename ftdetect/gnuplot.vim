" Filetype detection for gnuplot scripts.
"
" The pattern list is comma separated with no spaces: a space after a comma
" becomes part of the next pattern and stops it matching anything.
au BufNewFile,BufRead *.gnu,*.gnuplot,*.gp,*.gpi,*.pal,*.plot,*.plt setf gnuplot

" Scripts run through `gnuplot` with a shebang.
au BufNewFile,BufRead * if getline(1) =~# '^#!.*\<gnuplot\>' | setf gnuplot | endif
