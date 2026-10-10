" Headless syntax assertions. No test framework: Vim's own assert_* fills
" v:errors, and the runner exits non-zero if anything landed there.
"
"   nvim --headless -u NONE -S tests/run.vim
"   vim  -es      -u NONE -S tests/run.vim

scriptencoding utf-8

set cpoptions&vim
let s:root = expand('<sfile>:p:h:h')
execute 'set runtimepath^=' . fnameescape(s:root)
filetype plugin on
syntax enable

let v:errors = []
" A script error (bad expression, unknown function) skips its assertion
" without touching v:errors, and nvim still exits 0, so it is caught below.
let v:errmsg = ''

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

" Assert the group under the first occurrence of {word} on line {lnum} of a
" multi-line buffer. Queried bottom-up, so the answer depends on the file
" syncing from the top rather than on what was parsed before.
function! s:Line(lines, lnum, word, expected) abort
  enew!
  setlocal filetype=gnuplot
  call setline(1, a:lines)
  let l:col = stridx(a:lines[a:lnum - 1], a:word) + 1
  if l:col <= 0
    call add(v:errors, printf('fixture error: %s not on line %d', a:word, a:lnum))
    return
  endif
  call assert_equal(a:expected, s:Group(a:lnum, l:col),
        \ printf('%s  ->  line %d %s', join(a:lines, ' | '), a:lnum, a:word))
endfunction

" --- commands ---------------------------------------------------------------
call s:Word('plot sin(x)', 'plot', 'gnuplotCommand')
call s:Word('p sin(x)', 'p', 'gnuplotCommand')
call s:Word('set xrange [0:1]', 'set', 'gnuplotCommand')
" `set` is not on the abbreviation allowlist, so only the full word matches.
call s:Word('sp x*y', 'sp', 'gnuplotCommand')
call s:Word('splot x*y', 'splot', 'gnuplotCommand')
call s:Word('unset key', 'unset', 'gnuplotCommand')

" --- abbreviations carry over from the grammar's min_chars ------------------
call s:Word('set xrange [0:1]', 'xrange', 'gnuplotOption')
" Abbreviations are opt-in; xrange is not on the allowlist, so the whole word
" is required even though gnuplot accepts `set xr`.
call s:Word('set xrange [0:1]', 'xrange', 'gnuplotOption')
call s:Word('plot x u 1:2 w l', 'u', 'gnuplotAttribute')
call s:Word('plot x u 1:2 w l', 'w', 'gnuplotAttribute')
call s:Word('set terminal png', 'terminal', 'gnuplotOption')
" An ordinary variable must NOT read as a keyword. This is what the
" abbreviation allowlist buys: with every gnuplot abbreviation honoured, most
" single letters are keywords and `a = 42` lights up.
call s:Word('alpha = 42', 'alpha', '')
call s:Word('i = 3', 'i', '')
call s:Word('set termi png', 'termi', 'gnuplotOption')

" Words spelled like :syn arguments cannot be keywords; they are emitted as
" matches instead. Without that they register as nothing at all.
" The queries class fill words as @attribute, so they share the style group.
call s:Word('set style fill transparent solid 0.3', 'transparent', 'gnuplotStyle')
call s:Word('plot x title columnheader', 'columnheader', 'gnuplotBuiltinFunction')
call s:Word('set xrange [0:1] noextend', 'noextend', 'gnuplotFlag')
call s:Word('set palette cubehelix start 1', 'start', 'gnuplotOption')

" --- literals the dictionary does not carry ---------------------------------
" keywords.json is mined from the tier tokens only, so the grammar's bare
" string literals never reach the generated block. They are hand-listed, and
" these assertions are what notices when that list falls behind the grammar.
call s:Word('plot x smooth convexhull', 'convexhull', 'gnuplotAttribute')
call s:Word('plot x smooth kdensity bandwidth 0.5', 'bandwidth', 'gnuplotAttribute')
call s:Word('plot "d" binary record=100', 'record', 'gnuplotAttribute')
call s:Word('set pm3d lighting primary 0.5 spec2 0.2', 'primary', 'gnuplotOption')
call s:Word('set pm3d lighting primary 0.5 spec2 0.2', 'spec2', 'gnuplotOption')
call s:Word('set multiplot layout 2,2', 'layout', 'gnuplotOption')
call s:Word('splot x with isosurface level 3', 'level', 'gnuplotStyle')
call s:Word('set datafile missing "NaN"', 'missing', 'gnuplotOption')
call s:Word('exit message "bye"', 'message', 'gnuplotValue')
" `skip` and `end` are spelled like :syn arguments, so they can only be matches.
call s:Word('plot "d" skip 2', 'skip', 'gnuplotAttribute')
call s:Word('set key at beginning', 'beginning', 'gnuplotValue')
" `system` is both a command and a string function; the call form must stay a
" function, which is why the command is a match with a lookahead guard.
call s:Word('system "ls"', 'system', 'gnuplotCommand')
call s:Word('a = system("ls")', 'system', 'gnuplotBuiltinFunction')
" Typographic unit suffixes fold into the number, longest spelling first.
call s:Word('set size 1inch, 2mm', '1inch', 'gnuplotNumber')

