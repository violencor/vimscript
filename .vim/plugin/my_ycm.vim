let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
nnoremap <leader>f :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path = '/usr/bin/python'
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 自动触发
let g:ycm_auto_trigger = 1
" 触发条件
let g:ycm_semantic_triggers = {
            \ 'c' : ['->' , '.'],
            \ 'cpp,objcpp' : ['->','.','::'],
            \}
" 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_tags_files=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
"回车即选中当前项
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
let g:ycm_key_invoke_completion = '<C-a>'
let g:ycm_show_diagnostics_ui = 0
