# git提交
- Maintainer: sky8336
-    Created: 2018-08-11
- LastChange: 2020-09-22
-    Version: V0.0.21

**note:**
1. 文件中中文较多时，查看文件编码格式，防止在gitk中显示乱码
file 文件名
在Vim 中查看 文件编码
`:set fileencoding`
在Vim中转换文件编码， 转换成utf-8格式
`:set fileencoding=utf-8`


## 1. git提交代码
### 1.1 正常提交流程
1. 同步并显示修改文件路径:
`git pull && git status`

2. 本地修改添加到缓存区
- `git add private/a10/JX_s07_KS/vendor/sprd/GSTCustomize`
- `git add -A .`
- `git add -A :/`

3. 将本地缓存区内容提交到本地HEAD中
`git commit -m "[GST05][JX_S07_KS]增加客户的开关机动画铃声/客户提供的apk"`

代码提交信息: `"[GST01][项目名称] 修改的内容"(GST01：代码优化)`

4. 显示最后一次提交之后的所有变更(包括变更的和未变更的)
`git diff HEAD`
图形界面查看添加的内容: `gitk &`
- 如果有漏添加的修改：
  1. 用`git status`查看漏提交的修改。
  2. `git add private` add漏提交的修改文件到缓存区
  3. gitk 确认要提交的本地修改全部添加到缓存区

- 修改最后一次提交信息(未push过)：`git commit --amend`

5. 同步后提交到远端
`git pull --rebase origin &&  git push`
同步，并重新基于当前分支将本地修改移至节点树的最前面; (origin 可省略)
将本地仓库HEAD 中的改动提交到远端仓库
检查确认一下: `gitk &`

此时.若无冲突，结束。

### 1.2 冲突处理

gitk查看，若出现分支，显示merge：
`git reset --hard` 分支出现前的节点
本地HEAD重置为这个节点, 再git pull同步一下代码。

若有冲突，提示错误。执行:
1. `git stash`
    将冲突放一边（暂且这么说）
2. `git pull --rebase origin`
    重新来过
    `git push`
    重新来过，此时就不会有冲突了
    gitk &
    查看一下
3. git stash pop
    提交完成后执行

## git 常用操作
### 替换掉本地错误改动
    `git checkout -- <filename>`
使用 HEAD 中的最新内容替换掉你的工作目录中的文件。已添加到缓存区的改动，
以及新文件，都不受影响。

### commit 后发现有错误：

丢弃所有的本地改动与提交，获取服务器上最新版本并将本地主分支指向它：
```bash
    git fetch origin
    git reset --hard origin/master
```
commit后发现有漏修改或漏commit的文件 {{{1
    git reset --soft：回退到某个版本，只回退了commit的信息，不会恢复到
	index file一级。如果还要提交，直接commit即可

### git删除错误提交的commit
```bash
	git reset --hard <commit_id>
	git push origin HEAD --force
```

其他:
–soft –mixed –hard，对working tree和index和HEAD进行重置:

git reset –mixed：默认，不带参数的git reset，即这方式，它回退到某个版本，只保
留源码，回退commit和index信息

git reset –soft：回退到某个版本，只回退commit的信息，不会恢复到index file一级。
如果还要提交，直接commit即可.

git reset –hard：彻底回退到某个版本，本地的源码也会变为上一个版本的内容.


HEAD 最近一个提交
HEAD^ 上一次
`<commit_id>` 每次commit的SHA1值.

git 合并分支上指定的commit{{{1
```bash
	git checkout master
	git cherry-pick 3b6360
```

### 整体更新代码，全编
在工程根目录下：
git clean -df     (删除没有 git add 的 目录 和 文件)
git chekout .     撤消对文件的修改
git pull          从服务器 pull（同步）新的改动

拷贝私有到main目录下

### 查看git地址: 
`git remote -v`

## intel提交代码到gerrit：
VR_MRD

一、建立本地分支（必须）
```bash
repo start  --all xxx
repo start xxx .
```
二、在本地分支下进行上传：
1、`git status` (查看修改状态)
2、`git add` （将要提交的文件添加进缓存）
3、`git commit` （写添加改动信息）
	`git commit -s`   在改动信息中添加 修改人信息
	在 commit 中要写明修改原因，修复什么样的问题，
	在`Tracked-on`：中要写修复bug的链接，或者bug号
4,提交修改：
`repo upload`

或
`git push origin HEAD:refs/for/branch-name`

## git 命令：
	`git am xxx.patch`
	(xxx.patch 是由 git format-patch 生成的)

	`git commit -s –amend` 修改上次的提交

	abandon local branch(删除本地分支):
		repo abandon local_branch

	查看分支：
		repo branch

	checkout:
		git fetch ssh://nma1x@ctegerrit.sh.intel.com:29418/a/bsp/vendor/intel/ish-sensors refs/changes/02/15902/4 && git checkout FETCH_HEAD

	cherry pich:(将gerrit 上的patch 打到自己本地)：
		git fetch ssh://nma1x@ctegerrit.sh.intel.com:29418/a/bsp/vendor/intel/ish-sensors refs/changes/02/15902/4 && git cherry-pick FETCH_HEAD
	format patch:
		git fetch ssh://nma1x@ctegerrit.sh.intel.com:29418/a/bsp/vendor/intel/ish-sensors refs/changes/02/15902/4 && git format-patch -1 --stdout FETCH_HEAD
	pull:
		git pull ssh://nma1x@ctegerrit.sh.intel.com:29418/a/bsp/vendor/intel/ish-sensors refs/changes/02/15902/4

	create local branch, and switch to it:
		git checkout -b MS/VR/HMD remotes/origin/c/MS/VR/HMD


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
remove a local commit, like this:{{{1
commit 1 (current)
commit 2 (need to remove)

------
git log
git reflog
git branch -l
git checkout dma_test_drv

git log
git reset 1e9f2f

git status
git stash
git log
git reset --hard HEAD~1
git log
git stash pop
git log

## repo sync

### case 1:
1) git checkout -b temp
2) save the change file as local commit
   git add .
   git commit -e
3) git reset HEAD^
4) repo sync
5) git checkout -b new_branch
6) git checkout temp
   git log
7) git checkout new_branch
	git cherry-pick commit-id
8) if you just want it stay in local, make it not staged for comiit
	git reset last-but-one-commit-id

### case 2:

#### patch -p1
1) patch apply:
```shell
patch -p1 < ~/Desktop/6834367d.diff 
git status
git diff
git add .
git commit -e 
same Change-ID  I21fc35e67b56f0589387971e29db819291fc1bdd
git push origin HEAD:refs/for/integ/bxtp_ivi_m
```

