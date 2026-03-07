" Filetype plugin for Flux Schema Language (FSL)
" Language: FSL

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=//\ %s
setlocal comments=://,s:/*,mb:*,ex:*/
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal foldmethod=indent
setlocal foldlevel=99

let b:undo_ftplugin = "setlocal commentstring< comments< tabstop< shiftwidth< softtabstop< expandtab< foldmethod< foldlevel<"
