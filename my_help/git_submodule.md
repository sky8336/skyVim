# 使用Git Submodule管理子模块

# 1 什么是Submodule?

git Submodule 是一个很好的项目协作工具，他允许类库项目做为repository,子项目做为
一个单独的git项目存在父项目中，子项目可以有自己的独立的commit，push，pull。
而父项目以Submodule的形式包含子项目，父项目可以指定子项目header，父项目中会提交
Submodule的信息，在clone父项目的时候可以把Submodule初始化。

# 2 在项目中添加Submodule
`git submodule add git@github.com:jjz/pod-library.git pod-library`

使用 git status命令可以看到, 多了两个需要提交的文件:
    new file: .gitmodules
    new file: pod-library

+ .gitmodules: 记录了子项目的目录和子项目的git信息
+ git并不会记录Submodule的文件变动


这两个文件都需要提交到父项目的git中

我们还可以这样添加Submodule:
1. git add .gitmodules pod-ibrary
2. git commit -m "pod-library submodule"
3. git submodule init

## 2.1 修改提交Submodule

首先要确认有对Submodule的commit权限<br/>

1. 进入Submodule目录<br/>
`cd pod-library/`

2. 修改其中的一个文件看下文件的变动<br/>
```
git status
modified: pod-library/UseAFHTTP.h
```

3. commit submodule<br/>

`git commit -a -m 'test submodule'`

4. push 到远端<br/>
`git push`

5. 再回到父目录<br/>
```
cd ..

git status

on branch master
modified: pod-library (new commits)
```

可以看到pod-library已经变更为最新的commit id<br/>

>Subproject commit 330417cf3fc1d2c42092b20506b0d296d90d0b5f  
>我们需要把推送到父项目的远端  

```
git commit -m 'update submodule'

git push
```

## 2.2 更新Submodule

更新的方法有两种:<br/>
+ 在父项目的目录下运行<br/>
`git submodule foreach git pull`

+ 在Submodule的目录下面更新<br/>
  ```
  cd pod-library
  //git pull
  git submodule update
  ```

注意:<br/>
更新Submodule的时候如果有新的commit id产生，需要在父项目产生一个新的提交，<br/>
pod-libray文件中的 Subproject commit会变为最新的commit id


## 2.3 在clone的时候初始化Submodule

1. 采用递归参数 --recursive<br/>
`git clone git@github.com:jjz/pod-project.git --recursive`


会自动init Submodule

2. 第二种方法: 先clone父项目<br/>
```
git clone git@github.com:jjz/pod-project.git
cd pod-project
git submodule init
git submodule update
```


## 2.4 删除Submodule

git 并不支持直接删除Submodule需要手动删除对应的文件<br/>
```
cd pod-project
git rm --cached pod-library
rm -rf pod-library
rm .gitmodules

vim .git/config

[submodule "pod-library"]

url = git@github.com:jjz/pod-library.git

删除submodule相关的内容

git commit -a -m 'remove pod-library submodule'
```
