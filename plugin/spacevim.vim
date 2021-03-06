" spacevim.vim - Spacemacs key bindings for vim.
" Maintainer:   Camille Tjhoa <http://github.com/ctjhoa>
" Version:      1.0

if exists('g:loaded_spacevim')
  finish
endif
let g:loaded_spacevim = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Optionally integrate with vim-leader-guide
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:lmap')
  let g:lmap = {}
endif

if exists('loaded_leaderGuide_vim')
  function! s:spacevim_displayfunc()
    let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
    let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '^<SID>', '', '')
  endfunction
  if exists('g:leaderGuide_displayfunc')
    call add(g:leaderGuide_displayfunc, function("s:spacevim_displayfunc"))
  else
    let g:leaderGuide_displayfunc = [function('s:spacevim_displayfunc')]
  endif

  call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
  nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
  vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helpers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:spacevim_bind(map, binding, name, value, isCmd)
  if a:isCmd
    let l:value = ':' . a:value . '<cr>'
  else
    let l:value = a:value
  endif
  if a:map == "map"
    let l:noremap = 'noremap'
  elseif a:map == "nmap"
    let l:noremap = 'nnoremap'
  elseif a:map == "vmap"
    let l:noremap = 'vnoremap'
  endif
  execute l:noremap . " <silent> <SID>" . a:name . " " . l:value
  execute a:map . " <leader>" . a:binding . " <SID>" . a:name
endfunction

