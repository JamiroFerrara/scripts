"--------------------------------------------------------------------------
"GENERAL SETTINS
"--------------------------------------------------------------------------
set expandtab
set shiftwidth=4
set tabstop=6
set hidden
set noerrorbells
set signcolumn=yes
set relativenumber
set noswapfile
set number
set termguicolors
set undofile
set spell
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=15
set sidescrolloff=15
set nojoinspaces
set splitright
set clipboard=unnamedplus
set confirm
set exrc
set backup
set backupdir=~/.local/share/nvim/backup//
set updatetime=300 " Reduce time for highlighting other references
set redrawtime=10000 " Allow more time for loading syntax on large files
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftround
set softtabstop=-1
set textwidth=80
set nofixendofline
set nostartofline
set splitbelow
set hlsearch
set incsearch
set laststatus=2
set noruler
set noshowmode

"-------------------------------------------------------------------------------------------------------------------
" PLUGINS
"-------------------------------------------------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'cormacrelf/vim-colors-github'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ThePrimeagen/harpoon'

Plug 'preservim/nerdtree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'tomasiser/vim-code-dark'
Plug 'projekt0n/github-nvim-theme'

Plug 'romgrk/barbar.nvim'

"Autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'

Plug 'Raimondi/delimitMate'
Plug 'sbdchd/neoformat' 

Plug 'kyazdani42/nvim-web-devicons'

"Markdown
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'vimwiki/vimwiki'

Plug 'yuezk/vim-js'

Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/yajs.vim'
Plug 'alvan/vim-closetag'

Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
Plug 'ap/vim-css-color'

call plug#end()
doautocmd User PlugLoaded

"ColorScheme
" use a slightly darker background, like GitHub inline code blocks
let g:github_colors_soft = 1

" use the dark theme
set background=dark

" more blocky diff markers in signcolumn (e.g. GitGutter)
let g:github_colors_block_diffmark = 0

colorscheme github_*
let g:airline_theme = "github"
let g:lightline = { 'colorscheme': 'github' }


if !exists('g:neovide')
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight TabLine guibg = none
    highlight TabLineFill guibg = none
    highlight StatusLine guibg = none
    highlight StatusLineNC guibg = none
    highlight CursorColumn guibg = none
    highlight CursorLine guibg = none
    highlight NormalNC guibg = none
    highlight VertSplit guibg = none
    highlight TelescopeNormal guibg = none
    highlight TelescopePromptNormal guibg = none
    highlight TelescopePreviewNormal guibg = none
    highlight clear LineNr
    highlight clear SignColumn
endif
"-------------------------------------------------------------------------------------------------------------------
" NEOVIDE SETTINGS
"-------------------------------------------------------------------------------------------------------------------
let g:neovide_transparency=0
let g:neovide_no_idle=v:true
let g:neovide_cursor_animation_length=0.07
let g:neovide_cursor_trail_length=0.10
let g:neovide_cursor_vfx_mode = "wireframe"
let g:neovide_cursor_vfx_opacity=80.0
let g:neovide_remember_window_size = v:true

"-------------------------------------------------------------------------------------------------------------------
" KEY MAPS
"-------------------------------------------------------------------------------------------------------------------

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'

let mapleader = "\<space>"

nmap <leader>ve :edit ~/AppData/Local/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>
nnoremap <leader>pi :so%<cr>:PlugInstall<cr>
"nnoremap <leader>cd 

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain the cursor position when yanking a visual selection
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
"noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
"noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
"vnoremap p "_dP

"Redo
nnoremap U :redo<cr>

" Make Y behave like the other capitals
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

map J <S-}>
map K <S-{>
nnoremap <leader>a %i
nnoremap <leader>A %i<Esc>vib
nnoremap <leader>{ o<esc>kA<Enter>{<Del><enter>}<esc>O
nnoremap <leader>i /}<Enter>ko
nnoremap <leader>I /}<Enter>%<Enter>
nnoremap <leader>n gg/#region<Enter>
nnoremap dD ddko

nnoremap f /
nnoremap F ?
nnoremap <leader>d "ryiw/<C-r>r<cr>
nnoremap <leader>w :q<cr>

"Quicky escape to normal mode
imap jj <esc>:w<cr>
imap jJ <esc>:wq!<cr>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
"imap ,, <Esc>A,<Esc>

cmap w!! %!sudo tee > /dev/null %
map <M-a> :NERDTree<cr>

"Font And Scaling
set guifont=CaskaydiaCove\ NF:h13
nnoremap - :Goyo!<cr>:NoPencil<cr>
nnoremap è :Goyo!<cr>:NoPencil<cr>
nnoremap + :Goyo<cr>:SoftPencil<cr>

" setup folding
autocmd BufNewFile,BufRead *.cs set foldmethod=syntax

nnoremap <leader>o za
onoremap <leader>o <C-C>za
vnoremap <leader>o zf

nnoremap <leader>p zm
onoremap <leader>p <C-C>zm
vnoremap <leader>p zr<cr>

"Window Movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>j J 
nnoremap <A-s> :vsp<cr><C-o>
nnoremap <A-S> :sp<cr><C-o>

