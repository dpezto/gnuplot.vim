" Headless syntax assertions. No test framework: Vim's own assert_* fills
" v:errors, and the runner exits non-zero if anything landed there.
"
"   nvim --headless -u NONE -S tests/run.vim
"   vim  -es      -u NONE -S tests/run.vim

set nocompatible
let s:root = expand('<sfile>:p:h:h')
execute 'set runtimepath^=' . fnameescape(s:root)
filetype plugin on
syntax enable

let v:errors = []

" Raw syntax group at (line, col). Deliberately NOT synIDtrans: Vim collapses
" Conditional, Repeat and Keyword all into Statement, which would make most of
" these assertions vacuous.
function! s:Group(lnum, col) abort
  return synIDattr(synID(a:lnum, a:col, 1), 'name')
endfunction

" Assert the group under the first occurrence of {word} in {text}.
function! s:Word(text, word, expected) abort
  enew!
  setlocal filetype=gnuplot
  call setline(1, a:text)
  let l:col = stridx(a:text, a:word) + 1
  if l:col <= 0
    call add(v:errors, printf('fixture error: %s not in %s', a:word, a:text))
    return
  endif
  call assert_equal(a:expected, s:Group(1, l:col),
        \ printf('%s  ->  %s', a:text, a:word))
endfunction

" --- commands ---------------------------------------------------------------
call s:Word('plot sin(x)', 'plot', 'gnuplotCommand')
call s:Word('p sin(x)', 'p', 'gnuplotCommand')
call s:Word('set xrange [0:1]', 'set', 'gnuplotCommand')
call s:Word('se xrange [0:1]', 'se', 'gnuplotCommand')
call s:Word('splot x*y', 'splot', 'gnuplotCommand')
call s:Word('unset key', 'unset', 'gnuplotCommand')

" --- abbreviations carry over from the grammar's min_chars ------------------
call s:Word('set xrange [0:1]', 'xrange', 'gnuplotOption')
" `xran` and not `xr`: the dictionary declares xrange with a minimum of 4.
" gnuplot itself accepts `set xr`, so this asserts what the generated file
" currently says rather than what gnuplot allows — see README, Known limits.
call s:Word('set xran [0:1]', 'xran', 'gnuplotOption')
call s:Word('set termi png', 'termi', 'gnuplotOption')
call s:Word('set key noautotitle', 'noautotitle', 'gnuplotOption')

" --- tiers ------------------------------------------------------------------
call s:Word('plot x with lines', 'with', 'gnuplotAttribute')
call s:Word('plot x with lines', 'lines', 'gnuplotStyle')
call s:Word('set angles degrees', 'degrees', 'gnuplotOption')
call s:Word('set datafile separator comma', 'comma', 'gnuplotValue')
call s:Word('set border front', 'front', 'gnuplotFlag')

" --- literals ---------------------------------------------------------------
call s:Word('plot "data.dat"', '"data.dat"', 'gnuplotString')
call s:Word("plot 'data.dat'", "'data.dat'", 'gnuplotString')
call s:Word('# a comment', '# a comment', 'gnuplotComment')
call s:Word('a = 42', '42', 'gnuplotNumber')
call s:Word('set size 10cm, 5cm', '10cm', 'gnuplotNumber')
call s:Word('a = pi', 'pi', 'gnuplotConstant')
call s:Word('load @macro', '@macro', 'gnuplotMacro')
call s:Word('print GPVAL_TERM', 'GPVAL_TERM', 'gnuplotBuiltinVar')
call s:Word('print STATS_mean_y', 'STATS_mean_y', 'gnuplotBuiltinVar')

" --- functions --------------------------------------------------------------
call s:Word('plot sin(x)', 'sin', 'gnuplotBuiltinFunction')
call s:Word('a = myfunc(2)', 'myfunc', 'gnuplotFunction')

" --- control flow -----------------------------------------------------------
call s:Word('if (a > 1) { print "y" }', 'if', 'gnuplotConditional')
call s:Word('do for [i=1:10] { print i }', 'do', 'gnuplotRepeat')
call s:Word('do for [i=1:10] { print i }', 'for', 'gnuplotRepeat')

" --- filetype detection -----------------------------------------------------
" Extensions Vim/Neovim do not already claim for another language (.gp and
" .gpi belong to PARI/GP in the stock runtime, so they are left alone).
for s:name in ['t.plt', 't.gnu', 't.gnuplot', 't.plot', 't.pal']
  execute 'enew!'
  execute 'file ' . s:name
  doautocmd BufRead
  call assert_equal('gnuplot', &filetype, 'ftdetect ' . s:name)
endfor

" --- report -----------------------------------------------------------------
if empty(v:errors)
  echo 'ok — all syntax assertions passed'
  qall!
else
  for s:err in v:errors
    echo s:err
  endfor
  echo printf('FAILED: %d assertion(s)', len(v:errors))
  cquit!
endif
