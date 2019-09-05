"1.1 函数调用的两种方式

"有两种调用VimScript函数的方式。

"（1）不关心返回值

"call search("Date: ", "W")

"使用关键字call 来显式调用函数。


"（2）关心返回值

"let line = getline(".")
"let repl = substitute(line, '\a', "*", "g")
"call setline(".", repl)

"上例子，getline(".")返回当前光标所在的行文本，substitue()则返回替换后的文本， 这种情况下自动调用函数，无需使用call。


"其实函数调用的call与变量赋值的let类似，看起来好像真的是多余的，C和PHP都没有这种用法，也能工作的很好啊，搞不懂VimScript的开发者是如何想的。
"

"1.2 自定义函数
"VimScript内建了大量的函数供用户使用，同时也支持用户自定义函数。基本语法如下面例子。

function Min(num1, num2)
	if a:num1 < a:num2
		let smaller = a:num1
	else
		let smaller = a:num2
	endif
	return smaller
endfunction

echo Min(23,24)

"看起来与PHP中的函数非常相似。
"注意：
"函数名首字母必须大写。为了避免用户自定义函数与内置函数命名冲突。
"函数参数在函数体内使用时前面加上a:，表示函数参数，否则运行时会报错，并提示num1是没有定义的变量。这就引出了一个很重要的话题：变量的作用域。
"函数名称属于全局命名空间，在所有脚本中可用
