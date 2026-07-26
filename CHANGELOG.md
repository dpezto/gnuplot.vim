# Changelog

## 1.0.0 (2026-07-26)


### ⚠ BREAKING CHANGES

* **readme:** 1.0.0 is a ground-up rewrite of the pre-1.0 plugin and nothing but the licence carries over. The highlight groups were all renamed — `gnuCmd`, `gnuVar`, `gnuNumber`, `gnuDef` and the per-command families (`setOpt`, `pltOpt`, `fitOpt`, `set_arroOpt`, …) are gone, replaced by the `gnuplot*` groups documented in `:help gnuplot`, so any colourscheme or `highlight` override aimed at an old name stops applying. Filetype detection no longer claims `.gp` (it belongs to PARI/GP in the stock runtimes) or `.pal`. Keyword abbreviations are opt-in, so `set xr` is no longer highlighted.

### Features

* **ci:** cut releases with release-please and keep CITATION.cff current ([7745750](https://github.com/dpezto/gnuplot.vim/commit/7745750b4bf056be99fd2c217dce4b0cf9ab0380))
* regenerate the syntax from the tree-sitter grammar dictionary ([5bd751b](https://github.com/dpezto/gnuplot.vim/commit/5bd751b7f23e719c0e3d2fd18f7851ae836433f1))
* regenerate the syntax from the tree-sitter grammar dictionary ([7a1b69f](https://github.com/dpezto/gnuplot.vim/commit/7a1b69f1537fad8b2d78cee94754cfa38d343618))
* **syntax:** link groups to the treesitter captures the grammar uses ([e509f90](https://github.com/dpezto/gnuplot.vim/commit/e509f9082d69ccd5f3c95276c62e893a1a3a4590))


### Bug Fixes

* **ftdetect:** claim .gp for gnuplot under Vim as well ([7910ee1](https://github.com/dpezto/gnuplot.vim/commit/7910ee11e8d98c9edff151c8b604953370c48a7a))
* **ftdetect:** leave .gp to PARI/GP ([952c6c8](https://github.com/dpezto/gnuplot.vim/commit/952c6c843e596866a8a623ed9fa4813df85f68be))
* **syntax:** make abbreviations opt-in and repair four silent misses ([a0973c1](https://github.com/dpezto/gnuplot.vim/commit/a0973c1fa9a6006281efb5845dca75f777cac4a1))
* **syntax:** name the 95 grammar literals the dictionary never carried ([0944710](https://github.com/dpezto/gnuplot.vim/commit/09447109bb0cae66baa7a9d72f62bcd62d97c42a))
* **test:** stop the Windows jobs hanging until the six-hour timeout ([ae9da34](https://github.com/dpezto/gnuplot.vim/commit/ae9da3478dd4195b1cbf355e7d9c66c697f1dba8))


### Documentation

* **readme:** document the pre-1.0 upgrade path ([7189121](https://github.com/dpezto/gnuplot.vim/commit/71891212fdcc4d320acbd9a3154303e07d42fc2b))
