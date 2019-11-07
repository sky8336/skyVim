# linux command
- LastChange: 2019-11-07
-    Version: V0.0.26

## tools
### 截屏
gnome-screenshot  -h	Show help options
gnome-screenshot  -a	Grab an area of the screen instead of the entire screen

flameshot &

### find
sudo find -name "* *" -type f | sudo rename 's/ /_/g'

使用touch命令递归修改文件时间戳:
find ./ * -exec touch {} \;

搜索文件，执行删除命令
find private/ -name "*~"| xargs rm
find . -name "*.c" | xargs chmod a-x

I usually don't let grep do the recursion itself. There are usually a few
directories you want to skip (.git, .svn...)
You can do clever aliases with stances like that one:
find . \( -name .svn -o -name .git \) -prune -o -type f -exec grep -Hn pattern {} \;

### grep
grep -niR "xxx" files
grep -nsR "xxx" files
use the -s or --no-messages flag to suppress errors.

Errors like that are usually sent to the "standard error" stream, which you can
pipe to a file or just make disappear on most commands:
grep -nsR "xxx" files 2>/dev/null

grep -nR --color=always "xxx" . | less -rN
grep -nR --color=always "xxx" . | more
ls --color=always | more

### du
查看linux/目录大小
du -sh linux/

远程拷贝文件:
scp [参数] 原路径 目标路径
	-r: 递归复制整个目录

sshpass -p "password" scp -r user@example.com:/some/remote/path /some/local/path

管理进程:
top
htop


------------------------------------------------------------
how to output text to both screen and file inside a shell script?
command | tee -a "$log_file"
tee saves input to a file (use -a to append rather than overwrite), and copies
the input to standard output as well.

------------------------------------------------------------
display picture:
display a.jpg
eog a.jpg

------------------------------------------------------------
readelf

nm
nm trusty.ko | grep asan

二进制转换,以ascii码查看:
od -t c fileName 
od -c file

------------------------------------------------------------
add new user:
adduser username
usermod -G root -a username //?
sudo vi /etc/sudoers
在 %root ALL=(ALL:ALL) ALL 下面添加%username ALL=(ALL:ALL) ALL

-------------------------------------------
How to safely change username and hostname?
1. To change the hostname
You need to edit the computer name in two files as root user:
/etc/hostname 
and
/etc/hosts


2. To change username
(1) At the start screen press Ctrl+Alt+F1.
(2) Log in using your username and password.
(3) Set a password for the "root" account.
	sudo passwd root
(4) Log out.
	exit

(5) Log in using the "root" account and the password you have previously set.
(6) Change the username and the home folder to the new name that you want.
	usermod -l <newname> -d /home/<newname> -m <oldname>
	( usermod -l newUsername oldUsername
	To change home-folder, use
	usermod -d /home/newHomeDir -m newUsername)
(7) Change the group name to the new name that you want.
	groupmod -n <newgroup> <oldgroup>
(8) Lock the "root" account.
	passwd -l root
(9) If you were using ecryptfs (encrypted home directory). Mount your encrypted
	directory using ecryptfs-recover-private and edit
	<mountpoint>/.ecryptfs/Private.mnt to reflect your new home directory.
(10) Log out.
	exit
(11) Press Ctrl+Alt+F7.
And now you can log in using your new username.

------------------------------------------------------------
yes - output a string repeatedly until killed
man yes

------------------------------------------------------------
从命令行打开pdf文件和html文件 {{{
	打开当前目录下的hdfs_design.pdf文件：
		evince hdfs_design.pdf
	打开google网站：
		firefox http://www.google.com
}}}

## linux下解压命令大全 {{{

Extracting or Uncompressing tar.xz Files 
xz -d xxx.tar.xz
tar -xvf xxx.tar

.tar 
解包：tar xvf FileName.tar
打包：tar cvf FileName.tar DirName
（注：tar是打包，不是压缩！）
———————————————
.gz
解压1：gunzip FileName.gz
解压2：gzip -d FileName.gz
压缩：gzip FileName

.tar.gz 和 .tgz
解压：tar zxvf FileName.tar.gz
压缩：tar zcvf FileName.tar.gz DirName
———————————————
.bz2
解压1：bzip2 -d FileName.bz2
解压2：bunzip2 FileName.bz2
压缩： bzip2 -z FileName

.tar.bz2
解压：tar jxvf FileName.tar.bz2
压缩：tar jcvf FileName.tar.bz2 DirName
———————————————
.bz
解压1：bzip2 -d FileName.bz
解压2：bunzip2 FileName.bz
压缩：未知

.tar.bz
解压：tar jxvf FileName.tar.bz
压缩：未知
———————————————
.Z
解压：uncompress FileName.Z
压缩：compress FileName
.tar.Z

解压：tar Zxvf FileName.tar.Z
压缩：tar Zcvf FileName.tar.Z DirName
———————————————
.zip
解压：unzip FileName.zip
压缩：zip FileName.zip DirName
———————————————
.rar
解压：rar x FileName.rar
压缩：rar a FileName.rar DirName
———————————————
.lha
解压：lha -e FileName.lha
压缩：lha -a FileName.lha FileName
———————————————
.rpm
解包：rpm2cpio FileName.rpm | cpio -div
———————————————
.deb
解包：ar p FileName.deb data.tar.gz | tar zxf -
———————————————
.tar .tgz .tar.gz .tar.Z .tar.bz .tar.bz2 .zip .cpio .rpm .deb .slp .arj .rar
.ace .lha .lzh .lzx .lzs .arc .sda .sfx .lnx .zoo .cab .kar .cpt .pit .sit .sea
解压：sEx x FileName.*
压缩：sEx a FileName.* FileName

sEx只是调用相关程序，本身并无压缩、解压功能，请注意！

gzip 命令 
减少文件大小有两个明显的好处，一是可以减少存储空间，二是通过网络传输文件时，可以减少传输的时间。gzip
是在 Linux 系统中经常使用的一个对文件进行压缩和解压缩的命令，既方便又好用。

语法：gzip [选项] 压缩（解压缩）的文件名该命令的各选项含义如下：

-c 将输出写到标准输出上，并保留原有文件。-d 将压缩文件解压。-l
对每个压缩文件，显示下列字段：
压缩文件的大小；未压缩文件的大小；压缩比；未压缩文件的名字-r
递归式地查找指定目录并压缩其中的所有文件或者是解压缩。-t
测试，检查压缩文件是否完整。-v
对每一个压缩和解压的文件，显示文件名和压缩比。-num 用指定的数字 num
调整压缩的速度，-1 或 --fast 表示最快压缩方法（低压缩比），-9
或--best表示最慢压缩方法（高压缩比）。系统缺省值为 6。指令实例：

gzip *% 把当前目录下的每个文件压缩成 .gz 文件。gzip -dv *%
把当前目录下每个压缩的文件解压，并列出详细的信息。gzip -l *%
详细显示例1中每个压缩的文件的信息，并不解压。gzip usr.tar% 压缩 tar 备份文件
usr.tar，此时压缩文件的扩展名为.tar.gz。
}}}

================================================================================
use "ip:port" to access local dir
python -m SimpleHTTPServer
port=8000

=======================
gnome-system-monitor &

======================
3秒后弹出alert 窗口
$ sleep 3 && alert "build done"

查看.bashrc中的alias 命令
$ alias
=====================
linux下shell统计文件目录下所有代码行数
find . -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.cc" | xargs cat|grep -v ^$|wc -l