"Barbar
nnoremap H :BufferPrevious<CR>
nnoremap L :BufferNext<CR>
nnoremap <C-b> :BufferPick<CR>
nnoremap <C-w> :BufferClose<CR>
inoremap <C-w> <Esc>:BufferClose<CR>
noremap <C-w> :BufferClose<CR>
noremap <C-n> :f<CR>

nnoremap <C-q> :q<cr>
nnoremap <M-q> :q<cr>

"Harpoon
nnoremap <leader>m :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>M :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap 1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap 2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap 3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap 4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap 5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap 6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap 7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap 8 :lua require("harpoon.ui").nav_file(8)<CR>

"-------------------------------------------------------------------------------------------------------------------
"OMNISHARP
"-------------------------------------------------------------------------------------------------------------------

"Cs Regions Collapse
"let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

"if !exists("autocommands_loaded")
""    let autocommands_loaded = 1
"endif

"":let g:OmniSharp_highlighting = 3<cr> :OmniSharpCodeFormat<CR>
nnoremap <C-s> :w<cr>
imap <C-s> <Esc>:w<cr>

"nnoremap gr :OmniSharpFindUsages<CR>
"nnoremap gd :OmniSharpGotoDefinition<CR>
"nnoremap gD :vsp<cr>:OmniSharpGotoDefinition<CR>
"nnoremap pd :OmniSharpPreviewDefinition<CR>

"autocmd FileType cs nmap <silent> <buffer> M <Plug>(omnisharp_navigate_up)
"autocmd FileType cs nmap <silent> <buffer> m <Plug>(omnisharp_navigate_down)

"inoremap <expr> <Tab> pumvisible() ? '<C-n>' : \ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

"Asyncomplete
"set completeopt=menuone,noinsert,noselect,preview
"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_completeopt = 0
"let g:asyncomplete_force_refresh_on_context_changed = 1

"let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_highlight_types = 2

" if using ultisnips, set g:OmniSharp_want_snippet to 1
"let g:OmniSharp_want_snippet = 1
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

"set completeopt=menuone,noinsert,noselect,popuphidden
"set completepopup=highlight:Pmenu,border:off

"augroup ColorschemePreferences
""  autocmd!
  " Link ALE sign highlights to similar equivalents without background colours
""  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
""  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
""  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
"augroup END

" ALE: {{{
"let g:ale_sign_error = ''
"let g:ale_sign_warning = '•'
"let g:ale_sign_info = '·'
"let g:ale_sign_style_error = '·'
"let g:ale_sign_style_warning = '·'
"let g:ale_lsp_show_message_severity='disabled' NOT WORKING
"let g:ale_linters = { 'cs': ['OmniSharp'] }

" }}}

" OmniSharp: {{{
"let g:OmniSharp_popup_position = 'peek'
"if has('nvim')
""  let g:OmniSharp_popup_options = {
""  \ 'winhl': 'Normal:NormalFloat'
""  \}
"else
""  let g:OmniSharp_popup_options = {
""  \ 'highlight': 'Normal',
""  \ 'padding': [2, 2, 2, 2],
""  \ 'border': [1]
""  \}
"endif
"let g:OmniSharp_popup_mappings = {
""\ 'sigNext': '<C-n>',
""\ 'sigPrev': '<C-p>',
""\ 'pageDown': ['<C-f>', '<PageDown>'],
""\ 'pageUp': ['<C-b>', '<PageUp>']
""\}

"let g:OmniSharp_highlight_groups = {
""\ 'ExcludedCode': 'NonText'
""\}
" }}}

"let g:OmniSharp_highlight_groups = {
""\ 'ClassName': 'Function',
""\ 'Comment': 'Text',
""\ 'FieldName': 'Text',
""\ 'EventName': 'Text',
""\ 'ParameterName': 'Text',
""\ 'NamespaceName': 'Text',
""\}

"-------------------------------------------------------------------------------------------------------------------
"SHELL
"-------------------------------------------------------------------------------------------------------------------
set shell="C:\\WINDOWS\\sysnative\\WindowsPowerShell\\v1.0\\powershell.exe

"-------------------------------------------------------------------------------------------------------------------
" MISCELLANEUS
"-------------------------------------------------------------------------------------------------------------------
lua require('stiwie')
source "C:\Users\Jamiro Ferrara\AppData\Local\nvim\plug-config/coc.vim"


"-------------------------------------------------------------------------------------------------------------------
"  VIM WIKI 
"-------------------------------------------------------------------------------------------------------------------
set nocompatible
filetype plugin on
syntax on
nnoremap <leader><cr> :VimwikiToggleListItem<CR>


"-------------------------------------------------------------------------------------------------------------------
"  COC NVIM 
"-------------------------------------------------------------------------------------------------------------------
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"emmet
let g:user_emmet_install_global = 1
"-------------------------------------------------------------------------------------------------------------------
"FILE TYPE AUTOCOMMANDS
"-------------------------------------------------------------------------------------------------------------------
augroup FileTypeOverrides
    autocmd!
    " Use '//' instead of '/* */' comments
    autocmd FileType php setlocal commentstring=//%s
    autocmd FileType markdown setlocal nospell
    autocmd FileType vim setlocal nospell
    autocmd FileType cs setlocal nospell
    autocmd TermOpen * setlocal nospell
    autocmd BufNewFile,BufRead *.xml set syntax=xml
    autocmd BufNewFile,BufRead *.xaml set syntax=xml
augroup END
