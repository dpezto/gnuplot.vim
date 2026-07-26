" Vim filetype plugin
" Language:   gnuplot 6
" Maintainer: Dai López Jacinto <dpezto@gmail.com>

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

setlocal commentstring=#\ %s
setlocal comments=:#
setlocal formatoptions-=t
setlocal formatoptions+=croql

" gnuplot identifiers and its built-in variables (GPVAL_TERM, STATS_mean_y)
" contain underscores.
setlocal iskeyword+=_

" `set xrange [0:1]` and friends: treat brackets as matched pairs.
setlocal matchpairs+=<:>

let b:undo_ftplugin = 'setlocal commentstring< comments< formatoptions<'
      \ . ' iskeyword< matchpairs<'

let &cpo = s:cpo_save
unlet s:cpo_save
