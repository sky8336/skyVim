"2 循环语句
"VimScript支持while和for in两大类循环，不支持do while。条件表达式也不需要括号包裹。
"2.1 while

let i=10
let sum = 0

while i>0
	let sum +=  i
	let i -= 1
endwhile

echo sum

"注意，VimScript不支持一元运算符++和--。
