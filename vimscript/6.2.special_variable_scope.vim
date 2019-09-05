"2.2 特殊变量空间
"除了上面的各种名字空间，vim还提供了几个特殊的名字空间。

"环境变量 如果变量的名字以$开头，那么这个变量被认为是环境变量， 如

" 环境变量
echo $HOME
echo $VIM
echo $VIMRUNTIME

echo "$notexist:before"$notexist
echo $notexist
echo "$notexist:after"$notexist

echo type($HOME)
echo type($notexist)

"环境变量的数据类型都是String，如果没有定义一个环境变量，使用也不会报错，默认值是空字符串。

"option  如果变量名以&开头，那么这个变量是一个vim内部变量。vim提供了很多可以配置的选项，也被称为vim内部变量。
"同一个名称的内部变量往往有很多副本，一个是全局的，还有buffer和window局部的，而且提供了不同的读写命令set和setlocal。
"内部变量共使用了三种数据类型：boolean，Number, String。其实VimScript并不支持boolean，而是用Number模仿而已。

"改变一个option有两种方法：一是使用set命令，如 set number， set tabstop=4； 二是给变量直接赋值，如 let &number=1, let &tabstop=4。两种方法达到的效果是一样的。不过需要注意的是：

"set命令可以使用简写形式的option名字，如set nu，而直接赋值必须使用完整的内部变量名称；
"直接赋值时要在变量名之前添加&，否则会新建一个同名变量，而不是使用vim的内部变量。如 let number=1不会修改vim的number内部变量。


"register 如果变量名以@开头，那么这本变量是暂存区变量，注意register在这里的含义与CPU中的寄存器没有直接关系。

"register其实就是一块内存，用来存放各种临时性的东西，比如拷贝的文本，文件的名称，最近删除的文本等等。共有9种类型的register。分别是：
"（1）无名register "" ， 在vim中register使用引号开头
"（2）以数字为名的register，"0到"9，共10个
"（3）小删除register, “-（连接符）
"（4）以字母为名的register, ”a到"z，共26个
"（5）只读register，共有4个，分别是 ", ，“。，”%，"#
"（6）表达式register，"=
"（7）选择与删除register，共3个，分别是 "*，"+以及"~
"（8）黑洞register, “_（下划线），注意与"-区别
"（9）上次查找模式register, ”/

"这些register中，有一些是vim自身使用的，有些则是共用户使用的。
"在VimScript中，使用@+暂存区名的语法来读取和设置暂存区。如下：

echo @"
let @/ = "hello"  " 写入register
echo type(@/)
echo type(@_)

"通过实验得知，所有的register类型变量的数据类型都是String。
