"input `:so ./1.hello-VimScript.vim` in vim normal mode
:echo 'Hello, VimScript!'

"Notes:
"VimScript是用于配置、扩展vim的专用脚本语言。
"具有动态类型、面向对象（不太完整）、异常处理等现代语言特征。
"大体上属于PHP语言派别，但没有PHP干净利索。是编写vim插件的基本语言，
"但不是唯一语言，因为vim也支持通过python,perl等语言编写其插件。
"
"最基本的VimScript知识：
"（1）双引号以及后面的文字属于注释内容
"（2）输出使用:echo关键字
"（3）以行为执行单位
"（4）使用:source命令来执行外部VimScript文件
" (5) 另外VimScript是严格区分大小写的。
