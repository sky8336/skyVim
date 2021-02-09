# git command
- Maintainer: sky8336
-    Created: 2018-08-11
- LastChange: 2020-10-28
-    Version: V0.0.36

## git clone
### Git Clone非22端口

- Git默认情况下使用ssh的22端口进行数据传递
- 为了系统安全，有时候会修改ssh端口，在git clone时，需要指定端口
`git clone ssh://git@127.0.0.1:xx/yy.git 本地文件路径`
xx 端口号<br/>
yy.git 为仓库名字<br/>

## Git学习教程（5）Git tag {{{1
git push origin :refs/tags/v0.7.5

## Git学习教程（六）Git 日志 {{{1

查看每一次提交的补丁内容
	git log -p
	--显示每一次提交与其父节点提交内容之间的快照差异

	git log dir/
	:!git show commit-id

--	!command             Execute the shell command with `$SHELL`.

查看统计数字,添加或删除了多少行
	git log --stat

调整显示格式:
	git log --pretty=format
	--将提交历史显示成你想要的格式:oneline, short, medium, full, fuler, email, raw

分支拓扑图:
	git log --pretty=oneline --graph
	--显示提交历史及图像化分支拓扑

	git log --graph
	git log --graph --decorate --pretty=oneline --abbrev-commit --all


利用提交查询过滤器，查询符合某些条件的提交信息:
日期区间:
	git log --before="2 weeks ago" --after="2016-05-20" --pretty=oneline
	--查看5月20号之后，2个星期之前的提交内容

- 某时间段内commit 数量
`git log --since="2019.01.01" --until="2020.03.03" --pretty=oneline | wc -l`

- 两个commit-id 间的commit数量
`git log <commit-id1>^..<commit-id2> --pretty=oneline  | wc -l`

贡献者过滤器:
	--查看某个作者发起的提交：--author --commiter
	git log --author=liu,shuang --since="14 days ago" --pretty=oneline
	--查找作者在过去两周内的所有提交条目

可以指定完整人名或email地址来搜索
	git log --author=ningx.ma@intel.com

查找提交信息:
	git log --grep='C90' --pretty=oneline
	--搜索提交信息中有C90的所有提交内容

查看指定文件的提交历史:
	git log --pretty=oneline -- .vimrc
查看目录或文件的提交历史
	git log --pretty=oneline -- t/lib-httpd/ notes.c

查看未合并的提交历史记录
	git log --grep='c90' --pretty=oneline --no-merges

-N 查看满足条件的最近N条历史记录

查看两条提交信息之间的提交历史:
	git log --pretty=oneline 710f0f..8a5cbc
	--commit号710f0f(前6位)到commit号8a5cbc之间的提交历史
查找一个分支上的提交时:
	目前在'master'分支上，想查看'experiment'分支上还没有合并的提交记录：
	git log master..experiment --pretty=oneline
	--告诉你，如果现在合并的话，所有列出的这些提交都会被合并
	可以不写某一端的分支名，git会判断目前在哪个分支上。
	git log ..experiment --pretty=oneline

	如果在experiment分支上，也想看到相同的信息，即还没有合并到master的提交:
	git log master.. --pretty=oneline

## Git学习教程（七）Git差异比对 {{{1

git diff    查看变更还未载入(还未git add)的文件差异
git diff --stage/--cached   查看载入并未提交的变更差异
git diff HEAD  显示最后一次提交之后的所有变更。(包括变更的和未变更的)
git diff 'tag' -- README.md   查看tag标签后，README.md文件所发生的修改
git diff v1.0 v2.0  两次提交的差异比对
git diff v1.0 v2.0  显示两个版本之间差异的统计数字
git diff v1.0 v2.0 -- file.c   显示file.c在两个版本之间的比对结果
git diff master...dev  创建分支dev之后，在这条分支上的差异对比 ，用dev与
                    master 所交的分岐点和现在dev分支上最后一个快照比对

git diff HEAD~2 获取最近两次提交的具体不同 包括增删的文件以及行数以及每行具体的改动
git diff --stat 获取文件更改的个数 增加行数 删除行数
git diff --numstat 表格形式获取增加行数和减少行数

You can quickly review the changes made to a file using the diff command:
git diff <commit hash> <filename>

- 查看某次改动的具体修改:
	git show git提交版本号 文件名
	git show e17e782 --color=always | less -r

================================================================================
git branch

显示本地分支及分支头commit号、commit信息
git branch -v

显示本地、远程分支及分支头commit号、commit信息
git branch -va

对应的显示本地、远程分支及分支头commit号、commit信息
git branch -vv

获取,映射远程分支到本地:
(1)将远程分支信息获取到本地:
	git fetch

(2)将远程分支映射到本地命名为local-branchname的分支:
	git checkout -b local-branchname origin/remote_branchname

