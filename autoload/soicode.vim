let s:plugindir = expand('<sfile>:p:h:h')
let s:cppflags = "-Wall -Wextra -fdiagnostics-color=never -Wno-sign-compare -std=c++20 -O2 -static "
let s:soiheader = "-I " . s:plugindir . "/soiheaders/bundle/soiheader/"

function! soicode#CreateStoml()
    let file = expand('%:p:r') . '.stoml'
    execute 'edit ' . file
    execute "normal! i\<C-r>+\<Esc>"
    write
endfunction

function! soicode#EditStoml()
    let file = expand('%:p:r') . '.stoml'
    execute 'edit ' . file
endfunction

function! soicode#ListOfSamples(A = "", B = "", C = "")
    let file = readfile(expand('%:p:r') . '.stoml')
    let samples = []
    for line in file
        let pre = stridx(line, '[')
        let post = stridx(line, ']')
        if (pre >= 0 && post >= 0)
            call add(samples, line[pre+1:post-1])
        endif
    endfor
    return samples
endfunction

function! soicode#InsertTemplate()
    let template = s:plugindir . "/template/soi.cpp"
    1,$d
    if filereadable(expand("~/templates/soi.cpp"))
        let template =  "~/tmeplates/soi.cpp"
    endif
    if filereadable(expand("~/.config/nvim/templates/soi.cpp"))
        let template =  "~/.config/nvim/templates/soi.cpp"
    endif
    execute "read " . template
    execute "normal! kddG3kA"
endfunction

function! soicode#LoadKeybindings()
    nnoremap <leader>rs :SOIRunOneSample
    nnoremap <leader>ra :SOIRunAllSamples<CR>
    nnoremap <leader>ro :SOIRunWithOwnInput<CR>
    nnoremap <leader>st :SOIInsertTemplate<CR>
    nnoremap <leader>ct :SOICreateStoml <CR>
    nnoremap <leader>et :SOIEditStoml <CR>
endfunction

function! soicode#MakeClangDFile(cwd)
    if file == ""
        let l:path = expand("%:p:h")
        call s:createClangDFile(l:path)
    else
        let l:filepath = a:cwd
        let l:path = l:filepath
        while stridx(l:filepath, "soi") >= 0
            let l:path = l:filepath
            let l:filepath = l:filepath[:-2]
        endwhile
        call s:createClangDFile(l:path)
    endif
endfunction

function! soicode#RunAllSamples()
    write
    let compiler = s:compileCppFile()
    let filename = expand('%:p:r')
    let samples = soicode#ListOfSamples()
    split output
    1,$d
    if trim(compiler) != ""
        execute "normal! iCompiler:\n" . compiler . "\<Esc>"
        let linenum = line('.')
        call matchaddpos("Error", [linenum]) 
    else
        for sample in samples
            call s:runOneSample(sample, filename)
        endfor
    endif
    write
endfunction

function! soicode#RunSample(sample)
    write
    let compiler = s:compileCppFile()
    let filename = expand('%:p:r')
    split output
    1,$d

    if trim(compiler) != ""
        execute "normal! iCompiler:\n" . compiler . "\<Esc>"
        let linenum = line('.')
        call matchaddpos("Error", [linenum]) 
    else
        call s:runOneSample(a:sample, filename)
    endif
    write
endfunction

function! soicode#RunWithOwnInput()
    write
    let compiler = s:compileCppFile()
    echo compiler
    vsplit
    execute "term " . expand('%:p:r')
endfunction

function! s:compileCppFile()
    let output = system("g++ " . s:cppflags . " " . s:soiheader . " ". expand('%:p') ." -o " . expand("%:p:r"))
    return output
endfunction

function! s:runOneSample(sample, filename)
    let input = system('stoml ' . a:filename . '.stoml ' . a:sample . '.input')
    let expected = system('stoml ' . a:filename . '.stoml ' . a:sample . '.output')

    let command = 'echo "' . input . '" | ' . a:filename
    let output = system(command)

    " execute "normal! iCommand:\n" . command . "\n\n\<Esc>"
    execute "normal! iRunning sample '" . a:sample . "'\n\<Esc>"
    let linenum = line('.')-1
    call matchaddpos("DiagnosticInfo", [linenum]) 

    let realExpected = trim(substitute(expected, "[ \r\n]\\+", " ", "g"))
    let realOutput = trim(substitute(output,     "[ \r\n]\\+", " ", "g"))
    if realExpected == realOutput
        execute "normal! iSample '" . a:sample . "' successful!\n\<Esc>"
        let linenum = line('.')-1
        call matchaddpos("Title", [linenum]) 
    else
        execute "normal! i" . a:sample . " failed!\n\<Esc>"
        let linenum = line('.')-1
        call matchaddpos("DiagnosticUnderlineError", [linenum]) 

        " execute "normal! iExpected:\n" . expected . "\n\<Esc>"
        execute "normal! iExpected:\n" . realExpected . "\n\<Esc>"
        call matchaddpos("Todo", [linenum+1]) 
        let currline = line('.')-1
        for line in range(linenum+2, currline)
            call matchaddpos("Function", [line]) 
        endfor
        let linenum = currline
        execute "normal! iActual:\n" . realOutput . "\n\<Esc>"
        call matchaddpos("Todo", [linenum+1]) 
        let currline = line('.')-1
        for line in range(linenum+2, currline)
            call matchaddpos("Constant", [line]) 
        endfor
        let linenum = currline
        execute "normal! iInput:\n" . input . "\n\<Esc>"
        call matchaddpos("Todo", [linenum+1]) 
        let currline = line('.')-1
        for line in range(linenum+2, currline)
            call matchaddpos("Number", [line]) 
        endfor
    endif
    execute "normal! i\n\<Esc>"
endfunction

function! s:createClangDFile(path)
    let compileFlags = "CompileFlags:\\n" . "  Add:\\n" . "    - \"" . s:soiheader . "\""
    execute "!touch " . a:path . "/.clangd"
    execute "!echo '" . compileFlags ."' > " . a:path . "/.clangd"
endfunction
