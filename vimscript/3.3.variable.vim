"3.4 自动类型转换与非自动类型转换
"在 VimScript中，Number和String之间是自动转换的，其他的转换都不是自动的。

" 自动类型转换
let v1 = 'hello' + 23
let v2 = 'hello' . 23
let v3 = '23fs' + 2
let v4 = 'h23f' + 2
let v5 = "3.4" + 23.3  " 3.4会被自动转换为Number而不是Float, 要想转为Float需要str2float("3.4")
let v6 = 23.3 + 4

echo v1
echo v2
echo v3
echo v4
echo v5
echo v6


"可以看出Number和String是根据语法需要自动转换的，但是Float和String不能自动转换，也就是如下行不通
"let s = 'hello'. 2.3
"另外，Number和Float参与一起运算时，Number先自动转换为Float再参与运算，这与C相同。

