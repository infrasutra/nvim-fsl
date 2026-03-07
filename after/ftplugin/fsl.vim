" After filetype plugin for FSL — auto-closing pairs and indent

if exists("b:did_fsl_after_ftplugin")
  finish
endif
let b:did_fsl_after_ftplugin = 1

" Auto-close braces and indent
inoremap <buffer> { {}<Left>
inoremap <buffer> [ []<Left>
inoremap <buffer> ( ()<Left>

" Auto-close braces with newline indent
inoremap <buffer><expr> <CR> getline('.')[col('.')-2] == '{' ? '<CR><CR>}<Up><Tab>' : '<CR>'

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
      \ . '| iunmap <buffer> {'
      \ . '| iunmap <buffer> ['
      \ . '| iunmap <buffer> ('
      \ . '| iunmap <buffer> <CR>'