" datablock contents are inert
call s:Word('$d << EOD', '$d', 'gnuplotDatablockName')
" A deep line reads as data even when nothing above it was parsed first.
call s:Line(['$d << EOD'] + repeat(['plot 1 # x'], 200) + ['EOD'], 150,
      \ 'plot', 'gnuplotDatablock')
" gnuplot ends the block on the first line starting with the terminator in
" column one: `  EOD` is data, `EODxyz` closes the block.
call s:Line(['$d << EOD', '  EOD', 'plot 1'], 2, 'EOD', 'gnuplotDatablock')
call s:Line(['$d << EOD', '  EOD', 'plot 1'], 3, 'plot', 'gnuplotDatablock')
call s:Line(['$d << EOD', '1 2', 'EODxyz', 'plot 1'], 4, 'plot', 'gnuplotCommand')
" The header may follow another command on the same line.
call s:Line(['print 1; $d << EOD', '1 2', 'EOD'], 1, '$d', 'gnuplotDatablockName')
call s:Line(['print 1; $d << EOD', '1 2', 'EOD'], 2, '1', 'gnuplotDatablock')
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
" A trailing backslash continues the comment; without one the next line is code.
call s:Line(['# comment\', 'print 42'], 2, 'print', 'gnuplotComment')
call s:Line(['print 1 # c\', 'print 42'], 2, '42', 'gnuplotComment')
call s:Line(['# comment', 'print 42'], 2, 'print', 'gnuplotCommand')
" gnuplot closes an unterminated string at the end of the line, unless a
" trailing backslash continues it.
call s:Line(['print "unfinished', 'print 42'], 2, 'print', 'gnuplotCommand')
call s:Line(["print 'unfinished", 'print 42'], 2, 'print', 'gnuplotCommand')
call s:Line(['print "abc\', 'def"', 'print 4'], 2, 'def', 'gnuplotString')
call s:Line(['print "abc\', 'def"', 'print 4'], 3, 'print', 'gnuplotCommand')
call s:Line(['print ''abc\', 'def''', 'print 4'], 2, 'def', 'gnuplotString')
call s:Word('print "a\"b" . x', 'x', '')
call s:Word('a = 42', '42', 'gnuplotNumber')
" Leading and trailing dots are part of the number, not the `.` operator.
call s:Word('a = .5', '.', 'gnuplotNumber')
call s:Word('a = 1.', '.', 'gnuplotNumber')
call s:Word('a = 1.e3', 'e', 'gnuplotNumber')
call s:Word('a = "x" . b', '.', 'gnuplotOperator')
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
" `.gp` is not claimed: it belongs to PARI/GP in the stock runtimes.
for s:name in ['t.plt', 't.plot', 't.gnu', 't.gpi', 't.gnuplot',
      \ 'gnuplotrc', '.gnuplot']
  execute 'enew!'
  execute 'file ' . s:name
  doautocmd BufRead
  call assert_equal('gnuplot', &filetype, 'ftdetect ' . s:name)
endfor

" --- report -----------------------------------------------------------------
" Vim in silent-ex mode (-es) discards :echo, so failures go to stderr, which
" both editors pass through to the CI log.
"
" '/dev/stderr' is a Unix path, and there is no Windows equivalent writefile()
" accepts: it fails with E482, which aborts this script before the quit below
" and leaves a headless editor running until the six-hour job timeout. So the
" write is Unix-only, and Windows falls back to :echomsg — the exit code is
" what actually fails the job, the text is only there to say why.
function! s:Report(lines) abort
  if has('unix')
    call writefile(a:lines, '/dev/stderr')
  else
    for l:line in a:lines
      echomsg l:line
    endfor
  endif
endfunction

if !empty(v:errmsg)
  call add(v:errors, 'script error: ' . v:errmsg)
endif

if empty(v:errors)
  call s:Report(['ok - all syntax assertions passed'])
  qall!
else
  call s:Report(v:errors + [printf('FAILED: %d assertion(s)', len(v:errors))])
  cquit!
endif
