This is a mirror of http://www.vim.org/scripts/script.php?script_id=69

You can use this plugin's basic functionality to set up a list of frequently-accessed files for easy navigation. The list of files will be displayed in a window on the left side of the Vim window, and you can press <Return> or double-click on filenames in the list to open the files. This is similar to how some IDEs I've used work. I find this easier to use than having to navigate a directory hierarchy with the file-explorer.  It also obviates the need for a buffer explorer because you have your list of files on the left of the Vim Window. 

But there's much, much more . . . . 

You can also instruct the Plugin to change to a directory and to run scripts when you select a file. These scripts can, for example, modify the environment to include compilers in $PATH. This makes it very easy to use quickfix with multiple projects that use different environments. I give examples in the documentation. 

Other features include: 
* Loading/Unloading all the files in a Project (\l, \L, \w, and \W) 
* Grepping all the files in a Project (\g and \G) 
* Running a user-specified script on a file (can be used to launch an external program on the file) (\1 through \9) 
* Running a user-specified script on all the files in a Project (\f1-\f9 and \F1-\F9) 
* Also works with the netrw plugin using directory names like ftp://remotehost (Good for webpage maintenance.) 
* Support for custom mappings for version control integration (example of perforce in the documentation). 
* I also give an example in the documentation on how to set up a custom launcher based on extension. The example launches *.jpg files in a viewer. I have also set up viewers for PDF (acroread) and HTML files (mozilla) for my own use. 

This plugin is known to work on Linux, Solaris, and Windows. 
