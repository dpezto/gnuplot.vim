# gnuplot.vim

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

`.gnu`, `.gnuplot`, `.gp`, `.gpi`, `.pal`, `.plot` and `.plt`, plus any file
whose first line is a shebang naming gnuplot.

Highlighting covers commands, set/show options and their suboptions, toggles,
enumerated values, plot styles, plot-element modifiers, terminal names, the
built-in function and variable sets, datablocks, macros, numbers with unit
suffixes, and both string flavours.

### Abbreviations

gnuplot lets most keywords be shortened, and so does this plugin — `set xran`
highlights exactly like `set xrange`. The generated lists spell that as
`xran[ge]`, which is `:syn-keyword`'s own notation for an optional tail, so the
whole abbreviation system is carried over without a single regular expression.

## Known limits

Vim keywords carry no context, so a word meaning two things in gnuplot gets one
colour. `p` starts a plot command and also names the `points` style; the command
wins. `f` is the `fit` command, so in `f(x) = x**2` the `f` reads as a command
rather than a function definition.

Some option heads are currently stricter than gnuplot: the dictionary records
`xrange` with a four character minimum, so `set xr` goes unhighlighted even
though gnuplot accepts it. That is a property of the upstream dictionary and is
fixed there rather than patched here.

## Development

```sh
npm run gen:syntax                          # regenerate from keywords.json
npm run check:syntax                        # fail if the committed file is stale
nvim --headless -u NONE -S tests/run.vim    # run the assertions
```

Only the block between the generated markers in `syntax/gnuplot.vim` is
machine written; the rest of the file is hand maintained. To pick up new
keywords, copy `keywords.json` from the grammar repository and regenerate.

## Credits

A ground-up rewrite following earlier work by
[James Eberle](https://www.vim.org/scripts/script.php?script_id=1737) and
[Andrew Rasmussen](https://www.vim.org/scripts/script.php?script_id=4873).

## License

[MIT](LICENSE)
