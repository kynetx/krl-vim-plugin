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

syn region krlEmit matchgroup=Emit start=+emit\s\+<<+ end=+>>+ contains=@JS
syn region krlCSS matchgroup=Snip start=+css\s\+<<+ end=+>>+ contains=@CSS 
syn region krlHereDoc matchgroup=Snip start=/<</ end=/>>/ contains=krlString
syn region krlHTMLHereDoc matchgroup=Snip start=/\w\+\s\+=\s\+<</ end=/>>/ contains=@HTML
syn region krlClownHat matchgroup=Emit start=/<|/ end=/|>/ contains=@JS
syn region krlString start=+"+  skip=+\\\\\|\\"+  end=+"\|$+
syn region krlString start=+'+  skip=+\\\\\|\\'+  end=+'\|$+
syn region krlRegexpString start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@perlInterpMatch oneline
syn region krlNewRegexpString start=+re/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@perlInterpMatch oneline
syn region krlPoundRegexpString start=+#[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+#[gi]\{0,2\}\s*$+ end=+#[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@perlInterpMatch oneline
syn region krlJSONPath start=+"\$\.+  skip=+\\\\\|\\'+  end=+"\|$+
syn region krlJSONPath start=+'\$\.+  skip=+\\\\\|\\'+  end=+'\|$+

syn match krlNamespace "\w\+:"he=e-1,me=e-1
syn match krlMethod ":\w\+"hs=s+1,ms=s+1

syn keyword krlSelect select 
syn keyword krlDomain domain
syn keyword krlOptions opacity width sticky message tabColor backgroundColor color delay life divCSS pathToTabImage tabLocation topPos imageWidth imageHeight
syn keyword krlConditional if then fired else neq eq like between not is once within
syn keyword krlLibraries twitter amazon google odata rss
syn keyword krlWith with
syn keyword krlAnd and 
syn keyword krlKeywords rule every global meta ruleset dispatch choose current module tags
syn keyword krlAction log noop send_directive after alert annotate_search_results query annotate_local_search_results before float float_html let_it_snow move_after move_to_top noop notify close_notification percolate popup prepend redirect replace peplace_html replace_inner replace_image_src sidetab set_element_attr watch status_bar 
syn keyword krlOperators unique lc uc union sort split intersection join difference duplicates filter put map extract as has head length tail append pick authorize authorized encode decode search match replace for foreach containedin=ALLBUT,krlString,krlComment,krlLineComment,krlCommentTodo,krlEmit,krlCSS,krlHereDoc
syn keyword krlLabels explicit event raise name ent author description set clear history use require seen forget mark logging using setting pre key when pageview dataset cachable or submit change datasource click web 
syn keyword krlActive active inactive off on
syn keyword krlBooleans true false 
syn keyword krlPostlude fired notfired always callbacks failure success
syn keyword krlReserved names twitterId alias app authz sharing using second web

syn match krlSymbols "==\|=>\||"

syn keyword krlFunction	function
syn match   krlBraces	   "[{}\[\]]"
syn match   krlParens	   "[()]"

hi link krlComment Comment
hi link krlLineComment Comment
hi link krlCommentTodo Todo
hi link krlString String
hi link krlRegexpString Special
hi link krlNewRegexpString Special
hi link krlPoundRegexpString Special
hi link krlReserved Special
hi link krlJSONPath Special

hi link krlNamespace Function

hi link krlFunction Function
hi link krlBraces Normal
hi link krlParens Normal
hi link krlMethod Function


hi link Emit Label
hi link Snip Label
hi link krlConditional Conditional
hi link krlWith Conditional
hi link krlAnd Conditional 
hi link krlKeywords Label
hi link krlSelect Statement
hi link krlAction krlMethod
hi link krlActive Boolean
hi link krlLabels Type
hi link krlLibraries Type
hi link krlOperators Function
hi link krlPostlude Label
hi link krlNamespace Label


hi link krlOptions Special

hi link krlDomain Statement
hi link krlBooleans Boolean

let b:current_syntax = "krl"

if main_syntax == 'krl'
  unlet main_syntax
endif

" vim: ts=8
