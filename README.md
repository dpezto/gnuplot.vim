# Gnuplot syntax highlighting for Vim
[![PRs Welcome][prs-badge]](https://makeapullrequest.com)

I built this package from the ground up as a follow up to the work made by [James Eberle](https://www.vim.org/scripts/script.php?script_id=1737) and [Andrew Rasmussen](https://www.vim.org/scripts/script.php?script_id=4873).

## Notice
The aim of this package is to provide up-to-date support for gnuplot syntax. I'm basing the support for gnuplot 5.5 which is currently in development.

## Installation

### Using a plugin manager
This plugin follows the standard runtime path structure, and as such it can be installed with a variety of plugin managers:

| Plugin Manager | Install with... |
| ------------- | ------------- |
| [Pathogen][1] | `git clone https://github.com/dpezto/gnuplot.vim ~/.vim/bundle/gnuplot` |
| [Vundle][2] | `Plugin 'dpezto/gnuplot.vim'` |
| [Plug][3] | `Plug 'dpezto/gnuplot.vim'` |
| [minpac][4] | `call minpac#add('dpezto/gnuplot.vim')` |
| pack feature (native Vim 8 package feature)| `git clone https://github.com/dpezto/gnuplot.vim ~/.vim/pack/plugins/start/gnuplot` |

### Manual installation
In order to have vim automatically detect gnuplot files, you need to have
[`ftplugins`](http://vimhelp.appspot.com/usr_05.txt.html#ftplugins) enabled (e.g. by having this line in your [`.vimrc`](http://vimhelp.appspot.com/starting.txt.html#.vimrc) file:

```vim
:filetype plugin on
```

The plugin already sets up some logic to detect gnuplot files. In order that the
gnuplot filetype plugin is loaded correctly, vim needs to be enabled to load
[`filetype-plugins`](http://vimhelp.appspot.com/filetype.txt.html#filetype-plugins). This can be ensured by putting a line like this in your
[`.vimrc`](http://vimhelp.appspot.com/starting.txt.html#.vimrc):

```vim
:filetype plugin on
```
(see also [:filetype-plugin-on](http://vimhelp.appspot.com/filetype.txt.html#:filetype-plugin-on)).

In case this did not work, you need to setup vim like this:

To have Vim automatically detect gnuplot files, you need to do the following.

1. Create your user runtime directory if you do not have one yet. This
	  directory needs to be in your 'runtime' path. In Unix this would
	  typically the ~/.vim directory, while in Windows this is usually your
	  ~/vimfiles directory. Use :echo expand("~") to find out, what Vim thinks
	  your user directory is.
	  To create this directory, you can do:
    ```vim
    :!mkdir ~/.vim
    ```
    for Unix and
    ```vim
    :!mkdir ~/vimfiles
    ```
    for Windows.

2. In that directory you create a file that will detect gnuplot files.
```vim
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
au! BufNewFile,BufRead *.plt,*.plot,*.gnuplot,*.gnu,*.gp setf gnuplot
augroup END
```

You save this file as "filetype.vim" in your user runtime diretory:
```vim
:w ~/.vim/filetype.vim
```

3. To be able to use your new filetype.vim detection, you need to restart Vim. Vim will then load the gnuplot filetype plugin for all files whose names end with .plt, .plot, .gnuplot, .gnu, .gp.

## Status
This began as a personal project since I prefer the results of the plots made with gnuplot, so most of the syntax currently in the file is for my use case. Despite this, the package can handle almost all use cases of gnuplot. I'm looking forward to refine the syntax highlighting.

[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48c3ZnIGlkPSJzdmcyIiB3aWR0aD0iNjQ1IiBoZWlnaHQ9IjU4NSIgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPiA8ZyBpZD0ibGF5ZXIxIj4gIDxwYXRoIGlkPSJwYXRoMjQxNyIgZD0ibTI5Ny4zIDU1MC44N2MtMTMuNzc1LTE1LjQzNi00OC4xNzEtNDUuNTMtNzYuNDM1LTY2Ljg3NC04My43NDQtNjMuMjQyLTk1LjE0Mi03Mi4zOTQtMTI5LjE0LTEwMy43LTYyLjY4NS01Ny43Mi04OS4zMDYtMTE1LjcxLTg5LjIxNC0xOTQuMzQgMC4wNDQ1MTItMzguMzg0IDIuNjYwOC01My4xNzIgMTMuNDEtNzUuNzk3IDE4LjIzNy0zOC4zODYgNDUuMS02Ni45MDkgNzkuNDQ1LTg0LjM1NSAyNC4zMjUtMTIuMzU2IDM2LjMyMy0xNy44NDUgNzYuOTQ0LTE4LjA3IDQyLjQ5My0wLjIzNDgzIDUxLjQzOSA0LjcxOTcgNzYuNDM1IDE4LjQ1MiAzMC40MjUgMTYuNzE0IDYxLjc0IDUyLjQzNiA2OC4yMTMgNzcuODExbDMuOTk4MSAxNS42NzIgOS44NTk2LTIxLjU4NWM1NS43MTYtMTIxLjk3IDIzMy42LTEyMC4xNSAyOTUuNSAzLjAzMTYgMTkuNjM4IDM5LjA3NiAyMS43OTQgMTIyLjUxIDQuMzgwMSAxNjkuNTEtMjIuNzE1IDYxLjMwOS02NS4zOCAxMDguMDUtMTY0LjAxIDE3OS42OC02NC42ODEgNDYuOTc0LTEzNy44OCAxMTguMDUtMTQyLjk4IDEyOC4wMy01LjkxNTUgMTEuNTg4LTAuMjgyMTYgMS44MTU5LTI2LjQwOC0yNy40NjF6IiBmaWxsPSIjZGQ1MDRmIi8%2BIDwvZz48L3N2Zz4%3D

[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/VundleVim/Vundle.vim
[3]: https://github.com/junegunn/vim-plug
[4]: https://github.com/k-takata/minpac/
