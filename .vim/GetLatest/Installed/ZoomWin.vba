" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
plugin/ZoomWinPlugin.vim	[[[1
49
" ZoomWin:	Brief-like ability to zoom into/out-of a window
" Author:	Charles Campbell
"			original version by Ron Aaron
" Date:		Apr 07, 2011
" Version:	24iNR	NOT RELEASED
" History: see :help zoomwin-history {{{1
" GetLatestVimScripts: 508 1 :AutoInstall: ZoomWin.vim

" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_ZoomWinPlugin")
 finish
endif
if v:version < 702
 echohl WarningMsg
 echo "***warning*** this version of ZoomWin needs vim 7.2"
 echohl Normal
 finish
endif
let s:keepcpo              = &cpo
let g:loaded_ZoomWinPlugin = "v24"
set cpo&vim
"DechoTabOn

" ---------------------------------------------------------------------
"  Public Interface: {{{1
if !hasmapto("<Plug>ZoomWin")
 nmap <unique> <c-w>o  <Plug>ZoomWin
endif
nnoremap <silent> <script> <Plug>ZoomWin :set lz<CR>:silent call ZoomWin#ZoomWin()<CR>:set nolz<CR>
com! ZoomWin :set lz|silent call ZoomWin#ZoomWin()|set nolz

au VimLeave * call ZoomWin#CleanupSessionFile()

" ---------------------------------------------------------------------
" ZoomWin: toggles between a single-window and a multi-window layout {{{1
"          The original version was by Ron Aaron.
"          This function provides compatibility with previous versions.
fun! ZoomWin()
  call ZoomWin#ZoomWin()
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
doc/ZoomWin.txt	[[[1
173
*ZoomWin.txt*	Zoom into/out-of a window		Jun 18, 2012
Authors: Charles E. Campbell, Jr.			*zoomwin*
         Ron Aaron
Copyright: (c) 2004-2012 by Charles E. Campbell, Jr.	*zoomwin-copyright*
           The VIM LICENSE applies to ZoomWin.vim and ZoomWin.txt
           (see |copyright|) except use "ZoomWin" instead of "Vim"
	   No warranty, express or implied.  Use At-Your-Own-Risk.

==============================================================================
1. Usage						*zoomwin-usage*

   :call ZoomWin()
   :ZoomWin
   <c-w>o

   Either of the two commands or the normal mode <c-w>o will toggle between
	* selecting the current window for display as the only window or
	* restoring the original multiple-window view.


==============================================================================
2. Setup						*zoomwin-setup*

   ZoomWin comes as a vimball; to install it, simply >

       vim ZoomWin.vba.gz
       :so %
       :q
<
   Your .vimrc needs to have, at least: >

   	set nocp
	filetype plugin on
<
   (see |'nocp'|, |:filetype|, and |filetype-plugin-on| for an explanation of
   these commands)

==============================================================================
3. Options						*zoomwin-options*

   *g:ZoomWin_funcref* : this variable is used as a function reference
			 (|Funcref|) or as a |List| of function references.
			 It is called with a single argument: >
			   0 : multi-window display; not zoomed in
			   1 : single-window display; zoomed in
<			 What this does is permits ZoomWin users to have a
			 function called whenever ZoomWin changes state.
			 As an example, consider having the status line
			 indicate whether one is ZoomWin'd in or not: >
			    set stl=Normal
			    fun! ZWStatline(state)
			      if a:state
			       set stl=ZoomWin
			      else
			       set stl=Normal
			      endif
			    endfun
			    if !exists("g:ZoomWin_funcref")
			     let g:ZoomWin_funcref= function("ZWStatline")
			    endif
<			 The function, ZWStatline(), is called by ZoomWin()
			 every time it changes state.

	*g:zoomwin_preserve_taglist*	open and close a taglist window on
	                              zooms

	*g:zoomwin_preserve_winmanager*	open and close winmanager a window on
	                              zooms
			

==============================================================================
4. History						*zoomwin-history*

	v24 Jan 29, 2009 : * |g:ZoomWin_funcref| supported
	    May 22, 2009   * supports the saving and restoring of window
			     variables across zooms
	    Oct 11, 2009   * The state wasn't being passed along to
			     g:ZoomWin_funcref as intended.  Fixed.
	    Jul 09, 2010   * Put an exists() test into s:RestoreWinVars()
	    Jan 18, 2011   * (reported by talek) bypass winfixheight option
	    Apr 06, 2011   * Saves and restores local options for every window
	v23 Apr 24, 2008 : * when |'scrollbind'| was activated: when ZoomWin
			     attempted to restore multiple-windows, the cursor
			     position was incorrect.  Fixed.
	    Jan 02, 2009   * included some more things in the session file
	                   * broke ZoomWin into an plugin + autoload pair
			   * (Ingo Karkat) contributed a patch to retain the
			     the search pattern before zooming
			   * (Ingo Karkat) contributed a patch to detect the
			     vim 7.2 name for the command line window
			   * too many files (more than the screen rows)
			     caused restoration problems.
	v22 Apr 10, 2006 : * "only" was occasionally issuing an "Already one
	                     window" message, which is now prevented
			   * SavePosn() issued error message when handling an
			     empty buffer
			   * saves yank registers and restores them on each
			     zoom/unzoom
	v21 Oct 12, 2004 : * v14 fixed a bug when wmw and/or wmv equal to 0;
			     v21 will invoke the patch only if the version <= 603.
			     For vim version 6.3 users, this fix allows more files
			     to be handled by ZoomWin.
	    May 10, 2005   * When :version shows -mksession, and the vim version
			     is at least 6.3, ZoomWin will now do a partial zoom
	v20 Jul 26, 2004 : * bugfix - ZoomWin didn't always retain the
			     position in the former zoomed-in window after
			     the window layout was restored.  It was restoring
			     the position when the zoom-in occurred.
	v19 May 26, 2004 : * bugfix - winmanager has events firing that,
	                     amongst other things, reset the bufhidden
			     option to delete for some windows while
			     ZoomWin worked.  ZoomWin now works
			     successfully with winmanager.
	v18 May 20, 2004 : * bugfix - didn't adversely affect anything, but
	                     ZoomWin was deleting its session file twice.
			   * bugfix -- a multi-source file + minibufexplorer
			     + Taglist interaction bug -- minibufexplorer's
			     autocmd events were firing, generating a new
			     window while ZoomWin was attempting to restore
			     the display.  ZoomWin didn't have restoration
			     information for the new window and so reported
			     an error.  Events are now temporarily disabled
			     while ZoomWin is restoring the layout.
	v17 Mar 26, 2004 : * ZoomWin command installed.  Works nicely with
	                     taglist:  vim +Tlist +ZoomWin filename
	v16 Dec 22, 2003 : * handles bufhidden and nobl windows (TagList support).
	                   * Now also works with quickfix window (:copen) but
			     still not with |cmdline-window| (q:)
	v15 Dec 19, 2003 : * SavePosn()/RestorePosn() needed to be preceded
	                     by s: to prevent clashes
	v14 Dec 18, 2003 : * works around a restoration-bug with mksession
			     when either wmw or wmh settings are zero
			   * Bwipes internal temporary buffers
			   * Known bugs: will not work with command-line
			   * Editing window (|cmdline-window|) nor the
			     quickfix window (|copen|).
	v13 Dec 18, 2003 : Uses eventignore to prevent events/autocmds from
			    firing while changing the mksession results.
	v12 Dec 12, 2003 : uses hidden and a minimalist mksession save
	v11 Oct 14, 2003 : bug fix: apparently RestorePosn()'s variables,
			    which were b:, weren't always defined, so s:
			    ones are now used.
	v10 Sep 22, 2003 : Bug fix: when a single window is showing, the user
			    moves the cursor, then <c-w>o used to restore
			    screen, the current cursor position wasn't retained
			   Restores v:this_session.
			   Bug fix: change a window, use <c-w>o, then write.
			   Was saving file only to temporary file instead of
			    actual file, but when the actual file was brought back,
			    the changes were lost.
	v9 Aug 15, 2003 :  v8 managed to trash syntax highlighting on
			   reload, this one removes the eventignore
			   handling.  Will need more pondering...
	v8 Aug 14, 2003 :  now handles not-modified but not filereadable
			   buffers, nowrite buffers uses eventignore to
			   bypass autocmd firing
	v7 May 23, 2003 :  bugfix - GotoWinNum() didn't always get the
			   cursor into the correct window
	v6 Mar 25, 2003 :  more cleanup included
	v5 Mar 14, 2003 :  includes support for handling scratch buffers,
			   no-name buffer windows, and modified-buffer
			   windows.  All windows' contents will be saved to
			   temporary buffers
	v4 Dec 12, 2002 :  Zak Beck contributed code to clean up temporary
			   session files if one leaves vim while zoomed-in
	v3 Dec 11, 2002 :  plugin-ized
	v2 Nov 08, 2002 :  A guaranteed-to-be-unique to this
			   session file is used for session information.
			   Modified but not yet saved files are made hidden
			   during zoom in.
	v1 the epoch    :  Ron Aaron's original

vim:tw=78:ts=8:ft=help
autoload/ZoomWin.vim	[[[1
526
" ZoomWin:	Brief-like ability to zoom into/out-of a window
" Author:	Charles Campbell
"			original version by Ron Aaron
" Date:		Jun 18, 2012 
" Version:	24
" History: see :help zoomwin-history {{{1
" GetLatestVimScripts: 508 1 :AutoInstall: ZoomWin.vim

" ---------------------------------------------------------------------
" Load Once: {{{1
if &cp || exists("g:loaded_ZoomWin")
 finish
endif
if v:version < 702
 echohl WarningMsg
 echo "***warning*** this version of ZoomWin needs vim 7.2"
 echohl Normal
 finish
endif
let s:keepcpo        = &cpo
let g:loaded_ZoomWin = "v24"
let s:localoptlist   = ["ai","ar","bh","bin","bl","bomb","bt","cfu","ci","cin","cink","cino","cinw","cms","com","cpt","efm","eol","ep","et","fenc","fex","ff","flp","fo","ft","gp","imi","ims","inde","inex","indk","inf","isk","key","kmp","lisp","mps","ml","ma","mod","nf","ofu","oft","pi","qe","ro","sw","sn","si","sts","spc","spf","spl","sua","swf","smc","syn","ts","tx","tw","udf","wm"]
set cpo&vim
"DechoTabOn

" =====================================================================
"  Functions: {{{1

" ---------------------------------------------------------------------
" ZoomWin#ZoomWin: toggles between a single-window and a multi-window layout {{{2
"          The original version was by Ron Aaron.
fun! ZoomWin#ZoomWin()
"  let g:decho_hide= 1		"Decho
  let lzkeep = &lz
  set lz
"  call Dfunc("ZoomWin#ZoomWin() winbufnr(2)=".winbufnr(2))

  " if the vim doesn't have +mksession, only a partial zoom is available {{{3
  if !has("mksession")
   if !exists("s:partialzoom")
    echomsg "missing the +mksession feature; only a partial zoom is available"
	let s:partialzoom= 0
   endif
   if v:version < 630
   	echoerr "***sorry*** you need an updated vim, preferably with +mksession"
   elseif s:partialzoom
   	" partial zoom out
	let s:partialzoom= 0
	exe s:winrestore
   else
   	" partial zoom in
	let s:partialzoom= 1
	let s:winrestore = winrestcmd()
	res
   endif
   let &lz = lzkeep
"   call Dret("ZoomWin#ZoomWin : partialzoom=".s:partialzoom)
   return
  endif

  " Close certain windows and save user settings {{{3
  call s:ZoomWinPreserve(0)
  call s:SaveUserSettings()

  if winbufnr(2) == -1
    " there's only one window - restore to multiple-windows mode {{{3
"	call Decho("there's only one window - restore to multiple windows")

    if exists("s:sessionfile") && filereadable(s:sessionfile)
	  " save position in current one-window-only
"	  call Decho("save position in current one-window-only in sponly  (s:sessionfile<".s:sessionfile.">)")
      let sponly     = s:SavePosn(0)
      let s:origline = line(".")
      let s:origcol  = virtcol(".")
	  let s:swv      = deepcopy(getwinvar(winnr(),""),1)
	  sil! unlet key value
	  for [key,value] in items(s:swv)
	   exe "sil! unlet w:".key
	   sil! unlet key value
	  endfor

      " source session file to restore window layout
	  let ei_keep = &ei
	  set ei=all noswf
	  exe 'sil! so '.fnameescape(s:sessionfile)
      let v:this_session= s:sesskeep
	  " restore any and all window variables
	  call s:RestoreWinVars()

      if exists("s:savedposn1")
        " restore windows' positioning and buffers
"		call Decho("restore windows, positions, buffers")
        windo call s:RestorePosn(s:savedposn{winnr()})|unlet s:savedposn{winnr()}
        call s:GotoWinNum(s:winkeep)
        unlet s:winkeep
      endif

	  if exists("s:swv")
	   " restore possibly modified while in one-window mode, window variables
       for [key,value] in items(s:swv)
		sil! call setwinvar(winnr(),key,value)
		sil! unlet key value
	   endfor
	  endif

	  if line(".") != s:origline || virtcol(".") != s:origcol
	   " If the cursor hasn't moved from the original position,
	   " then let the position remain what it was in the original
	   " multi-window layout.
"	   call Decho("restore position using sponly")
       call s:RestorePosn(sponly)
	  endif

	  " delete session file and variable holding its name
"	  call Decho("delete session file")
      call delete(s:sessionfile)
      unlet s:sessionfile
	  let &ei  = ei_keep
    endif

	" I don't know why -- but netrw-generated windows end up as [Scratch] even though the bufname is correct.
	" Following code fixes this.
	let curwin= winnr()
	windo exe "sil! file ".fnameescape(bufname(winbufnr(winnr())))
	exe curwin."wincmd w"

	" Restore local window settings
	call s:RestoreWinSettings()

	" zoomwinstate used by g:ZoomWin_funcref()
	let zoomwinstate= 0

  else " there's more than one window - go to only-one-window mode {{{3
"	call Decho("there's multiple windows - goto one-window-only")

    let s:winkeep    = winnr()
    let s:sesskeep   = v:this_session

	" doesn't work with the command line window (normal mode q:)
 	if &bt == "nofile" && expand("%") == (v:version < 702 ? 'command-line' : '[Command Line]')
	 echoerr "***error*** ZoomWin#ZoomWin doesn't work with the ".expand("%")." window"
     let &lz= lzkeep
"     call Dret("ZoomWin#ZoomWin : ".expand('%')." window error")
	 return
	endif

	" disable all events (autocmds)
"	call Decho("disable events")
    let ei_keep= &ei
	set ei=all

	" Save local window settings
	call s:SaveWinSettings()

	" save all window variables
	call s:SaveWinVars()

    " save window positioning commands
"	call Decho("save window positioning commands")
    windo let s:savedposn{winnr()}= s:SavePosn(1)
    call s:GotoWinNum(s:winkeep)

    " set up name of session file
    let s:sessionfile= tempname()

    " save session
"	call Decho("save session")
    let ssop_keep = &ssop
	let &ssop     = 'blank,help,winsize,folds,globals,localoptions,options'
	exe 'mksession! '.fnameescape(s:sessionfile)
	let keepyy= @@
	let keepy0= @0
	let keepy1= @1
	let keepy2= @2
	let keepy3= @3
	let keepy4= @4
	let keepy5= @5
	let keepy6= @6
	let keepy7= @7
	let keepy8= @8
	let keepy9= @9
    set lz ei=all bh=
	if v:version >= 700
	 try
	  exe "keepalt keepmarks new! ".fnameescape(s:sessionfile)
	 catch /^Vim\%((\a\+)\)\=:E/
	  echoerr "Too many windows"
      sil! call delete(s:sessionfile)
      unlet s:sessionfile
      let &lz= lzkeep
"      call Dret("ZoomWin#ZoomWin : too many windows")
      return
	 endtry
     sil! keepjumps keepmarks v/wincmd\|split\|resize/d
     keepalt w!
     keepalt bw!
	else
	 exe "new! ".fnameescape(s:sessionfile)
     v/wincmd\|split\|resize/d
     w!
     bw!
    endif
	let @@= keepyy
	let @0= keepy0
	let @1= keepy1
	let @2= keepy2
	let @3= keepy3
	let @4= keepy4
	let @5= keepy5
	let @6= keepy6
	let @7= keepy7
	let @8= keepy8
	let @9= keepy9
    call histdel('search', -1)
    let @/ = histget('search', -1)

    " restore user's session options and restore event handling
"	call Decho("restore user session options and event handling")
    set nolz
    let &ssop = ssop_keep
	let curwin= winnr()
    sil! only!
    let &ei   = ei_keep
    echomsg expand("%")
	call s:RestoreOneWinSettings(curwin)

	" zoomwinstate used by g:ZoomWin_funcref()
	let zoomwinstate= 1
  endif

  " restore user option settings {{{3
  call s:RestoreUserSettings()

  " Re-open certain windows {{{3
  call s:ZoomWinPreserve(1)
  
  " call user's optional funcref (callback) functions
  if exists("g:ZoomWin_funcref")
   if type(g:ZoomWin_funcref) == 2
	call g:ZoomWin_funcref(zoomwinstate)
   elseif type(g:ZoomWin_funcref) == 3
    for Fncref in g:ZoomWin_funcref
     if type(FncRef) == 2
	  call FncRef(zoomwinstate)
     endif
    endfor
   endif
  endif

  let &lz= lzkeep
"  call Dret("ZoomWin#ZoomWin")
endfun

" ---------------------------------------------------------------------
" SavePosn: this function sets up a savedposn variable that {{{2
"          has the commands necessary to restore the view
"          of the current window.
fun! s:SavePosn(savewinhoriz)
"  call Dfunc("SavePosn(savewinhoriz=".a:savewinhoriz.") file<".expand("%").">")
  let swline = line(".")
  if swline == 1 && getline(1) == ""
   " empty buffer
   let savedposn= "silent b ".winbufnr(0)
"   call Dret("SavePosn savedposn<".savedposn.">")
   return savedposn
  endif
  let swcol = col(".")
  if swcol >= col("$")
   let swcol= swcol + virtcol(".") - virtcol("$")  " adjust for virtual edit (cursor past end-of-line)
  endif
  let swwline   = winline()-1
  let swwcol    = virtcol(".") - wincol()
"  call Decho("swline #".swline)
"  call Decho("swcol  #".swcol)
"  call Decho("swwline#".swwline)
"  call Decho("swwcol #".swwcol)

  let savedposn = "silent b ".winbufnr(0)
  let savedposn = savedposn."|".swline
  let savedposn = savedposn."|sil! norm! 0z\<cr>"
  if swwline > 0
   let savedposn= savedposn.":sil! norm! ".swwline."\<c-y>\<cr>"
  endif

  if a:savewinhoriz
   if swwcol > 0
    let savedposn= savedposn.":sil! norm! 0".swwcol."zl\<cr>"
   endif
   let savedposn= savedposn.":sil! call cursor(".swline.",".swcol.")\<cr>"

   " handle certain special settings for the multi-window savedposn call
   "   bufhidden buftype buflisted
   let settings= ""
   if &bh != ""
   	let settings="bh=".&bh
	setlocal bh=hide
   endif
   if !&bl
   	let settings= settings." nobl"
	setlocal bl
   endif
   if &bt != ""
   	let settings= settings." bt=".&bt
	setlocal bt=
   endif
   if settings != ""
   	let savedposn= savedposn.":setlocal ".settings."\<cr>"
   endif

  else
   let savedposn= savedposn.":sil! call cursor(".swline.",".swcol.")\<cr>"
  endif
"  call Dret("SavePosn savedposn<".savedposn.">")
  return savedposn
endfun

" ---------------------------------------------------------------------
" s:RestorePosn: this function restores noname and scratch windows {{{2
fun! s:RestorePosn(savedposn)
"  call Dfunc("RestorePosn(savedposn<".a:savedposn.">)")
  if &scb
   setlocal noscb
   exe a:savedposn
   setlocal scb
  else
   exe a:savedposn
  endif
"  call Dret("RestorePosn")
endfun

" ---------------------------------------------------------------------
" CleanupSessionFile: if you exit Vim before cleaning up the {{{2
"                     supposed-to-be temporary session file
fun! ZoomWin#CleanupSessionFile()
"  call Dfunc("ZoomWin#CleanupSessionFile()")
  if exists("s:sessionfile") && filereadable(s:sessionfile)
"   call Decho("sessionfile exists and is readable; deleting it")
   sil! call delete(s:sessionfile)
   unlet s:sessionfile
  endif
"  call Dret("ZoomWin#CleanupSessionFile")
endfun

" ---------------------------------------------------------------------
" GotoWinNum: this function puts cursor into specified window {{{2
fun! s:GotoWinNum(winnum)
"  call Dfunc("GotoWinNum(winnum=".a:winnum.") winnr=".winnr())
  if a:winnum != winnr()
   exe a:winnum."wincmd w"
  endif
"  call Dret("GotoWinNum")
endfun


" ---------------------------------------------------------------------
" ZoomWinPreserve:  This function, largely written by David Fishburn, {{{2
"   allows ZoomWin to "preserve" certain windows:
"
"   	TagList, by Yegappan Lakshmanan
"   	  http://vim.sourceforge.net/scripts/script.php?script_id=273
"
"   	WinManager, by Srinath Avadhanula
"   	  http://vim.sourceforge.net/scripts/script.php?script_id=95
"
"  It does so by closing the associated window upon entry to ZoomWin
"  and re-opening it upon exit by using commands provided by the
"  utilities themselves.
fun! s:ZoomWinPreserve(open)
"  call Dfunc("ZoomWinPreserve(open=".a:open.")")

  if a:open == 0

   " Close Taglist
   if exists('g:zoomwin_preserve_taglist') && exists('g:loaded_taglist')
       " If taglist window is open then close it.
       let s:taglist_winnum = bufwinnr(g:TagList_title)
       if s:taglist_winnum != -1
           " Close the window
           exec "sil! Tlist"
       endif
   endif

   " Close Winmanager
   if exists('g:zoomwin_preserve_winmanager') && exists('g:loaded_winmanager')
       " If the winmanager window is open then close it.
       let s:is_winmgr_vis = IsWinManagerVisible()
       if s:is_winmgr_vis == 1
           exec "WMClose"
       endif
   endif

  else

   " Re-open Taglist
   if exists('g:zoomwin_preserve_taglist') && exists('g:loaded_taglist')
       " If taglist window was open, open it again
       if s:taglist_winnum != -1
           exec "sil! Tlist"
       endif
   endif

   " Re-Open Winmanager
   if exists('g:zoomwin_preserve_winmanager') && exists('g:loaded_winmanager')
       " If the winmanager window is open then close it.
       if s:is_winmgr_vis == 1
           exec "WManager"
       endif
   endif
  endif

"  call Dret("ZoomWinPreserve")
endfun

" ---------------------------------------------------------------------
" s:SaveWinVars: saves a copy of all window-variables into the script variable s:swv_#, {{{2
"                where # is the current window number, for all windows.
fun! s:SaveWinVars()
"  call Dfunc("s:SaveWinVars()")
  let eikeep= &ei
  set ei=WinEnter,WinLeave
  windo let s:swv_{winnr()}      = deepcopy(getwinvar(winnr(),""),1)

  let &ei= eikeep
"  call Dret("s:SaveWinVars")
endfun

" ---------------------------------------------------------------------
" s:RestoreWinVars: restores window variables for all windows {{{2
fun! s:RestoreWinVars()
"  call Dfunc("s:RestoreWinVars()")
"  windo call Decho(string(s:swv_{winnr()}))
  let eikeep= &ei
  set ei=WinEnter,WinLeave
  windo if exists("s:swv_{winnr()}")     |sil! unlet s:key s:value     |for [s:key,s:value] in items(s:swv_{winnr()})|call setwinvar(winnr(),s:key,s:value)|exe "sil! unlet s:key s:value"|endfor|endif
  windo if exists("s:swv_{winnr()}")     |unlet s:swv_{winnr()}        |endif
  let &ei= eikeep
"  call Dret("s:RestoreWinVars")
endfun

" ---------------------------------------------------------------------
" s:SaveUserSettings: save user options, set to zoomwin-safe options.  {{{2
"                     Force window minimum height/width to be >= 1
fun! s:SaveUserSettings()
"  call Dfunc("s:SaveUserSettings()")

  let s:keep_wfh    = &wfh
  let s:keep_hidden = &hidden
  let s:keep_write  = &write
  let s:keep_so     = &so
  let s:keep_siso   = &siso
  let s:keep_ss     = &ss

  if v:version < 603
   if &wmh == 0 || &wmw == 0
    let s:keep_wmh = &wmh
    let s:keep_wmw = &wmw
    sil! set wmh=1 wmw=1
   endif
  endif
  set hidden write nowfh so=0 siso=0 ss=0
"  call Dret("s:SaveUserSettings")
endfun

" ---------------------------------------------------------------------
" s:RestoreUserSettings: restore user option settings {{{2
fun! s:RestoreUserSettings()
"  call Dfunc("s:RestoreUserSettings()")
"  call Decho("restore user option settings")
  let &hidden= s:keep_hidden
  let &write = s:keep_write
  let &wfh   = s:keep_wfh
  let &so    = s:keep_so
  let &siso  = s:keep_siso
  let &ss    = s:keep_ss
  if v:version < 603
   if exists("s:keep_wmw")
    let &wmh= s:keep_wmh
    let &wmw= s:keep_wmw
   endif
  endif
"  call Dret("s:RestoreUserSettings")
endfun

" ---------------------------------------------------------------------
" s:SaveWinSettings: saves all windows' local settings {{{2
fun! s:SaveWinSettings()
"  call Dfunc("s:SaveWinSettings() curwin#".winnr())
  let curwin= winnr()
  for localopt in s:localoptlist
   windo exe "let s:swv_".localopt."_{winnr()}= &".localopt
  endfor
  exe curwin."wincmd w"
"  call Dret("s:SaveWinSettings : &bt=".&bt." s:swv_bt_".curwin."=".s:swv_bt_{curwin})
endfun

" ---------------------------------------------------------------------
" s:RestoreWinSettings: restores all windows' local settings {{{2
fun! s:RestoreWinSettings()
"  call Dfunc("s:RestoreWinSettings()")
  let curwin= winnr()
  for localopt in s:localoptlist
   exe 'windo if exists("s:swv_'.localopt.'_{winnr()}")|let &'.localopt.'= s:swv_'.localopt.'_{winnr()}|unlet s:swv_'.localopt.'_{winnr()}|endif'
  endfor
  exe curwin."wincmd w"
"  call Dret("s:RestoreWinSettings : &bt=".&bt)
endfun

" ---------------------------------------------------------------------
" s:RestoreOneWinSettings: assumes that s:SaveWinSettings() was called previously; this function restores the specified window's local settings {{{2
fun! s:RestoreOneWinSettings(wnum)
"  call Dfunc("s:RestoreOneWinSettings(wnum=".a:wnum.") s:swv_bt_".a:wnum."=".s:swv_bt_{a:wnum})
  for localopt in s:localoptlist
"   call Decho('windo if exists("s:swv_'.localopt.'_{a:wnum}")|let &'.localopt.'= s:swv_'.localopt.'_{a:wnum}|unlet s:swv_'.localopt.'_{a:wnum}|endif')
   exe 'windo if exists("s:swv_'.localopt.'_{a:wnum}")|let &'.localopt.'= s:swv_'.localopt.'_{a:wnum}|unlet s:swv_'.localopt.'_{a:wnum}|endif'
  endfor
"  call Dret("s:RestoreOneWinSettings : &bt=".&bt)
endfun

" =====================================================================
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: ts=4 fdm=marker
