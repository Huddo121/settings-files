:set number  " Set up line numbers

" Use spaces instead of tabs, default to 4 spaces
:set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Neovim plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
call plug#end()

colorscheme onedark

