
vimium快捷键列表

来源
一个使用快捷键来操作浏览器页面的插件。

浏览当前页面：

?       显示所有可用键列表的帮助对话框
h       向左滚动
j       向下滚动
k       向上滑动
l       向右滚动
gg      滚动到页面顶部
G       滚动到页面的底部
d       向下滚动半页
u       向上滚动半页
f       在当前标签中打开一个链接
F       在新标签中打开链接
r       重新载入
gs      查看源代码
i       进入插入模式 - 所有的命令将被忽略，直到你按Esc退出
yy      将当前的网址复制到剪贴板
yf      将链接网址复制到剪贴板
gf      定位焦点到下一级框架
gF      定位焦点到顶部框架

导航到新页面：

o       打开网址，书签或历史记录条目
O       在新标签中打开网址，书签，历史记录
b       打开书签
B       在新标签中打开书签

使用查找：

/       进入查找模式。 键入您的搜索查询，然后按Enter键搜索，或按Esc键取消
n       循环前进到下一个匹配
N       向后循环到先前的匹配

有关高级用法，请参阅wiki上的正则表达式。

浏览你的历史：

H       上一个历史(后退)
L       下一个历史(前进)

操作标签：

J, gT   跳到左边选项卡
K, gt   跳到右边选项卡
g0      跳到第一个选项卡
g$      跳到最后一个选项卡
^       访问先前访问的选项卡
t       创建选项卡
yt      重复当前选项卡
x       关闭当前选项卡
X       恢复 x 命令关闭的选项卡
T       搜索你打开的选项卡
W       将当前选项卡移至新窗口
<a-p>   固定/取消当前选项卡(alt+p)

使用标记：

ma, mA  设置当地标记“a”（全球标记“A”）
`a, `A  跳转到本地标记“a”（全局标记“A”）
``      跳回到前一跳之前的位置。 也就是在之前的gg，g，n，N，或者a之前

其他高级浏览命令：

]], [[  下一页,上一页(可配置翻页标记)
<a-f>   在新标签页中打开某链接
gi      聚焦到输入框
gu      进入地址栏URL中的上一级
gU      进入地址栏URL中的最顶级
ge      编辑当前的URL
gE      编辑当前URL并在新标签中打开
zH      向左滚动
zL      一路向右滚动
v       进入视觉模式; 使用p/P搜索，使用y复制
V       进入视线模式

Vimium支持命令重复，例如，点击5t将快速连续打开5个选项卡。 <Esc>（或<c - [>））将清除队列中的任何部分命令，也将退出插入和查找模式。

有一些先进的命令，这里没有记录; 请参阅帮助对话框（输入”?”）获取完整列表。

未翻译原文:

  Navigating the current page:

      ?       show the help dialog for a list of all available keys
      h       scroll left
      j       scroll down
      k       scroll up
      l       scroll right
      gg      scroll to top of the page
      G       scroll to bottom of the page
      d       scroll down half a page
      u       scroll up half a page
      f       open a link in the current tab
      F       open a link in a new tab
      r       reload
      gs      view source
      i       enter insert mode -- all commands will be ignored until you hit Esc to exit
      yy      copy the current url to the clipboard
      yf      copy a link url to the clipboard
      gf      cycle forward to the next frame
      gF      focus the main/top frame

  Navigating to new pages:

      o       Open URL, bookmark, or history entry
      O       Open URL, bookmark, history entry in a new tab
      b       Open bookmark
      B       Open bookmark in a new tab

  Using find:

      /       enter find mode
                -- type your search query and hit enter to search, or Esc to cancel
      n       cycle forward to the next find match
      N       cycle backward to the previous find match

  For advanced usage, see [regular expressions](https://github.com/philc/vimium/wiki/Find-Mode) on the wiki.

  Navigating your history:

      H       go back in history
      L       go forward in history

  Manipulating tabs:

      J, gT   go one tab left
      K, gt   go one tab right
      g0      go to the first tab
      g$      go to the last tab
      ^       visit the previously-visited tab
      t       create tab
      yt      duplicate current tab
      x       close current tab
      X       restore closed tab (i.e. unwind the 'x' command)
      T       search through your open tabs
      W       move current tab to new window
      <a-p>   pin/unpin current tab

  Using marks:

      ma, mA  set local mark "a" (global mark "A")
      `a, `A  jump to local mark "a" (global mark "A")
      ``      jump back to the position before the previous jump
                -- that is, before the previous gg, G, n, N, / or `a

  Additional advanced browsing commands:

      ]], [[  Follow the link labeled 'next' or '>' ('previous' or '<')
                - helpful for browsing paginated sites
      <a-f>   open multiple links in a new tab
      gi      focus the first (or n-th) text input box on the page
      gu      go up one level in the URL hierarchy
      gU      go up to root of the URL hierarchy
      ge      edit the current URL
      gE      edit the current URL and open in a new tab
      zH      scroll all the way left
      zL      scroll all the way right
      v       enter visual mode; use p/P to paste-and-go, use y to yank
      V       enter visual line mode

  Vimium supports command repetition so, for example, hitting `5t` will open 5 tabs in rapid succession. `<Esc>` (or
  `<c-[>`) will clear any partial commands in the queue and will also exit insert and find modes.

  There are some advanced commands which aren't documented here; refer to the help dialog (type `?`) for a full
  list.

