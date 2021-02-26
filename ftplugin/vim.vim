
" Auto reloads a .vim file when saving it
augroup myvim
  au! BufWritePost *.vim ReloadVim
augroup END

