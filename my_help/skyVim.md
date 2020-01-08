# skyVim
- Maintainer: sky8336
-    Created: 2020-01-08
- LastChange: 2020-01-08
-    Version: V0.0.02

## skyVim feature
### 无需插件实现
- 多窗口跳转，自动放大活动窗口
- 自动高亮光标所在变量
- 多窗口，只有当前窗口所在行有下划线，非活动窗口无下划线且行号灰色
- insert模式，绝对行号，当前行行号蓝色粗体，其余灰色
  normal模式，相对行号, 当前行行号黄色粗体，其余灰色
- normal/insert 模式下：ctrl+h/j/k/l 在多窗口间跳转
- 插入模式:  jk 快速推出到normal模式并保存
- 80列处红色边界，提醒代码长度
- 自动添加文件头, 支持shell, python, c/cpp/cc/h 文件
  - 添加的头的Filename, LastChange, Version 可以用快捷键更新

### 借助插件实现的feature
- ESC 也退出insert 模式，并保存
- 保存时，自动去行为空格
- 浏览代码时，红色高亮空格和tab键混合的缩进
- 代码跟踪: ctags 和cscope
- 代码补全:
- 代码格式化
- Tagbar
- NerdTree

## todo
1. 按u后，回退到上一个命令，自动保存?
2. 异步语法检查和异步make: 
  - neomake
3. cscope 自动更新？ 或gtag替换？
4. 异步补全框架: 
  - deoplete.nvim
  - YCM
  - coc
  - ncm2
  - asyncomplete
  - neocomplcache
5. vim中快速搜索
6. fuzzy finder
  - leaderf
  - coc
7. popup

## buglist
1. 目前的tagbar 自动打开方式，会导致 vi -O 不能打开两个不同的文件;
	会导致vi a.c +255 不能定位到指定行.

2. sudo ./update.sh 会影响vimcfg_bundle中的git commit -s, 因为sudo 执行了git
pull
3. 经常按某些按键进入debug mode, 即在底行出现以`<` 开始的输入行
  - 需要输入`<finish` 推出

