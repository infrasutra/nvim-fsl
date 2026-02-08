" Vim syntax file for Flux Schema Language (FSL)
" Language: FSL
" Maintainer: Flux CMS Team

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword fslKeyword type enum

" Built-in types
syn keyword fslType String Text Int Float Boolean DateTime Date JSON RichText Image File Slug

" Decorators
syn match fslDecorator "@\w\+"

" Comments
syn match fslComment "//.*$"

" Strings
syn region fslString start='"' end='"' contains=fslEscape
syn match fslEscape "\\." contained

" Numbers
syn match fslNumber "\<\d\+\(\.\d\+\)\?\>"

" Operators
syn match fslOperator "!"
syn match fslOperator "|"
syn match fslOperator ":"

" Field names (identifier before colon)
syn match fslField "^\s*\w\+\ze\s*:" contains=fslKeyword

" Type names (after type/enum keyword)
syn match fslTypeName "\(type\|enum\)\s\+\zs\w\+"

" Required marker
syn match fslRequired "!" contained

" Booleans
syn keyword fslBoolean true false

" Highlighting
hi def link fslKeyword Keyword
hi def link fslType Type
hi def link fslDecorator Function
hi def link fslComment Comment
hi def link fslString String
hi def link fslEscape Special
hi def link fslNumber Number
hi def link fslOperator Operator
hi def link fslField Identifier
hi def link fslTypeName Type
hi def link fslRequired Special
hi def link fslBoolean Boolean

let b:current_syntax = "fsl"
