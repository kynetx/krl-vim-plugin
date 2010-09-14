This a vim plugin for krl (Kynex Rule Language) vim support. It includes: 
	syntax highlighting
	indentation support
This is a work-in-progress and will be updated periodically
Save syntax/krl.vim to ~/.vim/syntax/krl.vim
Save indent/krl.vim to ~/.vim/indent/krl.vim

Add:
augroup filedetect
	" Kynetx Rule Language (KRL)
	au BufNewFile,BufRead *.krl     setf krl
augroup END

in your ~/.vim/filetype.vim
