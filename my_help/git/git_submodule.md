# 使用Git Submodule管理子模块
- Maintainer: sky8336
-    Created: 2018-08-11
- LastChange: 2021-02-09
-    Version: V0.0.4

## 1.什么是Submodule?

- `git Submodule`: `项目协作工具`，
- 子项目作为单独的git项目存在父项目中，
- 子项目有自己独立的`commit`，`push`，`pull`
- 父项目以Submodule的形式包含子项目，
- 父项目指定`子项目header`，
- 父项目中提交`Submodule的信息`，
- clone父项目时可以初始化Submodule

## 2. 在项目中添加Submodule
### 添加submodule 方式1
```bash
$ git clone git@github.com:jjz/pod-library.git
$ git submodule add git@github.com:jjz/pod-library.git pod-library
```

`git status`看到, 多了两个需要提交的文件:
```bash
    new file: .gitmodules
    new file: pod-library
```

- .gitmodules: 记录`子项目的目录`和`子项目的git信息`
- git 不会记录Submodule的文件变动

### 添加Submodule:
```bash
$ git add .gitmodules pod-ibrary
$ git commit -m "pod-library submodule"
$ git submodule init
```

### 2.1 修改提交Submodule

确认有对Submodule的commit权限<br/>

1. 进入Submodule目录<br/>
`cd pod-library/`

2. 修改文件看下文件的变动<br/>
```bash
$ git status
modified: pod-library/UseAFHTTP.h
```

3. commit submodule<br/>

`git commit -a -m 'test submodule'`

4. push 到远端<br/>
`git push`

5. 再回到父目录<br/>
```bash
$ cd ..
$ git status
on branch master
modified: pod-library (new commits)
```

pod-library 变更为最新的commit id<br/>

>Subproject commit 330417cf3fc1d2c42092b20506b0d296d90d0b5f  
>我们需要推送到父项目的远端  

```bash
$ git commit -m 'update submodule'
$ git push
```

### 2.2 更新Submodule

更新的方法有两种:<br/>
+ 在父项目的目录下运行<br/>
`git submodule foreach git pull`

+ 在Submodule的目录下面更新<br/>
```bash
$ cd pod-library
$ #git pull
$ git submodule update
```

注意:<br/>
更新 Submodule 时, 如果有新的commit id产生，需要在父项目产生一个新的提交，<br/>
pod-libray文件中的 Subproject commit会变为最新的commit id


### 2.3 clone时初始化Submodule

1. clone 父项目时, 加递归参数 `--recursive`, 自动init Submodule<br/>
`git clone git@github.com:jjz/pod-project.git --recursive`

2. 第二种方法: 先clone父项目<br/>
```bash
$ git clone git@github.com:jjz/pod-project.git
$ cd pod-project
$ git submodule init
$ git submodule update
```

### 2.4 删除Submodule
git 不支持直接删除Submodule, 需要手动删除对应的文件<br/>
```bash
$ cd pod-project
$ git rm --cached pod-library
$ rm -rf pod-library
$ rm .gitmodules

$ vim .git/config
[submodule "pod-library"]
url = git@github.com:jjz/pod-library.git
# 删除submodule相关的内容

$ git commit -a -m 'remove pod-library submodule'
```
