# buglist
## bug
1. 目前的tagbar 自动打开方式，会导致 vi -O 不能打开两个不同的文件;
	会导致vi a.c +255 不能定位到指定行.

2. sudo ./update.sh 会影响vimcfg_bundle中的git commit -s, 因为sudo 执行了git
pull

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

## skyVim feature
1. 多窗口跳转，自动放大活动窗口
2. 自动高亮光标所在变量
3. 保存时，自动去行为空格
4. ctags 和cscope代码跟踪