================================================================================
git revert {{{1
git revert commit-id

================================================================================
How to create and apply a patch with Git {{{1
git format-patch生成的Git专用Patch

If you fix a bug or create a new feature – do it in a separate branch!
FYI: I’m assuming you made a few commits in the fix_empty_poster branch and
did not yet merge it back in to the master branch.

--------------------------------------------------------------------------------
Creating the patch. {{{2
This will create a new file fix_empty_poster.patch with all changes from the
current (fix_empty_poster) against master.

	git format-patch master --stdout > fix_empty_poster.patch

>>针对每次提交生成一个patch
	git format-patch -M master
	-M选项表示这个patch要和那个分支比对
用git am来应用
	git am 0001-Fix1.patch
	git commit -a -m "PATCH apply"
--------------------------------------------------------------------------------
Applying the patch {{{2

(1) take a look at what changes are in the patch.
not apply the patch, but only shows you the stats about what it’ll do.
After peeking into the patch file with your favorite editor,
you can see what the actual changes are.

	git apply --stat fix_empty_poster.patch

(2) test the patch
If you don’t get any errors, the patch can be applied cleanly.

	git apply --check fix_empty_poster.patch

(3) apply the patch, I’ll use git am instead of git apply.
	(git am allows you to sign off an applied patch.)
	Patches were applied cleanly and your master branch has been updated.

	git am --signoff < fix_empty_poster.patch

================================================================================
git diff生成的标准patch {{{1

(1) 把git diff输出变为一个Patch
	git diff master > patch

(2) 使用git apply应用patch
	建立一个专门处理新交来的patch的分支:
	git checkout -b PATCH
	git apply patch
	git commit -a -m "Patch Apply"


================================================================================
git diff生成的标准patch {{{1
chmod a+x  .git/hooks/commit-msg

generate "Change-Id" to make it can be updated in one patch:
"Uploaded patch set 1."
"Uploaded patch set 2."
================================================================================
错误执行git commit --amend 之后想回退
git reflog
git reset commid

用 git reset HEAD <file>... 的方式取消暂存(取消git add)

git d: use vimdiff {{{1
in terminal:
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
// git d //open files to diff

git d{{{1
gitt d AmbaConfig
gitt d --cached  AmbaConfig

gui:
//git config --global diff.tool meld 


Dealing with line endings{{{1
git diff 忽略换行符差异：

git config --global core.whitespace cr-at-eol

更好的方法是每个项目都有一个.gitattributes文件
note:
Windows用CR LF来定义换行，Linux用LF。
CR全称是Carriage Return ,或者表示为\r, 意思是回车。
LF全称是Line Feed，它才是真正意义上的换行表示符。
如果用git diff的时候看到^M字符，就说明两个文件在换行符上有所差别。

Refreshing a repository after changing line endings

After you've set the core.autocrlf option and committed a .gitattributes file, you may find that Git wants to commit files that you have not modified. At this point, Git is eager to change the line endings of every file for you.

The best way to automatically configure your repository's line endings is to first backup your files with Git, delete every file in your repository (except the .git directory), and then restore the files all at once.

Save your current files in Git, so that none of your work is lost.

git add . -u
git commit -m "Saving files before refreshing line endings"

Remove the index and force Git to rescan the working directory.

rm .git/index

Rewrite the Git index to pick up all the new line endings.

git reset

Show the rewritten, normalized files.

git status

Add all your changed files back, and prepare them for a commit. This is your chance to inspect which files, if any, were unchanged.

git add -u
# It is perfectly safe to see a lot of messages here that read
# "warning: CRLF will be replaced by LF in file."

Rewrite the .gitattributes file.

git add .gitattributes

Commit the changes to your repository.

git commit -m "Normalize all the line endings"

忽略文件权限或者拥有者改变导致的git状态变化 {{{1
1) 在当前git仓库下执行：
	git config core.filemode false
	git config --list
2) 对全局git库生效
	git config --global core.filemode false
or:
	也可以在命令行下对文件进行编辑:
	vi ~/.gitconfig
	filemode = false

----
已经clone下来的项目,在使用全局设置后无用, 需要对当前项目做单独设置?
need to check?
	git config core.filemode false
or:
	vi ~/xxx_prj/.git/config
	filemode = false

3)删除配置
	git config --unset --global core.filemode false

git diff的时候忽略换行符的差异：{{{1
1)
	git config --global core.whitespace cr-at-eol
2)
更好的方法是每个项目都有一个.gitattributes文件，里面配好了换行符的设置，参考
https://help.github.com/articles/dealing-with-line-endings

撤消 git add 操作{{{1
	use the following cmd to unstage
	git reset HEAD <file>...

Reset or revert a specific file to a specific revision using Git {{{1
(1)	Assuming the hash of the commit you want is c5f567:

git checkout c5f567 -- file1/to/restore file2/to/restore

The git checkout man page gives more information.
If you want to revert to the commit before c5f567, append ~1 (works with any number):
`git checkout c5f567~1 -- file1/to/restore file2/to/restore`

git合并分支上指定的commit {{{1
假设分支结构如下：
dd2e86 - 946992 - 9143a9 - a6fd86 - 5a6057 [master]
                  \
				   76cada-62ecb3-b886a0[feature]
(1) cherry pick 合并单个 commit:
	git checkout master
	git cherry-pick 62ecb3
	62ecb3 已经应用在 master 上了（作为一个新的commit）。

(2) cherry pick 连续多个commit
合并多个要用 rebase。
假设想要把 76cada 和 62ecb3 合并到 master 上:
	git checkout -b newbranch 62ecb3
	git rebase --onto master 76cada^
	76cada^ 表示从 76cada 的 commit 开始合并（作为新的commit）。
	这样就完成了 76cada 到 62ecb3 合并到 master。

删除远程分支{{{1
    git push origin --delete Chapater6       
可以删除远程分支Chapater6

Git 修改commit message{{{1

1、 查看最近n次的提交
	git log --oneline -5
    查看最近5次commit的简要信息，输出信息为：简短commitID commit_message，

    git log -5，输出相对详细信息，完整commitID，加上--oneline查看简短commitID

2、git rebase -i <简短commitID>
    修改从上往下第n个commit_message，简短commitID为第n+1个.

    弹出窗口，显示最近n次的提交信息.

3、要修改的提交前的pick改为reword; 修改多个，将对应的多个pick改为reword

4、保存退出; 5、在弹出窗口中，修改commit_message;
   修改多个pick为reword，会多次弹出修改界面

5、查看修改结果
   git log --oneline -5
   or
   git log -5，

6、最后强制push上去git push --force


快捷操作：
---------
1，修改最近一次的commit 信息
　　git commit --amend

2，比如要修改的commit是倒数第三条，使用下述命令：
　　git rebase -i HEAD~3
    退出保存
3，执行 git rebase --continue
4，执行 git push -f 推送到服务端。

git 对比两个分支 具体某个文件的差异{{{1
比较本地分支:
git diff branch1 branch2 --stat   //显示出所有有差异的文件列表
git diff branch1 branch2 具体文件路径   //显示指定文件的详细差异
git diff branch1 branch2                   //显示出所有有差异的文件的详细差异

git diff origin/master origin/YT-Dms-Demo
远程分支前面要加上remote名称/
git diff local_branch origin/YT-Dms-Demo


Git show-branch显示提交信息{{{1
git show-branch
	1、输出分为上下两部分，使用若干个短划线”-“分隔。两个分支使用两个短划线”–“，三个分支使用三个短划线”—“，依次类推。
	2、上半部分为层次缩进的分支列表，下半部分为commit列表。
	3、上半部分的分支列表中，使用*标识当前分支，其他分支使用！标识（不同的分支！标识颜色不一样）。分支前的标识符*或者！一直垂直贯通到下半部分，这一垂直列的符号都是属于这个分支的。
	4、下半部分的commit列表中，前导的符号有*和+号。*表示这一列上的分支(当前分支)有此commit。而+表示这一列上的分支(非当前分支)有此commit。
	5、标识符的颜色只是用于容易区分列，一个分支一个颜色。

	使用git show-branch，查看某个使用 git branch branchName 或 git
	checkout -b branchName 开的分支的第一次提交。否则，直接使用 git
	log　是没办法找到该分支的第一次提交的情况的。

	 

	另外一个查看分支什么时候开的，或某个分支第一次提交的方法就是，在开分支的时候使用如下命令开分支：
	1 $ git checkout --orphan branchName
　　使用 --orphan 参数开分支时，要注意，新分支的文件都相当于新添加，且已add过的，
    因此，在文件修改之前，需要先commit一次，否则第一次提交没办法和默认开分支时的文件进行对比。

### .gitignore 忽略掉某个文件{{{1
想忽略掉某个文件，修改.gitignore。
	每一行保存了一个匹配的规则例如：

# 此为注释 – 将被 Git 忽略
*.a       # 忽略所有 .a 结尾的文件
!lib.a    # 但 lib.a 除外
/TODO     # 仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
build/    # 忽略 build/ 目录下的所有文件
doc/*.txt # 会忽略 doc/notes.txt 但不包括 doc/server/arch.txt

### 把某些目录或文件加入忽略规则，未生效
原因:
	.gitignore 只能忽略原来没有被追踪的文件，
	文件已经被纳入版本管理中，修改.gitignore 无效。

解决方法:
	1. 先清除本地缓存（改变成未被追踪状态），
	git rm -r --cached .
	git add .
	git commit -m 'update .gitignore'
	2. 再提交，就不会出现忽略的文件了。

注意：.gitignore 只能作用于未被跟踪的文件，
## git 查看修改了哪些文件
git diff --stat  --name-only HEAD^ HEAD
git show --name-only
