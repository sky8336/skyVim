# vimconfig_bundle
vim config for linux devices driver development 
本次vim配置是独家配置，配置文件已经隐藏

输入./config.sh可以自动完成配置，整个过程非常简单

注意：在配置之前，您要确保你机器已经安装好vim,
	  即您之前已经做过sudo apt-get install vim 这样的操作,如果没有请先安装vim 

1.配置vim+ctags+cscope+taglist

        （1）安装vim ctags cscope
                  sudo apt-get install vim ctags cscope

        （2） vimconfig.tar.bz2  拷贝好Ubuntu家目录下解压；
                  
        （3）进入解压后的目录，执行sudo ./config.sh
        
                  
        至此，环境配置完毕
测试：
        vi a.c
        输入main后，按tab键看是否成功自动补全。