function! s:spacevim_get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - 2]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call s:spacevim_bind('map', '<Tab>', 'last-buffer', 'b#', 1)
call s:spacevim_bind('map', '!', 'shell-cmd', 'call feedkeys(":! ")', 1)
call s:spacevim_bind('map', '/', 'smart-search', 'Ag', 1)
call s:spacevim_bind('nmap', '*', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(0)', 1)
call s:spacevim_bind('vmap', '*', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(1)', 1)

call s:spacevim_bind('map', '0', 'window-0', '1wincmd w', 1)
call s:spacevim_bind('map', '1', 'window-1', '2wincmd w', 1)
call s:spacevim_bind('map', '2', 'window-2', '3wincmd w', 1)
call s:spacevim_bind('map', '3', 'window-3', '4wincmd w', 1)
call s:spacevim_bind('map', '4', 'window-4', '5wincmd w', 1)
call s:spacevim_bind('map', '5', 'window-5', '6wincmd w', 1)
call s:spacevim_bind('map', '6', 'window-6', '7wincmd w', 1)
call s:spacevim_bind('map', '7', 'window-7', '8wincmd w', 1)
call s:spacevim_bind('map', '8', 'window-8', '9wincmd w', 1)
call s:spacevim_bind('map', '9', 'window-9', '10wincmd w', 1)

call s:spacevim_bind('map', ':', 'M-x', 'call SpacevimCommands()', 1)
call s:spacevim_bind('nmap', ';', 'vim-commentary-operator', 'Commentary', 1)
nmap <silent> <SID>vim-commentary-line <Plug>(CommentaryLine)
nmap <Leader>;; <SID>vim-commentary-line
call s:spacevim_bind('vmap', ';', 'vim-commentary-operator', '''<,''>Commentary', 1)

" applications {{{
let g:lmap.a = { 'name' : '+applications' }
call s:spacevim_bind('map', 'au', 'undo-tree-visualize', 'UndotreeToggle', 1)
" }}}

" buffers {{{
let g:lmap.b = { 'name' : '+buffers' }
call s:spacevim_bind('map', 'bb', 'buffers', 'call SpacevimBuffers()', 1)
call s:spacevim_bind('map', 'bd', 'kill-this-buffer', 'bd', 1)
call s:spacevim_bind('map', 'bn', 'next-useful-buffer', 'bnext', 1)
call s:spacevim_bind('map', 'bp', 'previous-useful-buffer', 'bprevious', 1)
call s:spacevim_bind('map', 'bR', 'safe-revert-buffer', 'e', 1)

" buffers/move {{{
let g:lmap.b.m = { 'name' : '+move' }
call s:spacevim_bind('map', 'bmr', 'buf-rotate-down-right', 'wincmd r', 1)
call s:spacevim_bind('map', 'bmR', 'buf-rotate-up-left', 'wincmd R', 1)
" }}}

" }}}

" comile/comments {{{
let g:lmap.c = { 'name' : '+compile/comments' }
" }}}

" capture/colors {{{
let g:lmap.C = { 'name' : '+capture/colors' }
" }}}

" errors {{{
let g:lmap.e = { 'name' : '+errors' }
call s:spacevim_bind('map', 'el', 'error-list', 'call SpacevimErrorList()', 1)
call s:spacevim_bind('map', 'en', 'next-error', 'call SpacevimErrorNext()', 1)
call s:spacevim_bind('map', 'eN', 'previous-error', 'call SpacevimErrorPrev()', 1)
call s:spacevim_bind('map', 'ep', 'previous-error', 'call SpacevimErrorPrev()', 1)
" }}}

" files {{{
let g:lmap.f = { 'name' : '+files' }
call s:spacevim_bind('map', 'fc', 'copy-file', 'saveas', 1)

" files/convert {{{
let g:lmap.f.C = { 'name' : '+files/convert' }
" }}}

call s:spacevim_bind('map', 'fD', 'delete-current-buffer-file', 'Remove', 1)
call s:spacevim_bind('map', 'fE', 'sudo-edit', 'call feedkeys(":SudoEdit ")', 1)
call s:spacevim_bind('map', 'ff', 'find-files', 'call SpacevimFindFiles()', 1)
call s:spacevim_bind('map', 'fL', 'locate', 'call feedkeys(":Locate ")', 1)
call s:spacevim_bind('map', 'fr', 'recentf', 'call SpacevimRecentf()', 1)
call s:spacevim_bind('map', 'fR', 'rename-current-buffer-file', 'call feedkeys(":Rename ")', 1)
call s:spacevim_bind('map', 'fs', 'save-buffer', 'write', 1)
call s:spacevim_bind('map', 'fS', 'write-all', 'wa', 1)
call s:spacevim_bind('map', 'ft', 'explorer-toggle', 'call SpacevimExplorerToggle()', 1)

" files/vim {{{
let g:lmap.f.e = { 'name' : '+vim' }
call s:spacevim_bind('map', 'fed', 'find-dotfile', 'edit $MYVIMRC', 1)
call s:spacevim_bind('map', 'feR', 'sync-configuration', 'source $MYVIMRC', 1)
call s:spacevim_bind('map', 'fev', 'display-vim-version', 'version', 1)
" }}}

" }}}

" git/versions-control {{{
let g:lmap.g = { 'name' : '+git/versions-control' }
call s:spacevim_bind('map', 'gb', 'git-blame', 'Gblame', 1)
call s:spacevim_bind('map', 'gc', 'git-commit', 'Gcommit', 1)
call s:spacevim_bind('map', 'gC', 'git-checkout', 'Git checkout', 1)
call s:spacevim_bind('map', 'gd', 'git-diff', 'Gdiff', 1)
call s:spacevim_bind('map', 'gD', 'git-diff-head', 'Gdiff HEAD', 1)
call s:spacevim_bind('map', 'gf', 'git-fetch', 'Gfetch', 1)
call s:spacevim_bind('map', 'gF', 'git-pull', 'Gpull', 1)
call s:spacevim_bind('map', 'gi', 'git-init', 'Git init', 1)
call s:spacevim_bind('map', 'gl', 'git-log', 'call SpacevimGitLog()', 1)
call s:spacevim_bind('map', 'gr', 'git-checkout-current-file', 'Gread', 1)
call s:spacevim_bind('map', 'gR', 'git-remove-current-file', 'Gremove', 1)
call s:spacevim_bind('map', 'gs', 'git-status', 'Gstatus', 1)
call s:spacevim_bind('map', 'gS', 'git-stage-file', 'call feedkeys(":Git add -- ")', 1)
call s:spacevim_bind('map', 'gw', 'git-stage-current-file', 'Gwrite', 1)
" }}}

" help/highlight {{{
let g:lmap.h = { 'name' : '+help/highlight' }
" }}}

" insertion {{{
let g:lmap.i = { 'name' : '+insertion' }
call s:spacevim_bind('nmap', 'ij', 'vim-insert-line-below', 'mao<Esc>`a', 0)
call s:spacevim_bind('nmap', 'ik', 'vim-insert-line-above', 'maO<Esc>`a', 0)
" }}}

" join/split {{{
let g:lmap.j = { 'name' : '+join/split' }
call s:spacevim_bind("nmap", "j=", "indent-region-or-buffer", "mzgg=G`z", 0)
call s:spacevim_bind("vmap", "j=", "indent-region-or-buffer", "==", 0)
call s:spacevim_bind('map', 'jj', 'sp-newline', 'i<CR><Esc>', 0)
call s:spacevim_bind('map', 'jJ', 'split-and-newline', 'i<CR><Esc>', 0) " same as j.j ?
call s:spacevim_bind('map', 'jo', 'open-line', 'i<CR><Esc>k$', 0)

" }}}

" lisp {{{
let g:lmap.k = { 'name' : '+lisp' }
" }}}

" narrow/numbers {{{
let g:lmap.n = { 'name' : '+narrow/numbers' }
call s:spacevim_bind('map', 'n=', 'numbers-increase', '<C-a>', 0)
call s:spacevim_bind('map', 'n+', 'numbers-increase', '<C-a>', 0)
call s:spacevim_bind('map', 'n-', 'numbers-decrease', '<C-x>', 0)
call s:spacevim_bind('map', 'n,', 'page-up', '<PageUp>', 0)
call s:spacevim_bind('map', 'n.', 'page-down', '<PageDown>', 0)
call s:spacevim_bind('map', 'n<lt>', 'half-page-up', '<C-u>', 0)
call s:spacevim_bind('map', 'n>', 'half-page-down', '<C-d>', 0)
" }}}

" projects {{{
let g:lmap.p = { 'name' : '+projects' }
call s:spacevim_bind('map', 'pf', 'project-find-file', 'call SpacevimProjectFindFile()', 1)
call s:spacevim_bind('map', 'pD', 'project-directory', 'call SpacevimProjectDirectory()', 1)
call s:spacevim_bind('map', 'pI', 'project-invalidate-cache', 'call SpacevimProjectInvalidateCache()', 1)
" }}}

" quit {{{
let g:lmap.q = { 'name' : '+quit' }
call s:spacevim_bind('map', 'qq', 'prompt-kill-vim', 'quit', 1)
call s:spacevim_bind('map', 'qQ', 'kill-vim', 'quit!', 1)
call s:spacevim_bind('map', 'qs', 'save-buffers-kill-vim', 'xa', 1)
" }}}

" registers/rings {{{
let g:lmap.r = { 'name' : '+registers/rings' }
" }}}

" search/symbol {{{
let g:lmap.s = { 'name' : '+search/symbol' }
call s:spacevim_bind('map', 'sc', 'highlight-persist-remove-all', 'noh', 1)
call s:spacevim_bind('map', 'sp', 'smart-search', 'Ag', 1)
call s:spacevim_bind('nmap', 'sP', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(0)', 1)
call s:spacevim_bind('vmap', 'sP', 'smart-search-with-input', 'call SpacevimSmartSearchWithInput(1)', 1)
" }}}

" toggles {{{
let g:lmap.t = { 'name' : '+toggles' }
call s:spacevim_bind('map', 'tl', 'truncate-line', 'set invwrap', 1)
call s:spacevim_bind('map', 'tn', 'line-numbers', 'set invnumber', 1)
call s:spacevim_bind('map', 'tr', 'linum-relative-toggle', 'set invrelativenumber', 1)

" registers/rings {{{
let g:lmap.t.h = { 'name' : '+highlight' }
call s:spacevim_bind('nmap', 'thc', 'highlight-indentation-current-column', 'set invcursorcolumn', 1)
call s:spacevim_bind('nmap', 'thl', 'highlight-current-line-globaly', 'set invcursorline', 1)
" }}}

" }}}

" UI toggles/themes {{{
let g:lmap.T = { 'name' : '+UI toggles/themes' }
call s:spacevim_bind('map', 'Td', 'version-control-margin', 'GitGutterToggle', 1)
" }}}

" windows {{{
let g:lmap.w = { 'name' : '+windows' }
call s:spacevim_bind('map', 'w-', 'split-window-below', 'split', 1)
call s:spacevim_bind('map', 'w/', 'split-window-right', 'vsplit', 1)
call s:spacevim_bind('map', 'w=', 'balance-windows', 'wincmd =', 1)
call s:spacevim_bind('map', 'wc', 'delete-window', 'q', 1)
call s:spacevim_bind('map', 'wh', 'window-left', 'wincmd h', 1)
call s:spacevim_bind('map', 'wH', 'window-move-far-left', 'wincmd H', 1)
call s:spacevim_bind('map', 'wj', 'window-down', 'wincmd j', 1)
call s:spacevim_bind('map', 'wJ', 'window-move-far-down', 'wincmd J', 1)
call s:spacevim_bind('map', 'wk', 'window-up', 'wincmd k', 1)
call s:spacevim_bind('map', 'wK', 'window-move-far-up', 'wincmd K', 1)
call s:spacevim_bind('map', 'wl', 'window-right', 'wincmd l', 1)
call s:spacevim_bind('map', 'wL', 'window-move-far-right', 'wincmd L', 1)
call s:spacevim_bind('map', 'wm', 'maximize-buffer', 'call SpacevimMaximizeBuffer()', 1)
call s:spacevim_bind('map', 'ws', 'split-window-below', 'split', 1)
call s:spacevim_bind('map', 'wS', 'split-window-below-and-focus', 'split\|wincmd w', 1)
call s:spacevim_bind('map', 'wv', 'split-window-right', 'vsplit', 1)
call s:spacevim_bind('map', 'wV', 'split-window-right-and-focus', 'vsplit\|wincmd w', 1)
call s:spacevim_bind('map', 'ww', 'other-window', 'wincmd w', 1)

" }}}

" text {{{
let g:lmap.x = { 'name' : '+text' }
" }}}

nmap <silent> <SID>easymotion-line <Plug>(easymotion-bd-jk)
nmap <Leader>y <SID>easymotion-line
vmap <silent> <SID>easymotion-line <Plug>(easymotion-bd-jk)
vmap <Leader>y <SID>easymotion-line

" zoom {{{
let g:lmap.z = { 'name' : '+zoom' }
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! SpacevimBuffers()
  if exists(':Buffers')
    execute "Buffers"
  elseif exists('g:loaded_unite')
    execute "Unite -start-insert buffer"
  elseif exists('g:loaded_ctrlp')
    execute "CtrlPBuffer"
  else
    execute "buffers"
  endif
endfunction

function! SpacevimCommands()
  if exists(':Commands')
    execute "Commands"
  elseif exists('g:loaded_unite')
    execute "Unite -start-insert command"
  else
    execute "call feedkeys(\":\<Tab>\")"
  endif
endfunction

function! SpacevimExplorerToggle()
  if exists(':NERDTreeToggle')
    execute "NERDTreeToggle"
  elseif exists('g:loaded_dirvish')
    execute "Dirvish"
  else
    execute "Lexplore"
  endif
endfunction

function! SpacevimErrorList()
  let old_last_winnr = winnr('$')
  SyntasticToggleMode
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    SyntasticCheck
  endif
endfunction

" fixes some weirdness in the case of only one error
" SEE: https://github.com/scrooloose/syntastic/issues/32
" also causes it to cycle around, which is quite nice!
function! SpacevimErrorPrev()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! SpacevimErrorNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

function! SpacevimFindFiles()
  if exists(':Files')
    execute "Files %:h"
  elseif exists('g:loaded_unite')
    execute "Unite -start-insert file"
  elseif exists('g:loaded_ctrlp')
    execute "CtrlPCurFile"
  endif
endfunction

function! SpacevimGitLog()
  if exists(':GV')
    execute "GV"
  else
    execute "silent! Glog<CR>:bot copen"
  endif
endfunction

function! SpacevimMaximizeBuffer()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

function! SpacevimProjectDirectory()
  if exists(':ProjectRootExe')
    if exists(':NERDTreeToggle')
      execute "ProjectRootExe NERDTreeToggle"
    elseif exists('g:loaded_dirvish')
      execute "ProjectRootExe Dirvish"
    else
      execute "ProjectRootExe Lexplore"
    endif
  else
    call SpacevimExplorerToggle()
  endif
endfunction

function! SpacevimProjectFindFile()
  if exists(':GitFiles')
    execute "GitFiles"
  elseif exists('g:loaded_unite')
    execute "UniteWithProjectDir -start-insert file_rec/async"
  elseif exists('g:loaded_ctrlp')
    execute "CtrlPRoot"
  endif
endfunction

function! SpacevimProjectInvalidateCache()
  if exists('g:loaded_unite')
    execute "call feedkeys(\":UniteWithProjectDir\<CR>\<C-l>\<Esc>\")"
  elseif exists('g:loaded_ctrlp')
    execute "CtrlPClearCache"
  endif
endfunction

function! SpacevimRecentf()
  if exists(':History')
    execute "History"
  elseif exists('g:loaded_unite')
    execute "Unite -start-insert file_mru"
  elseif exists('g:loaded_ctrlp')
    execute "CtrlPMRU"
  else
    execute "oldfiles"
  endif
endfunction

function! SpacevimSmartSearchWithInput(visual)
  if a:visual
    execute "Ag " . <SID>spacevim_get_visual_selection()
  else
    execute "Ag " . expand("<cword>")
  endif
endfunction

" vim:set ft=vim sw=2 sts=2 et:
" vim:fdm=marker
