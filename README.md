# Gnuplot syntax highlighting for Vim
I built this package from the ground up as a follow up to the work made by [James Eberle](https://www.vim.org/scripts/script.php?script_id=1737) and [Andrew Rasmussen](https://www.vim.org/scripts/script.php?script_id=4873).

## Notice
The aim of this package is to provide up-to-date support for gnuplot syntax. I'm basing the support for gnuplot 5.5 which is currently in development.

## Installation
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
This began as a personal project since I prefer the results of the plots made with gnuplot, so most of the syntax currently in the file is for my use case. Despite this, the package can handle almost all use cases of gnuplot. I'm looking forward to refine the syntax highlighting. PRs are welcome!
