# key map
- LastChange: 2020-07-10
-    Version: V0.0.13

## help
`:Rmap` - generate or update your key_map.txt<br/>
`<space>hk` - open key_map.txt when you want to know some key map<br/>
`\` - Load Previous buffer<br/>
`<space>b1`~`<space>b9` - jump buffer1 ~ buffer9
`<space>bb` - `:b `

## Note
- 禁止使用<c-m> 映射，因为与 enter 联系起来，会导致按enter 调用映射的功能<br/>
  " <C-m> is Enter in quickfix window <br/>

## 快捷键盘开头的type
- `<leader>` - 指定为`,`
- `<space>` - 空格
- `ALT` - 未使用
- `[`
- `]`

## plugin 快捷键说明

查找快捷键的方式：
1. 按一下快捷键开头按键，等待 vim-which-key 插件弹出提示
2. 打开 .vimrc, 搜索'key_mapping' 和'mapping' 查找
3. 打开 ~/.vim/sky8336/plugin_setting.vim, 搜索插件名或key-mappings的地方找快捷键

### leader 即,开头的快捷键
- 按,停顿，等待 vim-which-key 弹出提示

### space 开头的快捷键
- 按“空格”停顿，等待 vim-which-key 弹出提示
- 在.vimrc 中搜索 "space key_mappings"

#### 与vim保存退出等相关原生命令相关的映射，仅仅把空格当成:的作用来映射，后面按键顺序一致，保持一贯的习惯。
目前这些快捷键都以空格开头，后面加两个字母，或加1个字母和空格，如：
- `空格+jw`: 保存，即`:w<CR>`
- `空格+wq`: 保存后退出
原生命令的映射，仅仅改动按:的方式为按空格即可。

**note:**
这里把vim默认支持的命令，成为原生命令。

#### space 开头插件相关
`空格+tm`: 打开terminal<br/>
`空格+td`: 打开termdebug<br/>

`空格+w+v`: vertical res 86<CR><cr/>
`空格+w+v`: res 25<CR><cr/>
`space+mm`: Man manual<cr/>
`space+m2`: Man manual 2<cr/>


	这样设计是为了保持3个按键，使得space开头的快捷键尽可能多。并且空格键不需要移动手指，也方便快捷。


#### cmap command
`cmap ,e <ESC>`<br/>
`cmap ,pi PlugInstall`<br/>
`cmap ,gk :call Generate_kernel_tags_cscope()<CR>`<br/>

### 其他方便的快捷键
	插入模式快速按 js 		切换到normal 模式并保存 
	插入模式快速按 jk 		切换到normal 模式不并保存,因为有时切入normal模式是为了按u恢复

	<enter>	leaderf mru

### F1~F12相关快捷键 

#### 普通模式下：  
小写字母f: 按键f
	
	F1    帮助:GNOME Terminal Manual
	,f1		tagbar开关 

	F2 或,f2   NERDTree开关
	,F2    VimExplorer开关

	F3    打开MRU,在路径列表中，光标在工程名处按shift+*,高亮相应工程，便于选择;
	      :q  退出MRU
	,m    按,m后，将在终端复制的项目名粘贴到底行，按回车后打开MRU，文件路径匹配输入的项目名  
	( Ctrl+F1 ~ Ctrl+F4不可用 )

	F4       
	,F4       

	F5      
	Ctrl+F5 UndotreeToggle  
	,F5   在底行//gj的双斜杠中间输入要查找的关键字，用vimgrep在当前文件父目录下的.c和.h中搜索//中输入的关键字  

	F6    用vimgrep在当前文件父目录下的.c和.h中搜索光标所在的单词    
	Ctrl+F6    用vimgrep在状态行显示的相对路径父目录下.c和.h中递归搜索光标所在的单词  
	,F6    用vimgrep在底行输入的路径文件中搜索光标所在的单词  

	F7

	F8    
	Ctrl+F8 

	F9    在kernel/目录或linux-stable/目录下，生成arm平台的tags和cscope数据库；  
	      否则，通用，生成及tags和cscope数据库  
	Ctrl+F9	  实现递归查找上级目录中的ctags和cscope并自动载入，向上查找包含当前目录在内的5级目录  

	( F10/F11系统占用 )  
	Ctrl+F10   
	Ctrl+F11   

	F12        
	Ctrl+F12   

