# trouble shooting
- Maintainer: sky8336
-    Created: 2019-11-07
- LastChange: 2019-11-08
-    Version: V0.0.03

## vim plugin issue
1. 打开vim后，按o插入一行时，报错。
- 报错信息:<br/>
```
Error detected while processing /home/eric/.vim/plugged/ultisnips/autoload/UltiSnips.vim:                                          
line    7:
E319: Sorry, the command is not available in this version: py3 import vim
```

- 原因分析：<br/>
查看vim 支持的特性，不支持python3; 在新的ultisnips中，需要vim支持python3
```
$ vi --version  | grep python3
+cmdline_info      +libcall           -python3           +visualextra
```

- 解决方式：<br/>
方式一：通过源码编译支持python3特性的vim
1. cd skyVim/
2. 执行编译脚本<br/>
如果之前没有clone 源码到~/vim目录下，执行：
sudo ./build_install_vim.sh 6
如果之前clone 源码到~/vim下，也可以执行:
`sudo ./build_install_vim.sh 7`

3. `sudo ./update.sh`<br/>

为了~/.bashrc_my中alias vi 替换成:<br/>
`alias vi='/usr/local/vim/bin/vim'`
因为编译的vim 默认放在这个位置, 这样用vi就可以使用编译的vim
4. `source  ~/.bashrc`
5. 打开vim测试报错消失
查看vim 已支持python3新特性
```
$ /usr/local/vim/bin/vim --version | grep python3
+cmdline_info      +libcall           +python3/dyn       +visualextra
```
方式二：
	使用.vimcfg_offline/.vim/plugged/ultisnips/中的旧的插件，替换~/.vim/plugged/ultisnips插件
	commit 号为`d5792cc`时，这一版不需要python3支持

## other issue
因为执行脚本用了sudo, 所以git 的一些操作会需要sudo 权限
```
skyVim[master]$ git commit --amend
fatal: could not open '.git/COMMIT_EDITMSG': Permission denied
```
6.  debug mode
quit debug mode:
```
<finish
```
`help debug`
