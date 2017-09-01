
command! Configs       NERDTree ~/dotfiles

command! Config        tabedit  ~/dotfiles/vim/rc.vim
command! Commands      tabedit  ~/dotfiles/vim/cmd.vim
command! Mappings      tabedit  ~/dotfiles/vim/map.vim
command! Options       tabedit  ~/dotfiles/vim/opt.vim

command! WriteFile     write! %
command! ReloadVim     source $MYVIMRC 
command! MakeExe       !chmod +x %
command! RunExe        !bash %

command! SHScript      !echo -e "#!/bin/bash\n#vi:ft=sh\\\n\\\n" > /tmp/scratch | tabedit /tmp/scratch

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
