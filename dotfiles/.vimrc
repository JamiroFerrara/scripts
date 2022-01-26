## Navigation Maps

map gi :vsc Edit.GoToImplementation<CR>
map gr :vsc Edit.FindAllReferences<CR>
map gp :vsc Edit.PeekDefinition<CR>

let mapleader=" "

map <leader>j <S-}>
map <leader>k <S-{>

nnoremap <leader>m :vsc Edit.NextMethod<cr>
nnoremap <leader>M :vsc Edit.PreviousMethod<cr>
nnoremap <leader>o :vsc Edit.ExpandCurrentRegion<cr> | zz <cr>
nnoremap <leader>p :vsc Edit.CollapseToDefinitions<cr>
nnoremap <leader>z :vsc View.NavigateBackward<cr>
nnoremap <leader>x :vsc View.NavigateForward<cr>

" VIEW
nnoremap <leader>E :vsc View.ErrorList<cr>
nnoremap <leader>O :vsc View.Output<cr>
nnoremap <leader>n :vsc Project.AddNewItem<cr>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Quicky escape to normal mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Comment / Uncomment
nnoremap <leader>c :vsc Edit.CommentSelection<cr>
nnoremap <leader>u :vsc Edit.UncommentSelection<cr>
vnoremap <leader>c :vsc Edit.CommentSelection<cr>
vnoremap <leader>u :vsc Edit.UncommentSelection<cr>

"Select Block of Code
nnoremap <leader>b :vsc Edit.ExpandSelectiontoContainingBlock<cr>

" Rename Item
nnoremap R :vsc Refactor.Rename<cr>

" Jump between compilation errors
nnoremap <leader>e :vsc View.NextError<cr>