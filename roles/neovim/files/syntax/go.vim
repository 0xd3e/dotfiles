" Syntax file for Go.
"
" All of this is shamelessly copied from the sytax file that was provided by
" the Go team until Go 1.3 and the syntax file that vim-go provides. Options
" that are defined by vim-go were dropped.
"
" https://github.com/golang/go/blob/release-branch.go1.3/misc/vim/syntax/go.vim
" https://github.com/fatih/vim-go/blob/master/syntax/go.vim

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syntax case match

syntax keyword            goPackage        package
syntax keyword            goImport         import     contained
syntax keyword            goVar            var        contained
syntax keyword            goConst          const      contained

highlight default link    goPackage        Statement
highlight default link    goImport         Statement
highlight default link    goVar            Keyword
highlight default link    goConst          Keyword
highlight default link    goDeclaration    Keyword

"
" Keywords within functions
"
syntax keyword             goStatement      defer go goto return break continue fallthrough
syntax keyword             goConditional    if else switch select
syntax keyword             goLabel          case default
syntax keyword             goRepeat         for range

highlight default link     goStatement      Statement
highlight default link     goConditional    Conditional
highlight default link     goLabel          Label
highlight default link     goRepeat         Repeat

"
" Predefined types
"
syntax keyword            goType            chan map bool string error
syntax keyword            goSignedInts      int int8 int16 int32 int64 rune
syntax keyword            goUnsignedInts    byte uint uint8 uint16 uint32 uint64 uintptr
syntax keyword            goFloats          float32 float64
syntax keyword            goComplexes       complex64 complex128

highlight default link    goType            Type
highlight default link    goSignedInts      Type
highlight default link    goUnsignedInts    Type
highlight default link    goFloats          Type
highlight default link    goComplexes       Type

"
" Predefined functions and values
"
syntax keyword            goBuiltins                 append cap close complex copy delete imag len
syntax keyword            goBuiltins                 make new panic print println real recover
syntax keyword            goBoolean                  true false
syntax keyword            goPredefinedIdentifiers    nil iota

highlight default link    goBuiltins                 Identifier
highlight default link    goBoolean                  Boolean
highlight default link    goPredefinedIdentifiers    goBoolean

"
" Comments; their contents
"
syntax keyword            goTodo            TODO FIXME XXX BUG NOTE contained
syntax cluster            goCommentGroup    contains=goTodo
syntax region             goComment         start="//" end="$" contains=@goCommentGroup,@Spell
syntax region             goComment         start="/\*" end="\*/" contains=@goCommentGroup,@Spell

highlight default link    goComment         Comment
highlight default link    goTodo            Todo