2) patch update:
```shell
patch -p1 < ~/disk2/nma1x-wk/b414b1d8.diff 
patching file sound/hda/hdac_stream.c
Reversed (or previously applied) patch detected!  Assume -R? [n] y
patching file sound/hda/hdac_sysfs.c
Reversed (or previously applied) patch detected!  Assume -R? [n] y

then again:
patch -p1 < ~/disk2/nma1x-wk/b414b1d8.diff 
```

#### create and apply a patch with git
If you fix a bug or create a new feature – do it in a separate branch!

**Before you start:**
clone repository and create a new branch for the fix you have in mind.
	git checkout -b fix_empty_poster

Now, in the new fix_empty_poster branch you can hack whatever you need
to fix.  Write tests, update code etc. etc.

**Creating the patch:**
FYI: I’m assuming you made a few commits in the fix_empty_poster branch and did
not yet merge it back in to the master branch.

git format-patch master --stdout > fix_empty_poster.patch

This will create a new file fix_empty_poster.patch with all changes from the
current (fix_empty_poster) against master. 

**Apllying the patch**
(1) take a look at what changes are in the patch.
	`git apply --stat fix_empty_poster.patch`

(2) how troublesome the patch is going to be. Test the patch before you actually apply it.
	`git apply --check fix_empty_poster.patch`

	If you don’t get any errors, the patch can be applied cleanly.
	Otherwise you may see what trouble you’ll run into. 

(3) To apply the patch, I’ll use git am instead of git apply. The reason for
this is that git am allows you to sign off an applied patch. This may be useful
for later reference.
`git am --signoff < fix_empty_poster.patch`

	run your tests again to make sure nothing got borked.

## gitlab push
```shell
git clone git@xxx.xxx.xxx.xxx:prj_name/git-repo.git
cd git-repo
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```


### create your-repo on gitlab
#### Create a new repository

```shell
git remote add origin git@xxx.xxx.xxx.xxx:xxx/your-repo.git
cd your-repo
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

#### Existing_folder
create your-repo 
````
cd existing_folder
git init
git remote add origin git@xxx.xxx.xxx.xxx:xxx/your-repo.git
git add .
git commit -m "Initial commit"
git push -u origin master
````



#### Existing Git repository
```
cd existing_repo
git remote add origin git@xxx.xxx.xxx.xxx:xxx/your-repo.git
git push -u origin --all
git push -u origin --tags
````

## repo操作导致代码消失
FA&Q:
在分支的detached状态(no branch)时，repo sync 导致本地commit丢失。
1. 查找之前提交的信息: `git reflog`
2. 切换到相应的分支: `git checkout yourbranch`
3. 合并刚才reflog看到的行应commit: `git merge commitID`
4. 提交
`git reflog`: 可以查看所有分支的所有操作记录（包括已经被删除的 commit 记录和 reset 的操作）

## 分支与master保持同步
1. 将本地的master 拉到最新: `repo sync .` 或 `git checkout master && git pull`
2. 使dev保持与master 同步
```shell
git checkout dev
git merge master #或 git rebase master
```
创建本地分支并关联远程分支:
`branch --set-upstream-to=origin/master master`
