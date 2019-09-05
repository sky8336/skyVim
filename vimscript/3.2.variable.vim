"3.3 各种类型变量的赋值语法

" 各种数据类型赋值示例
" 整数
let n1 = 23
let n2 = -23
let n3 = 012
let n4 = 0x12
let n5 = n1 + 1

" 浮点数
let f1 = 0.23
let f2 = 1.02E12

" 字符串
let s1 = "Hello"  " 双引号字符串，支持转义
let s2 = 'Hello'  " 单引号字符串，不支持转义
let s3 = s1 . s2  " 字符串连接

" List
let list1 = [1,2,3,5]
let list2 = [1, 'hello', 34.3, [1, 2]] " 可以存储不同类型的数据

" Dictionary
let dic1 = {'name':'张三', 'age':18, 'sex':'男', 'score':89.2}

echo n1
echo n2
echo n3
echo n4
echo n5
echo f1
echo f2
echo s1
echo s2
echo s3
echo list1
echo list2
echo dic1


"几个需要注意的地方：
"（1）字符串同时支持单引号和双引号，区别在于双引号字符串能识别转义，这一点与PHP类似；
"（2）字符串连接使用专门的点号运算符，这一点也与PHP类似；

