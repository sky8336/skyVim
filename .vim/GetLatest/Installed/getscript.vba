" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/getscriptPlugin.vim	[[[1
38
" ---------------------------------------------------------------------
" getscriptPlugin.vim
"  Author:	Charles E. Campbell, Jr.
"  Date:	Jan 07, 2008
"  Installing:	:help glvs-install
"  Usage:	:help glvs
"
" GetLatestVimScripts: 642 1 :AutoInstall: getscript.vim
"
" (Rom 15:11 WEB) Again, "Praise the Lord, all you Gentiles!  Let
" all the peoples praise Him."
" ---------------------------------------------------------------------
" Initialization:	{{{1
" if you're sourcing this file, surely you can't be
" expecting vim to be in its vi-compatible mode
if &cp || exists("g:loaded_getscriptPlugin")
 if &verbose
  echo "GetLatestVimScripts is not vi-compatible; not loaded (you need to set nocp)"
 endif
 finish
endif
let g:loaded_getscriptPlugin = "v33"
let s:keepcpo                = &cpo
set cpo&vim

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com!        -nargs=0 GetLatestVimScripts call getscript#GetLatestVimScripts()
com!        -nargs=0 GetScripts          call getscript#GetLatestVimScripts()
silent! com -nargs=0 GLVS                call getscript#GetLatestVimScripts()

