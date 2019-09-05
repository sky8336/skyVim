"
"VimScript支持6种数据类型，分别是：Number-有符号整数、Float-浮点数、String-字节串（字符串）、Funcref-函数引用、List-有序链表、Dictionary-无序关联数组。下面分别详细解释。
"
"(1) Number
"32位有符号整数，等同于C或PHP语言的int。如果从引用和值来分类，此种类型属于值类型。
"
"(2)Float
"浮点类型，等同于C或PHP语言中的float。值类型。
"
"(3)String
"字符串类型，等同于C或PHP语言中的字符串。值类型。
"
"(4)Funcref
"函数引用，等同于C或PHP语言中的函数类型。引用类型。
"
"(5)List
"有序链表，这个在C语言中没有对应项，因为List中的每个元素的类型可以不同，类似于PHP中的索引数组。引用类型。
"
"(6)Dictionary
"字典类型，实质是哈希表，类似于PHP中的关联数组。引用类型。

"VimScript提供了内置函数type用于识别一个数据的类型，示例：

echo type(1)
echo type('hello')
echo type(function("getline"))
echo type([1,2])
echo type({})
echo type(1.1)

""输出结果为:
"0
"1
"2
"3
"4
"5
