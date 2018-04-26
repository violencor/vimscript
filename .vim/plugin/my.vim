" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_my") || &cp
  finish
endif

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
ca shell Shell

nnoremap <leader>e :execute "Grep -rnIw " . expand("<cword>") . " . --exclude-dir=build" <Bar> cw<CR>:copen<CR>
nnoremap <leader>w :execute "grep -rnIw " . expand("<cword>") . " . --exclude-dir={build,p4,export,home,.rtags,.git}" <CR>:copen<CR>

" autocmd BufNewFile hpp, do pre_write
" write #pragma once & define into hpp file
function! s:AutoCreateHppHead(fileName)
    " get project root dir, otherwise `pwd` instead
    let projectRoot = system("pj-root")
    let projectRootLen = len(projectRoot) - 1
    if projectRootLen < 0
        let projectRoot = system("pwd")
        let projectRootLen = len(projectRoot) - 1
    endif

    " generate HPP header macro
    let rFileName = strpart(a:fileName, projectRootLen+1)
    let rFileName = substitute(rFileName, '\/', "_", "g")
    let rFileName = substitute(rFileName, '\.hpp', "_hpp", "g")
    let rFileName = toupper(rFileName)
    let rFileName = "_" . rFileName . "_"

    " generate and write HPP header
    let fileHead = []
    call add(fileHead, "#pragma once")
    call add(fileHead, "#ifndef " . rFileName)
    call add(fileHead, "#define " . rFileName)
    call add(fileHead, "\/*")
    call add(fileHead, " * ================================================================================")
    call add(fileHead, " *")
    call add(fileHead, " *  FileName: " . expand("%:t"))
    call add(fileHead, " *")
    call add(fileHead, " *  Description:")
    call add(fileHead, " *")
    call add(fileHead, " * ================================================================================")
    call add(fileHead, " *\/")
    call add(fileHead, "#endif // " . rFileName)
    call writefile(fileHead, a:fileName)

    " reload file(the "writefile" function may echo content into file in other process)
    edit

    " move cursor to line 3, cause u can edit file with 'o' immediately
    normal! Gk
endfunction
autocmd BufNewFile *.hpp :call <SID>AutoCreateHppHead(expand("%:p")) 
 
 
" do not jump(move cursor & screen) when searching with '*'
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>


" off & on diff when vimdiff
if &diff
    function! s:OffAndOnDiff()
        if g:vimdiff_diff == 1
            diffoff
            let g:vimdiff_diff = 0
        else
            diffthis
            let g:vimdiff_diff = 1
        endif
    endfunction

    let g:vimdiff_diff = 1
    nnoremap <leader>o :call <SID>OffAndOnDiff()<CR>
endif

" Abbreviations
" iabbrev { {<CR>}