" ---------------------------------------------------------------------
" Restore Options: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
" vim: ts=8 sts=2 fdm=marker nowrap
autoload/getscript.vim	[[[1
650
" ---------------------------------------------------------------------
" getscript.vim
"  Author:	Charles E. Campbell, Jr.
"  Date:	May 31, 2011
"  Version:	33
"  Installing:	:help glvs-install
"  Usage:	:help glvs
"
" GetLatestVimScripts: 642 1 :AutoInstall: getscript.vim
"redraw!|call inputsave()|call input("Press <cr> to continue")|call inputrestore()
" ---------------------------------------------------------------------
" Initialization:	{{{1
" if you're sourcing this file, surely you can't be
" expecting vim to be in its vi-compatible mode!
if exists("g:loaded_getscript")
 finish
endif
let g:loaded_getscript= "v33"
if &cp
 echoerr "GetLatestVimScripts is not vi-compatible; not loaded (you need to set nocp)"
 finish
endif
if v:version < 702
 echohl WarningMsg
 echo "***warning*** this version of getscript needs vim 7.2"
 echohl Normal
 finish
endif
let s:keepcpo = &cpo
set cpo&vim
"DechoTabOn

" ---------------------------
" Global Variables: {{{1
" ---------------------------
" Cygwin Detection ------- {{{2
if !exists("g:getscript_cygwin")
 if has("win32") || has("win95") || has("win64") || has("win16")
  if &shell =~ '\%(\<bash\>\|\<zsh\>\)\%(\.exe\)\=$'
   let g:getscript_cygwin= 1
  else
   let g:getscript_cygwin= 0
  endif
 else
  let g:getscript_cygwin= 0
 endif
endif

" wget vs curl {{{2
if !exists("g:GetLatestVimScripts_wget")
 if executable("wget")
  let g:GetLatestVimScripts_wget= "wget"
 elseif executable("curl")
  let g:GetLatestVimScripts_wget= "curl"
 else
  let g:GetLatestVimScripts_wget    = 'echo "GetLatestVimScripts needs wget or curl"'
  let g:GetLatestVimScripts_options = ""
 endif
endif

" options that wget and curl require:
if !exists("g:GetLatestVimScripts_options")
 if g:GetLatestVimScripts_wget == "wget"
  let g:GetLatestVimScripts_options= "-q -O"
 elseif g:GetLatestVimScripts_wget == "curl"
  let g:GetLatestVimScripts_options= "-s -O"
 else
  let g:GetLatestVimScripts_options= ""
 endif
endif

" by default, allow autoinstall lines to work
if !exists("g:GetLatestVimScripts_allowautoinstall")
 let g:GetLatestVimScripts_allowautoinstall= 1
endif

"" For debugging:
"let g:GetLatestVimScripts_wget    = "echo"
"let g:GetLatestVimScripts_options = "options"

" ---------------------------------------------------------------------
" Check If AutoInstall Capable: {{{1
let s:autoinstall= ""
if g:GetLatestVimScripts_allowautoinstall

 if (has("win32") || has("gui_win32") || has("gui_win32s") || has("win16") || has("win64") || has("win32unix") || has("win95")) && &shell != "bash"
  " windows (but not cygwin/bash)
  let s:dotvim= "vimfiles"
  if !exists("g:GetLatestVimScripts_mv")
   let g:GetLatestVimScripts_mv= "ren"
  endif

 else
  " unix
  let s:dotvim= ".vim"
  if !exists("g:GetLatestVimScripts_mv")
   let g:GetLatestVimScripts_mv= "mv"
  endif
 endif

 if exists("g:GetLatestVimScripts_autoinstalldir") && isdirectory(g:GetLatestVimScripts_autoinstalldir)
  let s:autoinstall= g:GetLatestVimScripts_autoinstalldir"
 elseif exists('$HOME') && isdirectory(expand("$HOME")."/".s:dotvim)
  let s:autoinstall= $HOME."/".s:dotvim
 endif
" call Decho("s:autoinstall<".s:autoinstall.">")
"else "Decho
" call Decho("g:GetLatestVimScripts_allowautoinstall=".g:GetLatestVimScripts_allowautoinstall.": :AutoInstall: disabled")
endif

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com!        -nargs=0 GetLatestVimScripts call getscript#GetLatestVimScripts()
com!        -nargs=0 GetScript           call getscript#GetLatestVimScripts()
silent! com -nargs=0 GLVS                call getscript#GetLatestVimScripts()

" ---------------------------------------------------------------------
" GetLatestVimScripts: this function gets the latest versions of {{{1
"                      scripts based on the list in
"   (first dir in runtimepath)/GetLatest/GetLatestVimScripts.dat
fun! getscript#GetLatestVimScripts()
"  call Dfunc("GetLatestVimScripts() autoinstall<".s:autoinstall.">")

" insure that wget is executable
  if executable(g:GetLatestVimScripts_wget) != 1
   echoerr "GetLatestVimScripts needs ".g:GetLatestVimScripts_wget." which apparently is not available on your system"
"   call Dret("GetLatestVimScripts : wget not executable/availble")
   return
  endif

  " insure that fnameescape() is available
  if !exists("*fnameescape")
   echoerr "GetLatestVimScripts needs fnameescape() (provided by 7.1.299 or later)"
   return
  endif

  " Find the .../GetLatest subdirectory under the runtimepath
  for datadir in split(&rtp,',') + ['']
   if isdirectory(datadir."/GetLatest")
"    call Decho("found directory<".datadir.">")
    let datadir= datadir . "/GetLatest"
    break
   endif
   if filereadable(datadir."GetLatestVimScripts.dat")
"    call Decho("found ".datadir."/GetLatestVimScripts.dat")
    break
   endif
  endfor

  " Sanity checks: readability and writability
  if datadir == ""
   echoerr 'Missing "GetLatest/" on your runtimepath - see :help glvs-dist-install'
"   call Dret("GetLatestVimScripts : unable to find a GetLatest subdirectory")
   return
  endif
  if filewritable(datadir) != 2
   echoerr "(getLatestVimScripts) Your ".datadir." isn't writable"
"   call Dret("GetLatestVimScripts : non-writable directory<".datadir.">")
   return
  endif
  let datafile= datadir."/GetLatestVimScripts.dat"
  if !filereadable(datafile)
   echoerr "Your data file<".datafile."> isn't readable"
"   call Dret("GetLatestVimScripts : non-readable datafile<".datafile.">")
   return
  endif
  if !filewritable(datafile)
   echoerr "Your data file<".datafile."> isn't writable"
"   call Dret("GetLatestVimScripts : non-writable datafile<".datafile.">")
   return
  endif
  " --------------------
  " Passed sanity checks
  " --------------------

"  call Decho("datadir  <".datadir.">")
"  call Decho("datafile <".datafile.">")

  " don't let any event handlers interfere (like winmanager's, taglist's, etc)
  let eikeep  = &ei
  let hlskeep = &hls
  let acdkeep = &acd
  set ei=all hls&vim noacd

  " Edit the datafile (ie. GetLatestVimScripts.dat):
  " 1. record current directory (origdir),
  " 2. change directory to datadir,
  " 3. split window
  " 4. edit datafile
  let origdir= getcwd()
"  call Decho("exe cd ".fnameescape(substitute(datadir,'\','/','ge')))
  exe "cd ".fnameescape(substitute(datadir,'\','/','ge'))
  split
"  call Decho("exe  e ".fnameescape(substitute(datafile,'\','/','ge')))
  exe "e ".fnameescape(substitute(datafile,'\','/','ge'))
  res 1000
  let s:downloads = 0
  let s:downerrors= 0

  " Check on dependencies mentioned in plugins
"  call Decho(" ")
"  call Decho("searching plugins for GetLatestVimScripts dependencies")
  let lastline    = line("$")
"  call Decho("lastline#".lastline)
  let firstdir    = substitute(&rtp,',.*$','','')
  let plugins     = split(globpath(firstdir,"plugin/*.vim"),'\n')
  let plugins     = plugins + split(globpath(firstdir,"AsNeeded/*.vim"),'\n')
  let foundscript = 0

  " this loop updates the GetLatestVimScripts.dat file
  " with dependencies explicitly mentioned in the plugins
  " via   GetLatestVimScripts: ... lines
  " It reads the plugin script at the end of the GetLatestVimScripts.dat
  " file, examines it, and then removes it.
  for plugin in plugins
"   call Decho(" ")
"   call Decho("plugin<".plugin.">")

   " read plugin in
   " evidently a :r creates a new buffer (the "#" buffer) that is subsequently unused -- bwiping it
   $
"   call Decho(".dependency checking<".plugin."> line$=".line("$"))
"   call Decho("..exe silent r ".fnameescape(plugin))
   exe "silent r ".fnameescape(plugin)
   exe "silent bwipe ".bufnr("#")

   while search('^"\s\+GetLatestVimScripts:\s\+\d\+\s\+\d\+','W') != 0
    let depscript   = substitute(getline("."),'^"\s\+GetLatestVimScripts:\s\+\d\+\s\+\d\+\s\+\(.*\)$','\1','e')
    let depscriptid = substitute(getline("."),'^"\s\+GetLatestVimScripts:\s\+\(\d\+\)\s\+.*$','\1','')
    let llp1        = lastline+1
"    call Decho("..depscript<".depscript.">")

    " found a "GetLatestVimScripts: # #" line in the script;
    " check if its already in the datafile by searching backwards from llp1,
    " the (prior to reading in the plugin script) last line plus one of the GetLatestVimScripts.dat file,
    " for the script-id with no wrapping allowed.
    let curline     = line(".")
    let noai_script = substitute(depscript,'\s*:AutoInstall:\s*','','e')
    exe llp1
    let srchline    = search('^\s*'.depscriptid.'\s\+\d\+\s\+.*$','bW')
    if srchline == 0
     " this second search is taken when, for example, a   0 0 scriptname  is to be skipped over
     let srchline= search('\<'.noai_script.'\>','bW')
    endif
"    call Decho("..noai_script<".noai_script."> depscriptid#".depscriptid." srchline#".srchline." curline#".line(".")." lastline#".lastline)

    if srchline == 0
     " found a new script to permanently include in the datafile
     let keep_rega   = @a
     let @a          = substitute(getline(curline),'^"\s\+GetLatestVimScripts:\s\+','','')
     echomsg "Appending <".@a."> to ".datafile." for ".depscript
"     call Decho("..Appending <".@a."> to ".datafile." for ".depscript)
     exe lastline."put a"
     let @a          = keep_rega
     let lastline    = llp1
     let curline     = curline     + 1
     let foundscript = foundscript + 1
"    else	" Decho
"     call Decho("..found <".noai_script."> (already in datafile at line#".srchline.")")
    endif

    let curline = curline + 1
    exe curline
   endwhile

   " llp1: last line plus one
   let llp1= lastline + 1
"   call Decho(".deleting lines: ".llp1.",$d")
   exe "silent! ".llp1.",$d"
  endfor
"  call Decho("--- end dependency checking loop ---  foundscript=".foundscript)
"  call Decho(" ")
"  call Dredir("BUFFER TEST (GetLatestVimScripts 1)","ls!")

  if foundscript == 0
   setlocal nomod
  endif

  " --------------------------------------------------------------------
  " Check on out-of-date scripts using GetLatest/GetLatestVimScripts.dat
  " --------------------------------------------------------------------
"  call Decho("begin: checking out-of-date scripts using datafile<".datafile.">")
  setlocal lz
  1
"  /^-----/,$g/^\s*\d/call Decho(getline("."))
  1
  /^-----/,$g/^\s*\d/call s:GetOneScript()
"  call Decho("--- end out-of-date checking --- ")

  " Final report (an echomsg)
  try
   silent! ?^-------?
  catch /^Vim\%((\a\+)\)\=:E114/
"   call Dret("GetLatestVimScripts : nothing done!")
   return
  endtry
  exe "norm! kz\<CR>"
  redraw!
  let s:msg = ""
  if s:downloads == 1
  let s:msg = "Downloaded one updated script to <".datadir.">"
  elseif s:downloads == 2
   let s:msg= "Downloaded two updated scripts to <".datadir.">"
  elseif s:downloads > 1
   let s:msg= "Downloaded ".s:downloads." updated scripts to <".datadir.">"
  else
   let s:msg= "Everything was already current"
  endif
  if s:downerrors > 0
   let s:msg= s:msg." (".s:downerrors." downloading errors)"
  endif
  echomsg s:msg
  " save the file
  if &mod
   silent! w!
  endif
  q

  " restore events and current directory
  exe "cd ".fnameescape(substitute(origdir,'\','/','ge'))
  let &ei  = eikeep
  let &hls = hlskeep
  let &acd = acdkeep
  setlocal nolz
"  call Dredir("BUFFER TEST (GetLatestVimScripts 2)","ls!")
"  call Dret("GetLatestVimScripts : did ".s:downloads." downloads")
endfun

" ---------------------------------------------------------------------
"  GetOneScript: (Get Latest Vim Script) this function operates {{{1
"    on the current line, interpreting two numbers and text as
"    ScriptID, SourceID, and Filename.
"    It downloads any scripts that have newer versions from vim.sourceforge.net.
fun! s:GetOneScript(...)
"   call Dfunc("GetOneScript()")

 " set options to allow progress to be shown on screen
  let rega= @a
  let t_ti= &t_ti
  let t_te= &t_te
  let rs  = &rs
  set t_ti= t_te= nors

 " put current line on top-of-screen and interpret it into
 " a      script identifer  : used to obtain webpage
 "        source identifier : used to identify current version
 " and an associated comment: used to report on what's being considered
  if a:0 >= 3
   let scriptid = a:1
   let srcid    = a:2
   let fname    = a:3
   let cmmnt    = ""
"   call Decho("scriptid<".scriptid.">")
"   call Decho("srcid   <".srcid.">")
"   call Decho("fname   <".fname.">")
  else
   let curline  = getline(".")
   if curline =~ '^\s*#'
    let @a= rega
"    call Dret("GetOneScript : skipping a pure comment line")
    return
   endif
   let parsepat = '^\s*\(\d\+\)\s\+\(\d\+\)\s\+\(.\{-}\)\(\s*#.*\)\=$'
   try
    let scriptid = substitute(curline,parsepat,'\1','e')
   catch /^Vim\%((\a\+)\)\=:E486/
    let scriptid= 0
   endtry
   try
    let srcid    = substitute(curline,parsepat,'\2','e')
   catch /^Vim\%((\a\+)\)\=:E486/
    let srcid= 0
   endtry
   try
    let fname= substitute(curline,parsepat,'\3','e')
   catch /^Vim\%((\a\+)\)\=:E486/
    let fname= ""
   endtry
   try
    let cmmnt= substitute(curline,parsepat,'\4','e')
   catch /^Vim\%((\a\+)\)\=:E486/
    let cmmnt= ""
   endtry
"   call Decho("curline <".curline.">")
"   call Decho("parsepat<".parsepat.">")
"   call Decho("scriptid<".scriptid.">")
"   call Decho("srcid   <".srcid.">")
"   call Decho("fname   <".fname.">")
  endif

  " plugin author protection from downloading his/her own scripts atop their latest work
  if scriptid == 0 || srcid == 0
   " When looking for :AutoInstall: lines, skip scripts that have   0 0 scriptname
   let @a= rega
"   call Dret("GetOneScript : skipping a scriptid==srcid==0 line")
   return
  endif

  let doautoinstall= 0
  if fname =~ ":AutoInstall:"
"   call Decho("case AutoInstall: fname<".fname.">")
   let aicmmnt= substitute(fname,'\s\+:AutoInstall:\s\+',' ','')
"   call Decho("aicmmnt<".aicmmnt."> s:autoinstall=".s:autoinstall)
   if s:autoinstall != ""
    let doautoinstall = g:GetLatestVimScripts_allowautoinstall
   endif
  else
   let aicmmnt= fname
  endif
"  call Decho("aicmmnt<".aicmmnt.">: doautoinstall=".doautoinstall)

  exe "norm z\<CR>"
  redraw!
"  call Decho('considering <'.aicmmnt.'> scriptid='.scriptid.' srcid='.srcid)
  echo 'considering <'.aicmmnt.'> scriptid='.scriptid.' srcid='.srcid

  " grab a copy of the plugin's vim.sourceforge.net webpage
  let scriptaddr = 'http://vim.sourceforge.net/script.php?script_id='.scriptid
  let tmpfile    = tempname()
  let v:errmsg   = ""

  " make up to three tries at downloading the description
  let itry= 1
  while itry <= 3
"   call Decho(".try#".itry." to download description of <".aicmmnt."> with addr=".scriptaddr)
   if has("win32") || has("win16") || has("win95")
"    call Decho(".new|exe silent r!".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(tmpfile).' '.shellescape(scriptaddr)."|bw!")
    new|exe "silent r!".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(tmpfile).' '.shellescape(scriptaddr)|bw!
   else
"    call Decho(".exe silent !".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(tmpfile)." ".shellescape(scriptaddr))
    exe "silent !".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(tmpfile)." ".shellescape(scriptaddr)
   endif
   if itry == 1
    exe "silent vsplit ".fnameescape(tmpfile)
   else
    silent! e %
   endif
   setlocal bh=wipe
  
   " find the latest source-id in the plugin's webpage
   silent! 1
   let findpkg= search('Click on the package to download','W')
   if findpkg > 0
    break
   endif
   let itry= itry + 1
  endwhile
"  call Decho(" --- end downloading tries while loop --- itry=".itry)

  " testing: did finding "Click on the package..." fail?
  if findpkg == 0 || itry >= 4
   silent q!
   call delete(tmpfile)
  " restore options
   let &t_ti        = t_ti
   let &t_te        = t_te
   let &rs          = rs
   let s:downerrors = s:downerrors + 1
"   call Decho("***warning*** couldn'".'t find "Click on the package..." in description page for <'.aicmmnt.">")
   echomsg "***warning*** couldn'".'t find "Click on the package..." in description page for <'.aicmmnt.">"
"   call Dret("GetOneScript : srch for /Click on the package/ failed")
   let @a= rega
   return
  endif
"  call Decho('found "Click on the package to download"')

  let findsrcid= search('src_id=','W')
  if findsrcid == 0
   silent q!
   call delete(tmpfile)
  " restore options
   let &t_ti        = t_ti
   let &t_te        = t_te
   let &rs          = rs
   let s:downerrors = s:downerrors + 1
"   call Decho("***warning*** couldn'".'t find "src_id=" in description page for <'.aicmmnt.">")
   echomsg "***warning*** couldn'".'t find "src_id=" in description page for <'.aicmmnt.">"
   let @a= rega
"  call Dret("GetOneScript : srch for /src_id/ failed")
   return
  endif
"  call Decho('found "src_id=" in description page')

  let srcidpat   = '^\s*<td class.*src_id=\(\d\+\)">\([^<]\+\)<.*$'
  let latestsrcid= substitute(getline("."),srcidpat,'\1','')
  let sname      = substitute(getline("."),srcidpat,'\2','') " script name actually downloaded
"  call Decho("srcidpat<".srcidpat."> latestsrcid<".latestsrcid."> sname<".sname.">")
  silent q!
  call delete(tmpfile)

  " convert the strings-of-numbers into numbers
  let srcid       = srcid       + 0
  let latestsrcid = latestsrcid + 0
"  call Decho("srcid=".srcid." latestsrcid=".latestsrcid." sname<".sname.">")

  " has the plugin's most-recent srcid increased, which indicates that it has been updated
  if latestsrcid > srcid
"   call Decho("[latestsrcid=".latestsrcid."] <= [srcid=".srcid."]: need to update <".sname.">")

   let s:downloads= s:downloads + 1
   if sname == bufname("%")
    " GetLatestVimScript has to be careful about downloading itself
    let sname= "NEW_".sname
   endif

   " -----------------------------------------------------------------------------
   " the plugin has been updated since we last obtained it, so download a new copy
   " -----------------------------------------------------------------------------
"   call Decho(".downloading new <".sname.">")
   echomsg ".downloading new <".sname.">"
   if has("win32") || has("win16") || has("win95")
"    call Decho(".new|exe silent r!".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(sname)." ".shellescape('http://vim.sourceforge.net/scripts/download_script.php?src_id='.latestsrcid)."|q")
    new|exe "silent r!".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(sname)." ".shellescape('http://vim.sourceforge.net/scripts/download_script.php?src_id='.latestsrcid)|q
   else
"    call Decho(".exe silent !".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(sname)." ".shellescape('http://vim.sourceforge.net/scripts/download_script.php?src_id='))
    exe "silent !".g:GetLatestVimScripts_wget." ".g:GetLatestVimScripts_options." ".shellescape(sname)." ".shellescape('http://vim.sourceforge.net/scripts/download_script.php?src_id=').latestsrcid
   endif

   " --------------------------------------------------------------------------
   " AutoInstall: only if doautoinstall has been requested by the plugin itself
   " --------------------------------------------------------------------------
"   call Decho("checking if plugin requested autoinstall: doautoinstall=".doautoinstall)
   if doautoinstall
"    call Decho(" ")
"    call Decho("Autoinstall: getcwd<".getcwd()."> filereadable(".sname.")=".filereadable(sname))
    if filereadable(sname)
"     call Decho("<".sname."> is readable")
"     call Decho("exe silent !".g:GetLatestVimScripts_mv." ".shellescape(sname)." ".shellescape(s:autoinstall))
     exe "silent !".g:GetLatestVimScripts_mv." ".shellescape(sname)." ".shellescape(s:autoinstall)
     let curdir    = fnameescape(substitute(getcwd(),'\','/','ge'))
     let installdir= curdir."/Installed"
     if !isdirectory(installdir)
      call mkdir(installdir)
     endif
"     call Decho("curdir<".curdir."> installdir<".installdir.">")
"     call Decho("exe cd ".fnameescape(s:autoinstall))
     exe "cd ".fnameescape(s:autoinstall)

     " determine target directory for moves
     let firstdir= substitute(&rtp,',.*$','','')
     let pname   = substitute(sname,'\..*','.vim','')
"     call Decho("determine tgtdir: is <".firstdir.'/AsNeeded/'.pname." readable?")
     if filereadable(firstdir.'/AsNeeded/'.pname)
      let tgtdir= "AsNeeded"
     else
      let tgtdir= "plugin"
     endif
"     call Decho("tgtdir<".tgtdir.">  pname<".pname.">")
     
     " decompress
     if sname =~ '\.bz2$'
"      call Decho("decompress: attempt to bunzip2 ".sname)
      exe "silent !bunzip2 ".shellescape(sname)
      let sname= substitute(sname,'\.bz2$','','')
"      call Decho("decompress: new sname<".sname."> after bunzip2")
     elseif sname =~ '\.gz$'
"      call Decho("decompress: attempt to gunzip ".sname)
      exe "silent !gunzip ".shellescape(sname)
      let sname= substitute(sname,'\.gz$','','')
"      call Decho("decompress: new sname<".sname."> after gunzip")
     elseif sname =~ '\.xz$'
"      call Decho("decompress: attempt to unxz ".sname)
      exe "silent !unxz ".shellescape(sname)
      let sname= substitute(sname,'\.xz$','','')
"      call Decho("decompress: new sname<".sname."> after unxz")
     else
"      call Decho("no decompression needed")
     endif
     
     " distribute archive(.zip, .tar, .vba) contents
     if sname =~ '\.zip$'
"      call Decho("dearchive: attempt to unzip ".sname)
      exe "silent !unzip -o ".shellescape(sname)
     elseif sname =~ '\.tar$'
"      call Decho("dearchive: attempt to untar ".sname)
      exe "silent !tar -xvf ".shellescape(sname)
     elseif sname =~ '\.vba$'
"      call Decho("dearchive: attempt to handle a vimball: ".sname)
      silent 1split
      if exists("g:vimball_home")
       let oldvimballhome= g:vimball_home
      endif
      let g:vimball_home= s:autoinstall
      exe "silent e ".fnameescape(sname)
      silent so %
      silent q
      if exists("oldvimballhome")
       let g:vimball_home= oldvimballhome
      else
       unlet g:vimball_home
      endif
     else
"      call Decho("no dearchiving needed")
     endif
     
     " ---------------------------------------------
     " move plugin to plugin/ or AsNeeded/ directory
     " ---------------------------------------------
     if sname =~ '.vim$'
"      call Decho("dearchive: attempt to simply move ".sname." to ".tgtdir)
      exe "silent !".g:GetLatestVimScripts_mv." ".shellescape(sname)." ".tgtdir
     else
"      call Decho("dearchive: move <".sname."> to installdir<".installdir.">")
      exe "silent !".g:GetLatestVimScripts_mv." ".shellescape(sname)." ".installdir
     endif
     if tgtdir != "plugin"
"      call Decho("exe silent !".g:GetLatestVimScripts_mv." plugin/".shellescape(pname)." ".tgtdir)
      exe "silent !".g:GetLatestVimScripts_mv." plugin/".shellescape(pname)." ".tgtdir
     endif
     
     " helptags step
     let docdir= substitute(&rtp,',.*','','e')."/doc"
"     call Decho("helptags: docdir<".docdir.">")
     exe "helptags ".fnameescape(docdir)
     exe "cd ".fnameescape(curdir)
    endif
    if fname !~ ':AutoInstall:'
     let modline=scriptid." ".latestsrcid." :AutoInstall: ".fname.cmmnt
    else
     let modline=scriptid." ".latestsrcid." ".fname.cmmnt
    endif
   else
    let modline=scriptid." ".latestsrcid." ".fname.cmmnt
   endif

   " update the data in the <GetLatestVimScripts.dat> file
   call setline(line("."),modline)
"   call Decho("update data in ".expand("%")."#".line(".").": modline<".modline.">")
"  else " Decho
"   call Decho("[latestsrcid=".latestsrcid."] <= [srcid=".srcid."], no need to update")
  endif

 " restore options
  let &t_ti = t_ti
  let &t_te = t_te
  let &rs   = rs
  let @a    = rega
"  call Dredir("BUFFER TEST (GetOneScript)","ls!")

"  call Dret("GetOneScript")
endfun

" ---------------------------------------------------------------------
" Restore Options: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=8 sts=2 fdm=marker nowrap
GetLatest/GetLatestVimScripts.dist	[[[1
18
ScriptID SourceID Filename
--------------------------
294  1 Align.vim
302  2 AnsiEsc.vim
122  3 astronaut.vim
104  4 blockhl.vim 
120  5 decho.vim
 40  6 DrawIt.tar.gz
451  7 EasyAccents.vim
195  8 engspchk.vim
642  9 GetLatestVimScripts.vim
489 10 Manpageview.vim
551 11 Mines.vim
514 12 mrswin.vim
670 13 visincr.vim
628 14 SeeTab.vim
508 15 ZoomWin.vim
877 16 gvcolor.vim
doc/pi_getscript.txt	[[[1
461
*pi_getscript.txt*  For Vim version 7.0.  Last change: 2011 May 31
>
		GETSCRIPT REFERENCE MANUAL  by Charles E. Campbell, Jr.
<
Authors:  Charles E. Campbell, Jr.  <NdrOchip@ScampbellPfamilyA.Mbiz>
	  (remove NOSPAM from the email address)
						*GetLatestVimScripts-copyright*
Copyright: (c) 2004-2010 by Charles E. Campbell, Jr.	*glvs-copyright*
           The VIM LICENSE applies to getscript.vim and
           pi_getscript.txt (see |copyright|) except use
           "getscript" instead of "Vim".  No warranty, express or implied.
	   Use At-Your-Own-Risk.

Getscript is a plugin that simplifies retrieval of the latest versions of the
scripts that you yourself use!  Typing |:GLVS| will invoke getscript; it will
then use the <GetLatestVimScripts.dat> (see |GetLatestVimScripts_dat|) file to
get the latest versions of scripts listed therein from http://vim.sf.net/.

==============================================================================
1. Contents				*glvs-contents* *glvs* *getscript*
   					*GetLatestVimScripts*

	1. Contents........................................: |glvs-contents|
	2. GetLatestVimScripts -- Getting Started..........: |glvs-install|
	3. GetLatestVimScripts Usage.......................: |glvs-usage|
	4. GetLatestVimScripts Data File...................: |glvs-data|
	5. GetLatestVimScripts Friendly Plugins............: |glvs-plugins|
	6. GetLatestVimScripts AutoInstall.................: |glvs-autoinstall|
	7. GetLatestViMScripts Options.....................: |glvs-options|
	8. GetLatestVimScripts Algorithm...................: |glvs-alg|
	9. GetLatestVimScripts History.....................: |glvs-hist|


==============================================================================
2. GetLatestVimScripts -- Getting Started		*getscript-start*
						*getlatestvimscripts-install*

	VERSION FROM VIM DISTRIBUTION			*glvs-dist-install*

Vim 7.0 does not include the GetLatestVimScripts.dist file which
serves as an example and a template.  So, you'll need to create
your own!  See |GetLatestVimScripts_dat|.

	VERSION FROM VIM SF NET				*glvs-install*

NOTE: The last step, that of renaming/moving the GetLatestVimScripts.dist
file, is for those who have just downloaded GetLatestVimScripts.tar.bz2 for
the first time.

The GetLatestVimScripts.dist file serves as an example and a template for your
own personal list.  Feel free to remove all the scripts mentioned within it;
the "important" part of it is the first two lines.

Your computer needs to have wget or curl for GetLatestVimScripts to do its work.

	1. if compressed:  gunzip getscript.vba.gz
	2. Unix:
		vim getscript.vba
		:so %
		:q
		cd ~/.vim/GetLatest
		mv GetLatestVimScripts.dist GetLatestVimScripts.dat
		(edit GetLatestVimScripts.dat to install your own personal
		list of desired plugins -- see |GetLatestVimScripts_dat|)
	
	3. Windows:
		vim getscript.vba
		:so %
		:q
		cd **path-to-vimfiles**/GetLatest
		mv GetLatestVimScripts.dist GetLatestVimScripts.dat
		(edit GetLatestVimScripts.dat to install your own personal
		list of desired plugins -- see |GetLatestVimScripts_dat|)


==============================================================================
3. GetLatestVimScripts Usage				*glvs-usage* *:GLVS*

Unless it has been defined elsewhere, >

	:GLVS

will invoke GetLatestVimScripts().  If some other plugin has defined that
command, then you may type
>
	:GetLatestVimScripts
<
The script will attempt to update and, if permitted, will automatically
install scripts from http://vim.sourceforge.net/.  To do so it will peruse a
file,
>
	.vim/GetLatest/GetLatestVimScripts.dat                    (unix)
<
or >
	..wherever..\vimfiles\GetLatest\GetLatestVimScripts.dat   (windows)
(see |glvs-data|), and examine plugins in your [.vim|vimfiles]/plugin
directory (see |glvs-plugins|).

Scripts which have been downloaded will appear in the
~/.vim/GetLatest (unix) or ..wherever..\vimfiles\GetLatest (windows)
subdirectory.  GetLatestVimScripts will attempt to automatically
install them if you have the following line in your <.vimrc>: >

	let g:GetLatestVimScripts_allowautoinstall=1

The <GetLatestVimScripts.dat> file will be automatically be updated to
reflect the latest version of script(s) so downloaded.
(also see |glvs-options|)


==============================================================================
4. GetLatestVimScripts Data File		*getscript-data* *glvs-data*
 						*:GetLatestVimScripts_dat*
The data file <GetLatestVimScripts.dat> must have for its first two lines
the following text:
>
	ScriptID SourceID Filename
	--------------------------
<
Following those two lines are three columns; the first two are numeric
followed by a text column.  The GetLatest/GetLatestVimScripts.dist file
contains an example of such a data file.  Anything following a #... is
ignored, so you may embed comments in the file.

The first number on each line gives the script's ScriptID.  When you're about
to use a web browser to look at scripts on http://vim.sf.net/, just before you
click on the script's link, you'll see a line resembling

	http://vim.sourceforge.net/scripts/script.php?script_id=40

The "40" happens to be a ScriptID that GetLatestVimScripts needs to
download the associated page, and is assigned by vim.sf.net itself
during initial uploading of the plugin.

The second number on each line gives the script's SourceID.  The SourceID
records the count of uploaded scripts as determined by vim.sf.net; hence it
serves to indicate "when" a script was uploaded.  Setting the SourceID to 1
insures that GetLatestVimScripts will assume that the script it has is
out-of-date.

The SourceID is extracted by GetLatestVimScripts from the script's page on
vim.sf.net; whenever it is greater than the one stored in the
GetLatestVimScripts.dat file, the script will be downloaded
(see |GetLatestVimScripts_dat|).

If your script's author has included a special comment line in his/her plugin,
the plugin itself will be used by GetLatestVimScripts to build your
<GetLatestVimScripts.dat> file, including any dependencies on other scripts it
may have.  As an example, consider: >

	" GetLatestVimScripts: 884  1 :AutoInstall: AutoAlign.vim

This comment line tells getscript.vim to check vimscript #884 and that the
script is automatically installable.  Getscript will also use this line to
help build the GetLatestVimScripts.dat file, by including a line such as: >

	884 1 :AutoInstall: AutoAlign.vim
<
assuming that such a line isn't already in GetLatestVimScripts.dat file.
See |glvs-plugins| for more.  Thus, GetLatestVimScripts thus provides a
comprehensive ability to keep your plugins up-to-date!

In summary:

  * Optionally tell getscript that it is allowed to build/append a
    GetLatestVimScripts.dat file based upon already installed plugins: >
	let g:GetLatestVimScripts_allowautoinstall=1
<
  * A line such as >
	" GetLatestVimScripts: 884  1 :AutoInstall: AutoAlign.vim
<   in an already-downloaded plugin constitutes the concurrence of the
    plugin author that getscript may do AutoInstall.  Not all plugins
    may be AutoInstall-able, and the plugin's author is best situated
    to know whether or not his/her plugin will AutoInstall properly.

  * A line such as >
	884 1 :AutoInstall: AutoAlign.vim
<   in your GetLatestVimScripts.dat file constitutes your permission
    to getscript to do AutoInstall.  AutoInstall requires both your
    and the plugin author's permission.  See |GetLatestVimScripts_dat|.


						*GetLatestVimScripts_dat*
As an example of a <GetLatestVimScripts.dat> file:
>
    ScriptID SourceID Filename
    --------------------------
    294 1 :AutoInstall: Align.vim
    120 2 Decho.vim
     40 3 DrawIt.tar.gz
    451 4 EasyAccents.vim
    195 5 engspchk.vim
    642 6 GetLatestVimScripts.vim
    489 7 Manpageview.vim
<
Note: the first two lines are required, but essentially act as comments.


==============================================================================
5. GetLatestVimScripts Friendly Plugins	*getscript-plugins* *glvs-plugins*

		(this section is for plugin authors)~

If a plugin author includes the following comment anywhere in their plugin,
GetLatestVimScripts will find it and use it to automatically build the user's
GetLatestVimScripts.dat files:
>
	                         src_id
	                            v
	" GetLatestVimScripts: ### ### yourscriptname
	                        ^
	                    scriptid
<
As an author, you should include such a line in to refer to your own script
plus any additional lines describing any plugin dependencies it may have.
Same format, of course!

If your command is auto-installable (see |glvs-autoinstall|), and most scripts
are, then you may include :AutoInstall: just before "yourscriptname":
>
	                         src_id
	                            v
	" GetLatestVimScripts: ### ### :AutoInstall: yourscriptname
	                        ^
	                    scriptid
<
NOTE: The :AutoInstall: feature requires both the plugin author's and~
      the user's permission to operate!~

GetLatestVimScripts commands for those scripts are then appended, if not
already present, to the user's GetLatest/GetLatestVimScripts.dat file.  It is
a relatively painless way to automate the acquisition of any scripts your
plugins depend upon.

Now, as an author, you probably don't want GetLatestVimScripts to download
your own scripts atop your own copy, thereby overwriting your not-yet-released
hard work.  GetLatestVimScripts provides a solution for this:  put
>
	0 0 yourscriptname
<
into your <GetLatestVimScripts.dat> file and GetLatestVimScripts will skip
examining the "yourscriptname" scripts for those GetLatestVimScripts comment
lines.  As a result, those lines won't be inadvertently installed into your
<GetLatestVimScripts.dat> file and subsequently used to download your own
scripts.  This is especially important to do if you've included the
:AutoInstall: option.

Be certain to use the same "yourscriptname" in the "0 0 yourscriptname" line
as you've used in your GetLatestVimScripts comment!


==============================================================================
6. GetLatestVimScripts AutoInstall			*getscript-autoinstall*
							*glvs-autoinstall*

GetLatestVimScripts now supports "AutoInstall".  Not all scripts are
supportive of auto-install, as they may have special things you need to do to
install them (please refer to the script's "install" directions).  On the
other hand, most scripts will be auto-installable.

To let GetLatestVimScripts do an autoinstall, the data file's comment field
should begin with (surrounding blanks are ignored): >

	:AutoInstall:
<
Both colons are needed, and it should begin the comment (yourscriptname)
field.

One may prevent any autoinstalling by putting the following line in your
<.vimrc>: >

	let g:GetLatestVimScripts_allowautoinstall= 0
<
With :AutoInstall: enabled, as it is by default, files which end with

	---.tar.bz2  : decompressed & untarred in .vim/ directory
	---.vba.bz2  : decompressed in .vim/ directory, then vimball handles it
	---.vim.bz2  : decompressed & moved into .vim/plugin directory
	---.tar.gz   : decompressed & untarred in .vim/ directory
	---.vba.gz   : decompressed in .vim/ directory, then vimball handles it
	---.vim.gz   : decompressed & moved into .vim/plugin directory
	---.vba      : unzipped in .vim/ directory
	---.vim      : moved to .vim/plugin directory
	---.zip      : unzipped in .vim/ directory

and which merely need to have their components placed by the untar/gunzip or
move-to-plugin-directory process should be auto-installable.  Vimballs, of
course, should always be auto-installable.

When is a script not auto-installable?  Let me give an example:

	.vim/after/syntax/blockhl.vim

The <blockhl.vim> script provides block highlighting for C/C++ programs; it is
available at:

	http://vim.sourceforge.net/scripts/script.php?script_id=104

Currently, vim's after/syntax only supports by-filetype scripts (in
blockhl.vim's case, that's after/syntax/c.vim).  Hence, auto-install would
possibly overwrite the current user's after/syntax/c.vim file.

In my own case, I use <aftersyntax.vim> (renamed to after/syntax/c.vim) to
allow a after/syntax/c/ directory:

	http://vim.sourceforge.net/scripts/script.php?script_id=1023

The script allows multiple syntax files to exist separately in the
after/syntax/c subdirectory.  I can't bundle aftersyntax.vim in and build an
appropriate tarball for auto-install because of the potential for the
after/syntax/c.vim contained in it to overwrite a user's c.vim.


==============================================================================
7. GetLatestVimScripts Options					*glvs-options*
>
	g:GetLatestVimScripts_wget
<	default= "wget"
		This variable holds the name of the command for obtaining
		scripts.
>
	g:GetLatestVimScripts_options
<	default= "-q -O"
		This variable holds the options to be used with the
		g:GetLatestVimScripts_wget command.
>
 	g:GetLatestVimScripts_allowautoinstall
<	default= 1
		This variable indicates whether GetLatestVimScripts is allowed
		to attempt to automatically install scripts.  Furthermore, the
		plugin author has to have explicitly indicated that his/her
		plugin is automatically installable (via the :AutoInstall:
		keyword in the GetLatestVimScripts comment line).
>
	g:GetLatestVimScripts_autoinstalldir
<	default= $HOME/.vim     (linux)
	default= $HOME/vimfiles (windows)
		Override where :AutoInstall: scripts will be installed.
		Doesn't override vimball installation.

==============================================================================
8. GetLatestVimScripts Algorithm		*glvs-algorithm* *glvs-alg*

The Vim sourceforge page dynamically creates a page by keying off of the
so-called script-id.  Within the webpage of

	http://vim.sourceforge.net/scripts/script.php?script_id=40

is a line specifying the latest source-id (src_id).  The source identifier
numbers are always increasing, hence if the src_id is greater than the one
recorded for the script in GetLatestVimScripts then it's time to download a
newer copy of that script.

GetLatestVimScripts will then download the script and update its internal
database of script ids, source ids, and scriptnames.

The AutoInstall process will:

	Move the file from GetLatest/ to the following directory
		Unix   : $HOME/.vim
		Windows: $HOME\vimfiles
	if the downloaded file ends with ".bz2"
		bunzip2 it
	else if the downloaded file ends with ".gz"
		gunzip it
	if the resulting file ends with ".zip"
		unzip it
	else if the resulting file ends with ".tar"
		tar -oxvf it
	else if the resulting file ends with ".vim"
		move it to the plugin subdirectory


==============================================================================
9. GetLatestVimScripts History		*getscript-history* *glvs-hist* {{{1

v33 May 31, 2011 : * using fnameescape() instead of escape()
		   * *.xz support
v32 Jun 19, 2010 : * (Jan Steffens) added support for xz compression
v31 Jun 29, 2008 : * (Bill McCarthy) fixed having hls enabled with getscript
		   * (David Schaefer) the acd option interferes with vimballs
		     Solution: bypass the acd option
v30 Jun 13, 2008 : * GLVS now checks for existence of fnameescape() and will
		     issue an error message if it is not supported
v29 Jan 07, 2008 : * Bram M pointed out that cpo is a global option and that
                     getscriptPlugin.vim was setting it but not restoring it.
v28 Jan 02, 2008 : * improved shell quoting character handling, cygwin
		     interface, register-a bypass
    Oct 29, 2007   * Bill McCarthy suggested a change to getscript that avoids
                     creating pop-up windows
v24 Apr 16, 2007 : * removed save&restore of the fo option during script
                     loading
v23 Nov 03, 2006 : * ignores comments (#...)
                   * handles vimballs
v22 Oct 13, 2006 : * supports automatic use of curl if wget is not
                     available
v21 May 01, 2006 : * now takes advantage of autoloading.
v20 Dec 23, 2005 : * Eric Haarbauer found&fixed a bug with unzip use;
                     unzip needs the -o flag to overwrite.
v19 Nov 28, 2005 : * v18's GetLatestVimScript line accessed the wrong
                     script! Fixed.
v18 Mar 21, 2005 : * bugfix to automatic database construction
                   * bugfix - nowrapscan caused an error
                     (tnx to David Green for the fix)
    Apr 01, 2005   * if shell is bash, "mv" instead of "ren" used in
                     :AutoInstall:s, even though its o/s is windows
    Apr 01, 2005   * when downloading errors occurred, GLVS was
                     terminating early.  It now just goes on to trying
                     the next script (after trying three times to
                     download a script description page)
    Apr 20, 2005   * bugfix - when a failure to download occurred,
                     GetLatestVimScripts would stop early and claim that
                     everything was current.  Fixed.
v17 Aug 25, 2004 : * g:GetLatestVimScripts_allowautoinstall, which
                     defaults to 1, can be used to prevent all
                     :AutoInstall:
v16 Aug 25, 2004 : * made execution of bunzip2/gunzip/tar/zip silent
                   * fixed bug with :AutoInstall: use of helptags
v15 Aug 24, 2004 : * bugfix: the "0 0 comment" download prevention wasn't
                     always preventing downloads (just usually).  Fixed.
v14 Aug 24, 2004 : * bugfix -- helptags was using dotvim, rather than
                     s:dotvim.  Fixed.
v13 Aug 23, 2004 : * will skip downloading a file if its scriptid or srcid
                     is zero.  Useful for script authors; that way their
                     own GetLatestVimScripts activity won't overwrite
                     their scripts.
v12 Aug 23, 2004 : * bugfix - a "return" got left in the distribution that
                     was intended only for testing.  Removed, now works.
                   * :AutoInstall: implemented
v11 Aug 20, 2004 : * GetLatestVimScripts is now a plugin:
                   * :GetLatestVimScripts command
                   * (runtimepath)/GetLatest/GetLatestVimScripts.dat
                     now holds scripts that need updating
v10 Apr 19, 2004 : * moved history from script to doc
v9  Jan 23, 2004 :   windows (win32/win16/win95) will use
                     double quotes ("") whereas other systems will use
                     single quotes ('') around the urls in calls via wget
v8  Dec 01, 2003 :   makes three tries at downloading
v7  Sep 02, 2003 :   added error messages if "Click on..." or "src_id="
                     not found in downloaded webpage
                     Uses t_ti, t_te, and rs to make progress visible
v6  Aug 06, 2003 :   final status messages now display summary of work
                     ( "Downloaded someqty scripts" or
                       "Everything was current")
                     Now GetLatestVimScripts is careful about downloading
                     GetLatestVimScripts.vim itself!
                     (goes to <NEW_GetLatestVimScripts.vim>)
v5  Aug 04, 2003 :   missing an endif near bottom
v4  Jun 17, 2003 :   redraw! just before each "considering" message
v3  May 27, 2003 :   Protects downloaded files from errant shell
                     expansions with single quotes: '...'
v2  May 14, 2003 :   extracts name of item to be obtained from the
                     script file.  Uses it instead of comment field
                     for output filename; comment is used in the
                     "considering..." line and is now just a comment!
                   * Fixed a bug: a string-of-numbers is not the
                     same as a number, so I added zero to them
                     and they became numbers.  Fixes comparison.

==============================================================================
vim:tw=78:ts=8:ft=help:fdm=marker
