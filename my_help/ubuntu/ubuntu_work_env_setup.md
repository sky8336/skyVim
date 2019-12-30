# ubuntu work environment setup
- LastChange: 2019-12-30
-    Version: V0.0.11

可替代windows 环境的工具

## 1.software
- email
- Dingding
- wps
  https://linux.wps.cn/#
- pdf
	- sudo apt install zathura
	- sudo apt-get install okular #带标注功能
	- [福昕阅读器linux版](https://www.foxitsoftware.cn/downloads/)
	  - 下载福昕阅读器，选择平台Linux(64-bit), 下载
- youdao

- LibreOffice Draw vs. 微软Office Visio
  - LibreOffice 5.0版开始，可以兼容Visio 2000-2013
  - LibreOffice：微软Office的免费、优质替代者
  - LibreOffice内建（Writer (文档处理), Calc (电子表格), Impress (幻灯片), Base (数据库)和Math (编辑公式) 和Draw (矢量图）
  - 文件兼容性: LibreOffice不仅可以较为完备地兼容最常见的DOCX、PPTX和XLSX格式文件
  - LibreOffice支持Win/Mac/Linux等，只是移动平台仅有面向Android的LibreOffice Viewer
- Dia vs visio
- firefox
  - vimium
  - Dark Background and Light Text

## 2. ubuntu18.04 issue
- 桌面卡死 <br/>
  pkill X; start X
- 内存泄漏 <br/>
  free -h

## 3. tools
### 截屏
- flameshot &	(推荐)
- gnome-screenshot
  - gnome-screenshot  -h	Show help options
  - gnome-screenshot  -a	Grab an area of the screen instead of the entire screen
- printScreen
  - 全屏截图是printScreen
  - 活动窗口截图是Alt+printScreen
  - 自己选择区域截图是shift+printScreen，然后选择相应区域。
### 编辑照片
- Shotwell
- pinta 图像编辑器
  - sudo apt-get install pinta

### 词典
- sudo apt install goldendict
  - [goldendict setup](https://www.cnblogs.com/creasing/p/11333728.html)

### 思维导图
- [xmind](https://www.xmind.net/download/xmind8/)

### 仅windows上有的工具
virtualbox 装win10

### 播放器
- vlc

### editors
#### vim8.1
#### Visual Studio Code
- ubuntu software -> all -> Editor's Picks -> Visual Studio Code
- ubuntu software -> search "Visual Studio Code"

## command
- 查看ubuntu 版本信息:`sudo lsb_release -a`
- backup required package: `sudo apt install duplicity python-gi`
- *.7z: `sudo apt-get install p7zip`
