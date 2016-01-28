" HIGHLIGHT ALL MATH OPERATOR
syn match cMathOperator display "[-+\*/%=]"
syn match cPointerOperator display "->\|\."
syn match cLogicalOperator display "[!<>]=\="
syn match cLogicalOperator display "=="
syn match cBinaryOperator display "\(&\||\|\^\|<<\|>>\)=\="
syn match cBinaryOperator display "\~"
syn match cBinaryOperatorError display "\~="
syn match cLogicalOperator  display "&&\|||"
syn match cLogicalOperatorError display "\(&&\|||\)="
syn match cInterpunction display "[,;]"
hi cMathOperator ctermfg=cyan
hi cPointerOperator ctermfg=cyan
hi cLogicalOperator ctermfg=cyan
hi cBinaryOperator ctermfg=cyan
hi cBinaryOperatorError ctermfg=cyan
hi cLogicalOperator ctermfg=cyan
hi cLogicalOperatorError ctermfg=cyan
hi cInterpunction ctermfg=cyan
