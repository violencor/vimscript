function! s:Elog(msg)
    echohl WarningMsg
    echomsg a:msg
    echohl None
endfunction

function! s:FindProjectRoot()
    let projectRoot = system("pj-root")
    let projectRootLen = len(projectRoot)
    return strpart(projectRoot, 0, projectRootLen-1)
endfunction

function! s:FindRdmSocketFile(projectRoot)
    let socketFile = a:projectRoot . '/.rtags/rdm.socket'
    return socketFile
endfunction

" execute system cmd and format rc ret into quickfix-list
function! s:ExecuteCmdAndFormat2Qf(cmd, projectRoot)
    let rcRet = systemlist(a:cmd)
    " echom string(rcRet)

    " format rc ret into quickfix-list
    let list = []
    if v:shell_error
        " rc executed failed
        call s:Elog("Failed with error code " . v:shell_error . ". ". string(rcRet))
    else
        for symbol in rcRet
            " echo symbol
            let ANY='.\{-}'
            let matches = matchlist(symbol, '\('.ANY.'\):\('.ANY.'\):\('.ANY.'\):\t\(.*\)')
            " echo matches
            if len(matches) == 0
                call s:Elog("find symbol : " . symbol)
                continue
            endif
            " rtags可能返回绝对路径,也可能返回相对路径
            if matches[1][0] == '/' || matches[1][0] == '~'
                let pathName = matches[1]
            else
                let pathName = a:projectRoot . '/' . matches[1]
            endif
            let lineNum = matches[2]
            let colNum = matches[3]
            let lineText = matches[4]
            let list += [{'filename' : pathName, 'lnum' : lineNum, 'col' : colNum, 'text' : lineText}]
        endfor
    endif

    " if list empty -> echo warnning message
    " set quickfix-list & open it
    " if list has only one element -> jump to first
    " if list serval elements -> just keep open
    let list_len = len(list)
    if list_len == 0
        echom "WARNNING : Cannot find any Symbol!"
    else
        call setqflist(list)
        copen
        if list_len == 1
            cfirst
            ccl
        endif
    endif

endfunction

" find define or declaration
function! s:FindDefine(location)
    " execute rtags rc command
    let projectRoot = <SID>FindProjectRoot()
    let socketFile = <SID>FindRdmSocketFile(projectRoot)
    let cmd = "rc -b --all-targets --socket-file=" . socketFile . " -f " . a:location

    call s:ExecuteCmdAndFormat2Qf(cmd, projectRoot)
endfunction

" find references
function! s:FindReference(location)
    " execute rtags rc command
    let projectRoot = <SID>FindProjectRoot()
    let socketFile = <SID>FindRdmSocketFile(projectRoot)
    let cmd = "rc -b --all-targets --socket-file=" . socketFile . " -r " . a:location

    call s:ExecuteCmdAndFormat2Qf(cmd, projectRoot)
endfunction

" get mouse location -> execute rtags find -> open quickfix-list -> jump to define -> close quickfix-list
nnoremap <leader>d :call <SID>FindDefine(expand('%:p') . ":" . line(".") . ":" . col("."))<CR>
" get mouse location -> execute rtags find -> open quickfix-list -> show reference list
nnoremap <leader>r :call <SID>FindReference(expand('%:p') . ":" . line(".") . ":" . col("."))<CR>
