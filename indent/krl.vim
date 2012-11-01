" Vim indent file
" Language:	Kynetx Rule Language (KRL)
" Maintainer:	AKO & JAM
" Last Change:	2012 November 1

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   "finish
endif
" let b:did_indent = 1

" C indenting is not too bad.
" I've decided to no longer do cindenting. JAM 11/01/2012
" setlocal cindentmman

setlocal indentexpr=GetKRLIndent(v:lnum)

if exists("*GetKRLIndent")
	"finish
endif


function! s:GetPrevKRLNonCommentLineNum( line_num )
	let SKIP_LINES = '^\s*\(\((\*\)\|\(\*\ \)\|\(\*)\)\)'

	let nline = a:line_num
	while nline > 0
		let nline = prevnonblank(nline-1)
		if getline(nline) !~? SKIP_LINES
			break
		endif
	endwhile

	return nline
endfunction

function! GetKRLIndent( line_num )
	" Line 0 always starts at column 0
	if a:line_num == 1
		return 0
	endif
	
	let this_codeline = getline( a:line_num )

	" If in the middle of a three-part comment (i.e. \* */)
	if this_codeline =~ '^\s*\*'
		return indent( a:line_num )
	endif

	let prev_codeline_num = s:GetPrevKRLNonCommentLineNum( a:line_num )
	let prev_codeline = getline( prev_codeline_num )
	let indnt = indent ( prev_codeline_num )


	" Rules, meta, and global blocks all have exactly one indent
	if this_codeline =~ '^\s*\<\(meta\|global\|rule\|dispatch\)\>'
		return &shiftwidth
	endif

	if this_codeline =~ '^\s*\<\(name\|description\|author\|logging\|use\|provides\)\>'
		if prev_codeline =~ '^\s*\<\(meta\|global\|rule\|dispatch\)\>'
			return indnt + &shiftwidth
		else
			return indnt
		endif
	endif


	
	" If this line ends in } or >>, decrease the indent
	" We do the close check first to make sure that even if
	" the previous line was { or << to still unindent.
	if this_codeline =~ '^\s*\(}\|>>\);\?'
		if prev_codeline =~ '\s*\({\|<<\)\s*$'
			return indnt
		else
			return indnt - &shiftwidth
		endif
	endif

	" If the previous line ends in { or << increase the indent
	if prev_codeline =~ '\s*\({\|<<\)\s*$'
		return indnt + &shiftwidth
	endif

	" These two rules handle the indentation of with/and.
	" The first handles the case where with/and is on this line,
	" and the second handles the case where it was on the previous line.
	" Since the previous line unindent case comes after the return,
	" this should work correctly.
	if this_codeline =~ '^\s*\<with\>'
		return indnt + &shiftwidth
	endif

	if prev_codeline =~ '^\s*\<configure\>'
		if this_codeline =~ '^\s*\<and\>'
			return indnt + &shiftwidth
		endif
	endif

	if prev_codeline =~ '^\s*\<with\|and\>'
		return indnt - &shiftwidth
	end

	"If all else fails, just return the previous line's indentation
	return indnt
endfunction