"
" Go escapes
"
syntax match               goEscapeOctal      display contained "\\[0-7]\{3}"
syntax match               goEscapeC          display contained +\\[abfnrtv\\'"]+
syntax match               goEscapeX          display contained "\\x\x\{2}"
syntax match               goEscapeU          display contained "\\u\x\{4}"
syntax match               goEscapeBigU       display contained "\\U\x\{8}"
syntax match               goEscapeError      display contained +\\[^0-7xuUabfnrtv\\'"]+

highlight default link     goEscapeOctal      goSpecialString
highlight default link     goEscapeC          goSpecialString
highlight default link     goEscapeX          goSpecialString
highlight default link     goEscapeU          goSpecialString
highlight default link     goEscapeBigU       goSpecialString
highlight default link     goSpecialString    Special
highlight default link     goEscapeError      Error

"
" Strings and their contents
"
syntax cluster            goStringGroup    contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syntax region             goString         start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup
syntax region             goRawString      start=+`+ end=+`+

highlight default link    goString         String
highlight default link    goRawString      String

"
" Characters; their contents
"
syntax cluster            goCharacterGroup    contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU
syntax region             goCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

highlight default link    goCharacter         Character

"
" Regions
"
syntax region    goBlock         start="{" end="}" transparent
syntax region    goParen         start='(' end=')' transparent
syntax region    goImport        start='import (' end=')' transparent contains=goImport,goString,goComment
syntax region    goVar           start='var ('   end='^\s*)$' transparent
	\ contains=ALLBUT,goParen,goBlock,goFunction,goTypeName,goReceiverType,goReceiverVar,goParamName,goParamType,goSimpleParams,goPointerOperator

syntax region    goConst         start='const (' end='^\s*)$' transparent
	\ contains=ALLBUT,goParen,goBlock,goFunction,goTypeName,goReceiverType,goReceiverVar,goParamName,goParamType,goSimpleParams,goPointerOperator

syntax match     goSingleDecl    /\%(import\|var\|const\) [^(]\@=/ contains=goImport,goVar,goConst

"
" Integers
"
syntax match              goDecimalInt          "\<-\=\(0\|[1-9]_\?\(\d\|\d\+_\?\d\+\)*\)\%([Ee][-+]\=\d\+\)\=\>"
syntax match              goDecimalError        "\<-\=\(_\(\d\+_*\)\+\|\([1-9]\d*_*\)\+__\(\d\+_*\)\+\|\([1-9]\d*_*\)\+_\+\)\%([Ee][-+]\=\d\+\)\=\>"
syntax match              goHexadecimalInt      "\<-\=0[xX]_\?\(\x\+_\?\)\+\>"
syntax match              goHexadecimalError    "\<-\=0[xX]_\?\(\x\+_\?\)*\(\([^ \t0-9A-Fa-f_]\|__\)\S*\|_\)\>"
syntax match              goOctalInt            "\<-\=0[oO]\?_\?\(\o\+_\?\)\+\>"
syntax match              goOctalError          "\<-\=0[0-7oO_]*\(\([^ \t0-7oOxX_/)\]\}\:]\|[oO]\{2,\}\|__\)\S*\|_\|[oOxX]\)\>"
syntax match              goBinaryInt           "\<-\=0[bB]_\?\([01]\+_\?\)\+\>"
syntax match              goBinaryError         "\<-\=0[bB]_\?[01_]*\([^ \t01_]\S*\|__\S*\|_\)\>"

highlight default link    goDecimalInt          Integer
highlight default link    goDecimalError        Error
highlight default link    goHexadecimalInt      Integer
highlight default link    goHexadecimalError    Error
highlight default link    goOctalInt            Integer
highlight default link    goOctalError          Error
highlight default link    goBinaryInt           Integer
highlight default link    goBinaryError         Error
highlight default link    Integer               Number

"
" Floating point
"
syntax match              goFloat    "\<-\=\d\+\.\d*\%([Ee][-+]\=\d\+\)\=\>"
syntax match              goFloat    "\<-\=\.\d\+\%([Ee][-+]\=\d\+\)\=\>"

highlight default link    goFloat    Float

"
" Imaginary literals
"
syntax match              goImaginary         "\<-\=\d\+i\>"
syntax match              goImaginary         "\<-\=\d\+[Ee][-+]\=\d\+i\>"
syntax match              goImaginaryFloat    "\<-\=\d\+\.\d*\%([Ee][-+]\=\d\+\)\=i\>"
syntax match              goImaginaryFloat    "\<-\=\.\d\+\%([Ee][-+]\=\d\+\)\=i\>"

highlight default link    goImaginary         Number
highlight default link    goImaginaryFloat    Float

"
" Operators
"

" match single-char operators:          - + % < > ! & | ^ * =
" and corresponding two-char operators: -= += %= <= >= != &= |= ^= *= ==
syntax match              goOperator    /[-+%<>!&|^*=]=\?/
" match / and /=
syntax match              goOperator    /\/\%(=\|\ze[^/*]\)/
" match two-char operators:               << >> &^
" and corresponding three-char operators: <<= >>= &^=
syntax match              goOperator    /\%(<<\|>>\|&^\)=\?/
" match remaining two-char operators: := && || <- ++ --
syntax match              goOperator    /:=\|||\|<-\|++\|--/
" match ...
syntax match              goVarArgs     /\.\.\./

highlight default link    goPointerOperator   goOperator
highlight default link    goVarArgs           goOperator
highlight default link    goOperator          Operator

" Extra types commonly seen
syntax match              goExtraType    /\<bytes\.\%(Buffer\)\>/
syntax match              goExtraType    /\<context\.\%(Context\)\>/
syntax match              goExtraType    /\<io\.\%(Reader\|ReadSeeker\|ReadWriter\|ReadCloser\|ReadWriteCloser\|Writer\|WriteCloser\|Seeker\)\>/
syntax match              goExtraType    /\<reflect\.\%(Kind\|Type\|Value\)\>/
syntax match              goExtraType    /\<unsafe\.Pointer\>/

highlight default link    goExtraType    Type

"
" Functions
"
syntax match              goDeclaration        /\<func\>/ nextgroup=goReceiver,goFunction,goSimpleParams skipwhite skipnl
syntax match              goReceiverVar        /\w\+\ze\s\+\%(\w\|\*\)/ nextgroup=goPointerOperator,goReceiverType skipwhite skipnl contained
syntax match              goPointerOperator    /\*/ nextgroup=goReceiverType contained skipwhite skipnl
syntax match              goFunction           /\w\+/ nextgroup=goSimpleParams contained skipwhite skipnl
syntax match              goReceiverType       /\w\+/ contained
syntax match              goSimpleParams       /(\%(\w\|\_s\|[*\.\[\],\{\}<>-]\)*)/ contained contains=goParamName,goType nextgroup=goFunctionReturn skipwhite skipnl
syntax match              goFunctionReturn     /(\%(\w\|\_s\|[*\.\[\],\{\}<>-]\)*)/ contained contains=goParamName,goType skipwhite skipnl
syntax match              goParamName          /\w\+\%(\s*,\s*\w\+\)*\ze\s\+\%(\w\|\.\|\*\|\[\)/ contained nextgroup=goParamType skipwhite skipnl
syntax match              goReceiver           /(\s*\w\+\%(\s\+\*\?\s*\w\+\)\?\s*)\ze\s*\w/ contained nextgroup=goFunction contains=goReceiverVar skipwhite skipnl
syntax match              goParamType          /\%([^,)]\|\_s\)\+,\?/ contained nextgroup=goParamName skipwhite skipnl
	\ contains=goVarArgs,goType,goSignedInts,goUnsignedInts,goFloats,goComplexes,goDeclType,goBlock

highlight default link    goReceiverVar        goParamName
highlight default link    goParamName          Identifier
highlight default link    goFunction           Function

"
" Function calls
"
syntax match              goFunctionCall    /\w\+\ze(/ contains=goBuiltins,goDeclaration

highlight default link    goFunctionCall    Type

"
" Structs & Interfaces
"
syntax match              goTypeConstructor    /\<\w\+{\@=/
syntax match              goTypeDecl           /\<type\>/ nextgroup=goTypeName skipwhite skipnl
syntax match              goTypeName           /\w\+/ contained nextgroup=goDeclType skipwhite skipnl
syntax match              goDeclType           /\<\%(interface\|struct\)\>/ skipwhite skipnl

highlight default link    goReceiverType       Type
highlight default link    goTypeConstructor    Type
highlight default link    goTypeName           Type
highlight default link    goTypeDecl           Keyword
highlight default link    goDeclType           Keyword

"
" Variable Assignments
"
syntax match              goVarAssign    /\v[_.[:alnum:]]+(,\s*[_.[:alnum:]]+)*\ze(\s*([-^+|^\/%&]|\*|\<\<|\>\>|\&\^)?\=[^=])/

highlight default link    goVarAssign    Special

"
" Variable Declarations
"
syntax match              goVarDefs    /\v\w+(,\s*\w+)*\ze(\s*:\=)/

highlight default link    goVarDefs    Special

" Search backwards for a global declaration to start processing the syntax.
syntax sync match    goSync    grouphere NONE /^\(const\|var\|type\|func\)\>/

let b:current_syntax = "go"
