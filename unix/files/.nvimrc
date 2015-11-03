source ~/.vimrc

" ================ Pane separator =======================
" set fillchars+=vert:\

" Override color scheme to make split the same color as tmux's default
"autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=white ctermbg=NONE
"highlight VertSplit cterm=NONE ctermfg=NONE ctermbg=white

" ================ Custom command =======================
" Selecting all the file content
:map <C-a> ggVG$
" tab navigation
:map <A-h> :tabprevious<CR>
:map <A-l> :tabnext<CR>

" Move lines
:nnoremap <C-S-j> : m .+1<CR>
:nnoremap <C-S-k> : m .-2<CR>
:vnoremap <C-S-k> : m '<-2<CR>gv=gv
:vnoremap <C-S-j> : m '>+1<CR>gv=gv

" ================ NeoVim terminal =======================
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

:map <left> h
:map <right> l
:map <up> k
:map <down> j
:map <A-left> <A-h>
:map <A-right> <A-l>
:map <A-up>   <A-k>
:map <A-down> <A-j>

" ================ Ranger =======================
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<A-j>'
let g:multi_cursor_prev_key='<A-S-j>'
let g:multi_cursor_skip_key='<A-k>'
let g:multi_cursor_quit_key='<Esc>'

" ================ Ranger =======================
function! RangerMagic()
    new
    call termopen('terminal ranger --choosefile=/tmp/chosenfile ')
    startinsert
    bdelete!
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . readfile('/tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
endfunction

function! RangerTest(dirname)
	if exists('g:rangered')
		let rangered = g:rangered
		unlet g:rangered

		if !filereadable(rangered)
			return
		endif

		let names = readfile(rangered)

		if empty(names)
			return
		endif

		exec 'tabe' . fnameescape(names[0])
        filetype detect

		for name in names[1:]
            exec 'tabe ' . fnameescape(name)
            filetype detect
        endfor
	elseif isdirectory(a:dirname)
		let g:rangered = '/tmp/chosenfile'
		new
		call termopen('ranger --choosefiles=' . shellescape(g:rangered) . ' ' . shellescape(a:dirname))
        startinsert
        bdelete!
	endif
endfunction
