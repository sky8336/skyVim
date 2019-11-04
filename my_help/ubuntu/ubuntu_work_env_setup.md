# ubuntu work environment setup

## 1.software
- email
- Dingding
- wps
  https://linux.wps.cn/#
- pdf
	sudo apt install zathura
- youdao
- 截图
	- 全屏截图是printScreen
	- 活动窗口截图是Alt+printScreen
	- 自己选择区域截图是shift+printScreen，然后选择相应区域。

- LibreOffice Draw vs. 微软Office Visio
  - LibreOffice 5.0版开始，可以兼容Visio 2000-2013
  - LibreOffice：微软Office的免费、优质替代者
  - LibreOffice内建（Writer (文档处理), Calc (电子表格), Impress (幻灯片), Base (数据库)和Math (编辑公式) 和Draw (矢量图）
  - 文件兼容性: LibreOffice不仅可以较为完备地兼容最常见的DOCX、PPTX和XLSX格式文件
  - LibreOffice支持Win/Mac/Linux等，只是移动平台仅有面向Android的LibreOffice Viewer
- firefox
  - vimium
  - Dark Background and Light Text

## 2. ubuntu18.04 issue
- 桌面卡死 <br/>
  pkill X; start X
- 内存泄漏 <br/>
  free -h

## command
- 查看ubuntu 版本信息:`sudo lsb_release -a`
- backup required package: `sudo apt install duplicity python-gi`
- *.7z: `sudo apt-get install p7zip`
