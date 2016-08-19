
" my_vim_highlight_config
" zhang bei add 160526
"========================================================
" Highlight All Function
"========================================================
syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
" hi cFunction gui=NONE guifg=#B5A1FF
hi cFunction ctermfg=DarkGreen
"========================================================
" Highlight All Math Operator
"========================================================
" C math operators
syn match cMathOperator display "[-(){}+\%=<>]"
syn match cMathOperator display "\["
syn match cMathOperator display "]"
hi cMathOperator ctermfg=LightBlue
" C pointer operators
syn match cPointerOperator display "*\|->\|\."
hi cPointerOperator ctermfg=darkYellow
" C logical operators - boolean results
syn match cLogicalOperator display "[!<>]=\="
syn match cLogicalOperator display "=="
hi cLogicalOperator ctermfg=darkYellow
" C bit operators
syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\=\|?\|:"
syn match cBinaryOperator display "\~"
hi cBinaryOperator ctermfg=darkYellow
syn match cBinaryOperatorError display "\~="
hi cBinaryOperatorError ctermfg=LightRed
" More C logical operators - highlight in preference to binary
syn match cLogicalOperator display "&&\|||"
hi cLogicalOperator ctermfg=darkYellow
syn match cLogicalOperatorError display "\(&&\|||\)="
hi cLogicalOperatorError ctermfg=LightRed
