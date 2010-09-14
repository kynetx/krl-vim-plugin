" Vim syntax file
" Language:	Kynetx Rule Language (KRL)
" Maintainer:	Jessie Morris <jam@kynetx.com> Alex Olson <ako@kynetx.com>
" URL:		http://www.fleiner.com/vim/syntax/javascript.vim
" Changes:	(ss) added keywords, reserved words, and other identifiers
"		(ss) repaired several quoting and grouping glitches
"		(ss) fixed regex parsing issue with multiple qualifiers [gi]
"		(ss) additional factoring of keywords, globals, and members
" Last Change:	2006 Jun 19

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'krl'
endif

syntax include @JS $VIMRUNTIME/syntax/javascript.vim
syntax include @perlInterpMatch $VIMRUNTIME/syntax/perl.vim
syntax include @CSS $VIMRUNTIME/syntax/css.vim
syn include @HTML $VIMRUNTIME/syntax/html.vim

syn keyword krlCommentTodo      TODO FIXME XXX TBD contained
syn match   krlLineComment      "\/\/.*" contains=@Spell,krlCommentTodo
syn match   krlCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  krlComment	       start="/\*"  end="\*/" contains=@Spell,krlCommentTodo

syn region krlEmit matchgroup=Emit start=/emit\s\+<</ end=/>>/ contains=@JS
syn region krlCSS matchgroup=Snip start=/css\s\+<</ end=/>>/ contains=@CSS
syn region krlHereDoc matchgroup=Snip start=/\w\+\s\+=\s\+<</ end=/>>/ contains=@HTML
syn region krlString start=+"+  skip=+\\\\\|\\"+  end=+"\|$+
syn region krlRegexpString start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@perlInterpMatch oneline

syn keyword krlSelect select 
syn keyword krlDomain domain
syn keyword krlOptions opacity width sticky message tabColor backgroundColor color delay life divCSS pathToTabImage tabLocation topPos imageWidth imageHeight
syn keyword krlConditional if then fired else always 
syn keyword krlLibraries twitter amazon google odata rss web  
syn keyword krlWith with
syn keyword krlAnd and 
syn keyword krlKeywords rule every global meta ruleset dispatch 
syn keyword krlAction after alert annotate_search_results annotate_local_search_results append before float float_html let_it_snow move_after move_to_top noop notify close_notification percolate popup prepend redirect replace peplace_html replace_inner replace_image_src sidetab set_element_attr watch status_bar
syn keyword krlOperators pick authorize authorized search match replace is not eq neq foreach containedin=ALLBUT,krlString,krlComment,krlLineComment,krlCommentTodo,krlEmit,krlCSS,krlHereDoc
syn keyword krlLabels name author description logging using setting pre key when pageview dataset cachable or submit change datasource click web
syn keyword krlActive active inactive off on
syn keyword krlBooleans true false 

hi link krlComment Comment
hi link krlLineComment Comment
hi link krlCommentTodo Todo
hi link krlString String
hi link krlRegexpString String

hi link Emit Label
hi link Snip Label
hi link krlConditional Conditional
hi link krlWith Conditional
hi link krlAnd Conditional 
hi link krlKeywords Label
hi link krlSelect Statement
hi link krlAction Function
hi link krlActive Boolean
hi link krlLabels Type
hi link krlLibraries Type
hi link krlOperators Function

hi link krlOptions Special

hi link krlDomain Statement
hi link krlBooleans Boolean

let b:current_syntax = "krl"

if main_syntax == 'krl'
  unlet main_syntax
endif

" vim: ts=8
