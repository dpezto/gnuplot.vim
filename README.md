# gnuplot.vim

[![CI](https://img.shields.io/github/actions/workflow/status/dpezto/gnuplot.vim/ci.yml?branch=main&label=CI&logo=githubactions&logoColor=white)](https://github.com/dpezto/gnuplot.vim/actions/workflows/ci.yml)
[![Codecov](https://img.shields.io/codecov/c/github/dpezto/gnuplot.vim?logo=codecov&logoColor=white)](https://codecov.io/gh/dpezto/gnuplot.vim)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?logo=github&logoColor=white)](.github/CONTRIBUTING.md)

Syntax highlighting for [gnuplot](http://www.gnuplot.info) 6 scripts.

The keyword lists are generated from `keywords.json`, a pinned copy of the
dictionary emitted by the
[tree-sitter-gnuplot](https://github.com/dpezto/tree-sitter-gnuplot) grammar,
so both projects recognise the same words with the same abbreviation rules.

## Install

Standard runtime path layout, so any plugin manager works:

| Manager | Install with |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | `{ "dpezto/gnuplot.vim" }` |
| [vim-plug](https://github.com/junegunn/vim-plug) | `Plug 'dpezto/gnuplot.vim'` |
| [Vundle](https://github.com/VundleVim/Vundle.vim) | `Plugin 'dpezto/gnuplot.vim'` |
| [minpac](https://github.com/k-takata/minpac) | `call minpac#add('dpezto/gnuplot.vim')` |
| [pathogen](https://github.com/tpope/vim-pathogen) | `git clone https://github.com/dpezto/gnuplot.vim ~/.vim/bundle/gnuplot` |
| native packages | `git clone https://github.com/dpezto/gnuplot.vim ~/.vim/pack/plugins/start/gnuplot` |

No configuration is needed. `:help gnuplot` documents the highlight groups.

## What it recognises

`.gnu`, `.gnuplot`, `.gpi`, `.plot` and `.plt`, the files `gnuplotrc` and
`.gnuplot`, plus anything whose first line is a shebang naming gnuplot.

`.gp` is left to PARI/GP, which owns it in the stock Vim and Neovim runtimes.

Highlighting covers commands, set/show options and their suboptions, toggles,
enumerated values, plot styles, plot-element modifiers, terminal names, the
built-in function and variable sets, datablocks, macros, numbers with unit
suffixes, and both string flavours.

### Abbreviations

gnuplot lets most keywords be shortened, and the generated lists spell that as
`p[lot]` — `:syn-keyword`'s own notation for an optional tail — so an
abbreviation costs no regular expression at all. Which keywords may appear
short is a deliberate choice rather than the full set; see
[Known limits](#known-limits).

## Colours match the tree-sitter grammar

Under Neovim the syntax groups link to the same treesitter captures that
[tree-sitter-gnuplot](https://github.com/dpezto/tree-sitter-gnuplot) uses in its
`highlights.scm` — `@keyword` for a command verb, `@variable.member` for an
option or suboption, `@keyword.directive` for a toggle, `@constant` for an
enumerated value, `@property` for a plot-element modifier, `@attribute` for a
plot style. A buffer highlighted by this plugin and one highlighted by the
grammar therefore pick up identical colours from the colorscheme. Measured over
a representative script, the two agree on **92.5%** of the characters they both
highlight; the remainder is listed below.

Neovim ships default highlights for every standard capture, so this holds even
without a treesitter parser installed. Under Vim, which has no such groups, the
links fall back to the standard ones (`Statement`, `Identifier`, `PreProc`, …).

## Known limits

Vim keywords carry no context, so a word meaning two things in gnuplot gets one
colour. `p` starts a plot command and also names the `points` style; the command
wins. `f` is the `fit` command, so in `f(x) = x**2` the `f` reads as a command
rather than a function definition.

Abbreviations are opt-in. Honouring every one of gnuplot's would make most
single letters keywords — fifty-one reduce to one character — so `a = 42` and a
loop counter would light up. Only the forms that are near-universal are
abbreviated: `plot`, `splot`, `replot`, `terminal`, `output`, `using`, `with`,
`title`, `notitle` and the three `with` values. Everything else needs its whole
word, which is why `set xr` is not highlighted.

Two deliberate differences from the grammar: a datablock body is inert here
(the grammar highlights its contents), and `!` marks only the shell escape
itself, since Vim cannot inject bash into the rest of the line.

## Development

```sh
npm run gen:syntax                          # regenerate from keywords.json
npm run check:syntax                        # fail if the committed file is stale
nvim --headless -u NONE -S tests/run.vim    # run the assertions
```

Coverage is measured with [covimerage](https://github.com/Vimjas/covimerage),
which wraps the editor in `:profile` and converts the log into a Coverage.py
data file. Both editors append to the same file, since `ftdetect/gnuplot.vim`
short-circuits on `has('nvim')` and neither one alone reaches all of it:

```sh
pip install covimerage "setuptools<81"
covimerage run --no-report --source syntax --source ftdetect --source ftplugin \
  nvim --headless -u NONE -S tests/run.vim
covimerage run --append --no-report --source syntax --source ftdetect --source ftplugin \
  vim -es -u NONE -S tests/run.vim
covimerage report
```

Only the block between the generated markers in `syntax/gnuplot.vim` is
machine written; the rest of the file is hand maintained.

New keywords arrive on their own: a weekly job compares the vendored
`keywords.json` against tree-sitter-gnuplot and opens a PR when it has moved,
regenerating the syntax file with it.

## Credits

A ground-up rewrite following earlier work by
[James Eberle](https://www.vim.org/scripts/script.php?script_id=1737) and
[Andrew Rasmussen](https://www.vim.org/scripts/script.php?script_id=4873).

## License

[MIT](LICENSE)
