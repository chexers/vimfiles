
" Auto open an close nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree auto cwd to logical parent
function! s:setcwd()
  let cph = expand('%:p:h', 1)
  if cph =~ '^.\+://' | retu | en
  for mkr in ['.git/', '.hg/', '.svn/', '.bzr/', '_darcs/', '.vimprojects']
    let wd = call('find'.(mkr =~ '/$' ? 'dir' : 'file'), [mkr, cph.';'])
    if wd != '' | let &acd = 0 | brea | en
  endfo
  exe 'lc!' fnameescape(wd == '' ? cph : substitute(wd, mkr.'$', '.', ''))
endfunction
autocmd BufEnter * call s:setcwd()
