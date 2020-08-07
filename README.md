# skyVim - 一键安装超漂亮的vim配置
- LastChange: 2020-08-07
-    Version: V0.1.57

## About skyVim
1. vim config for linux devices driver development and C development，C++, qt, python/shell development<br/>
2. development help document kits

+ 工具就是生产力，打造利器, 提高效率…  
+ 针对vim8.2更新配置...
+ 记得点击右上角star…    

- 适用于linux 内核/驱动开发的vim配置;  
- 适用于c/c++, qt的应用编程的vim配置;  
- 适用于shell/python编程的vim配置;  
- 适用于...

[feature](https://github.com/sky8336/skyVim/blob/master/my_help/skyVim.md)<br/>
some skyVim pictures:[超漂亮 vim 配置：skyVim](https://blog.csdn.net/sky8336/article/details/91351221)

## 1. Install and update

### install
第一次安装时，执行install.sh ,以后若更新本配置，执行update.sh快速更新   

`sudo ./install.sh`<br/>
查看帮助, 可跳过其中一些步骤，如果以前安装过.安装package（tools）可能会慢点<br/>
`sudo ./install.sh 0`<br/>
全自动安装vim，相关工具，配置vim， 配置git使用vim编辑<br/>
`sudo ./install.sh 4`<br/>
跳过安装package和vim,适合第二次以后的安装。<br/>

+ 联网情况, 第一次全安装可能几分钟，与网速有关.
+ 不联网情况比较快.

#### 注意：  
- (a)插件更新    
	- 若vim-plug 管理的插件安装不成功，可执行update.sh脚本或手动安装:
	打开vim，底行模式命令：  
		:PlugStatus		查看插件状态
		:PlugInstall
	- 如果仅仅想添加某个插件，或者恢复到之前的某个插件
	  可以通过gitk来查看修改记录，单独安装配置需要的插件即可。 
- (b)配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。
- (c)测试：
        vi a.c  
        输入main后，按tab键看是否成功自动补全。 

### update
	cd skyVim
	./update.sh

- 一键更新.vimrc及插件和帮助文件
- 最短耗时不到1分钟，一般很快(3~90s)  
- ubuntu 系统自带vim是vim.tiny，迷你版，.vimrc 有一些命令不支持，不过install.sh会自动安装完整版vim    

## 2 vim使用说明
vim使用相关文档，请参考以下文档：<br/>
[Quick Start Guide](https://github.com/sky8336/skyVim/blob/master/my_help/quick_start_guide.md)<br/>
[plugin list](https://github.com/sky8336/skyVim/blob/master/my_help/plugin_list.md)<br/>
[快捷键说明](https://github.com/sky8336/skyVim/blob/master/my_help/key_map.md)<br/>
[plugin instructions](https://github.com/sky8336/skyVim/blob/master/my_help/plugin_instructions.md)<br/>
[trouble_shooting](https://github.com/sky8336/skyVim/blob/master/my_help/trouble_shooting.md)<br/>

## 3 vim Usage: 使用习惯及场景应用 -- 快速使用{{{1   
[workflow tips](https://github.com/sky8336/skyVim/blob/master/my_help/workflow_tips.md)<br/>
[vim command](https://github.com/sky8336/skyVim/blob/master/my_help/vim_command.md)<br/>
[vim](https://github.com/sky8336/skyVim/tree/master/my_help/vim)<br/>

## 4. others
[git](https://github.com/sky8336/skyVim/tree/master/my_help/git)<br/>
[ubuntu](https://github.com/sky8336/skyVim/tree/master/my_help/ubuntu)<br/>
[debug](https://github.com/sky8336/skyVim/tree/master/my_help/debug)<br/>
[program_language](https://github.com/sky8336/skyVim/tree/master/my_help/program_language)<br/>
