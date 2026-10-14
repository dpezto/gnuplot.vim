# Changelog

## [1.1.2](https://github.com/dpezto/gnuplot.vim/compare/v1.1.1...v1.1.2) (2026-10-14)


### Bug Fixes

* **keywords:** sync the dictionary from tree-sitter-gnuplot@49082c8 ([#26](https://github.com/dpezto/gnuplot.vim/issues/26)) ([c436a92](https://github.com/dpezto/gnuplot.vim/commit/c436a9298c0748864b12d3667c7b82ffda51b383))

## [1.1.1](https://github.com/dpezto/gnuplot.vim/compare/v1.1.0...v1.1.1) (2026-10-10)


### Bug Fixes

* **ftplugin:** stop pairing &lt; and &gt; for % ([66d05a2](https://github.com/dpezto/gnuplot.vim/commit/66d05a2d6de11bbf1b57257c45fad74559b900c9))
* **keywords:** sync the dictionary from tree-sitter-gnuplot ([9af83fa](https://github.com/dpezto/gnuplot.vim/commit/9af83fa527f0b76dd3e5c410bb231b3d78537ea0))
* **keywords:** sync the dictionary from tree-sitter-gnuplot@ac4b9db ([03e8822](https://github.com/dpezto/gnuplot.vim/commit/03e8822dceebc54518b00940419cea3b58097adb))
* syntax and ftplugin fixes ([077495d](https://github.com/dpezto/gnuplot.vim/commit/077495d70377395b265b1feac8ff94ff9fb4b2e1))
* **syntax:** close unterminated strings at the end of the line ([1828461](https://github.com/dpezto/gnuplot.vim/commit/182846151e31bd97c906cc3a7f84439ad03c1d6a))
* **syntax:** continue comments across a trailing backslash ([39ecc52](https://github.com/dpezto/gnuplot.vim/commit/39ecc52af29f7de9f71b296e1ab8fd6a4c5d3f85))
* **syntax:** end datablocks where gnuplot does ([a4f99b0](https://github.com/dpezto/gnuplot.vim/commit/a4f99b0947d55bac679f9f861124e911155d16ee))
* **syntax:** highlight calls with a space before the parenthesis ([effa63b](https://github.com/dpezto/gnuplot.vim/commit/effa63b751a1a0cdf81623ba08c1d6384cc2eb92))
* **syntax:** keep the dot in .5 and 1. inside the number ([82ecd2c](https://github.com/dpezto/gnuplot.vim/commit/82ecd2c0360f24b9df7b15c5b760ad6e9fb37854))
* **syntax:** open datablocks that follow another command ([c20bea1](https://github.com/dpezto/gnuplot.vim/commit/c20bea18ea42fd92ebb6070470c8bd397df5aaf4))
* **syntax:** sync from the start of the file ([15010ed](https://github.com/dpezto/gnuplot.vim/commit/15010ed4f5ba4101c2c3610345766b4e1140151a))

## [1.1.0](https://github.com/dpezto/gnuplot.vim/compare/v1.0.0...v1.1.0) (2026-07-30)


### Features

* **ci:** measure VimL coverage with covimerage and publish it to Codecov ([aac94f2](https://github.com/dpezto/gnuplot.vim/commit/aac94f28dfc64f84520602db334aeb8e4c704962))
* **ci:** measure VimL coverage with covimerage and publish it to Codecov ([cdbbfbb](https://github.com/dpezto/gnuplot.vim/commit/cdbbfbb94b22fdb0929b42b35adecb6c07b7935a))


### Bug Fixes

* **keywords:** sync the dictionary from tree-sitter-gnuplot ([9e456d2](https://github.com/dpezto/gnuplot.vim/commit/9e456d2cf186379591795da63e2590ca3c75cf2a))
* **keywords:** sync the dictionary from tree-sitter-gnuplot@f68ff1f ([6e06f2f](https://github.com/dpezto/gnuplot.vim/commit/6e06f2ffd103ec3a1f50225ced3710a3b2f0cba4))

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
