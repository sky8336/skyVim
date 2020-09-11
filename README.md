# skyVim - 一键安装超漂亮的vim配置
- Maintainer: sky8336, shjinyuan
-    Created: 2016-01-28
- LastChange: 2020-08-11
-    Version: V0.1.63

## About skyVim
1. vim config for linux devices driver development and C，C++, qt, python/shell development<br/>
2. development help document kits

+ 工具就是生产力，打造利器, 提高效率…  
+ 针对vim8.2更新配置...
+ 记得点击右上角star…    

- 适用于linux 内核/驱动开发的vim配置;  
- 适用于c/c++, qt的应用编程的vim配置;  
- 适用于shell/python编程的vim配置;  
- 适用于...
- my_help 目录存储了一些常用linux命令，git命令等使用笔记

skyVim 使用部分 效果图片:[超漂亮 vim 配置：skyVim](https://blog.csdn.net/sky8336/article/details/91351221)

## 1. Install and update

### 1.1 install
- 第一次安装时，执行install.sh, 以后若更新本配置，执行update.sh快速更新   
- 如果在ubuntu server 中，只需要其中1个账户执行`install.sh`脚本的方式安装，其余用
户只需要以执行`update.sh`脚本的方式，就可以迅速配置完成。
- 联网情况, 第一次全安装可能几分钟，与网速有关.
- 不联网情况比较快, 但可能比联网安装的配置老，推荐联网安装。

`sudo ./install.sh`<br/>
查看帮助, 可跳过其中一些步骤，如果以前安装过.安装package（tools）可能会慢点<br/>
`sudo ./install.sh 0`<br/>
全自动安装vim，相关工具，配置vim， 配置git使用vim编辑<br/>
`sudo ./install.sh 4`<br/>
跳过安装package和vim,适合第二次以后的安装。<br/>

#### 1.1.1 注意：  
1. 插件更新    
	- 若vim-plug 管理的插件安装不成功，可执行`update.sh`脚本(推荐)或手动安装:
	(手动安装插件)打开vim，底行模式命令：  
		`:PlugStatus`: 查看插件状态
		`:PlugInstall`: 安装插件
	- 如果仅仅想添加某个插件，或者恢复到之前的某个插件
	  可以通过gitk来查看修改记录，单独安装配置需要的插件即可。 
2. 本配置中，已将vim映射为来vi，用`vi`打开安装的新vim(从源码编译的稳定版本)。
3. 测试：
	- `vi a.c`
    - 输入"main"后，按tab键看是否成功自动补全。 

### 1.2 update
```bash
cd skyVim
./update.sh
```

- 一键更新.vimrc及插件和帮助文件
- 最短耗时不到1分钟，一般很快(3~90s)  
- ubuntu 系统自带vim是vim.tiny，迷你版，.vimrc 有一些命令不支持，不过install.sh会自动安装完整版vim    

## 2. 文档
[skyVim快速入门指南](https://github.com/sky8336/skyVim/blob/master/my_help/skyVim_quick_start_guide.md)<br/>

## 3. 编译和安装最新的vim
如果您要自己编译和安装最新的vim，我们也提供了编译安装脚本: `build_install_vim.sh`

## 4 trouble_shooting
[trouble_shooting](https://github.com/sky8336/skyVim/blob/master/my_help/trouble_shooting.md)<br/>


