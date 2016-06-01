" Vim color file

"0      Black
"1      DarkBlue
"2      DarkGreen
"3      DarkCyan  深蓝绿色
"4      DarkRed
"5      DarkMagenta  深品红
"6      Brown, DarkYellow  棕色
"7      LightGray, LightGrey, Gray, Grey  灰色
"8      DarkGray, DarkGrey  深灰色
"9      Blue, LightBlue
"10     Green, LightGreen
"11     Cyan, LightCyan  浅蓝绿色
"12     Red, LightRed
"13     Magenta, LightMagenta  浅品红
"14     Yellow, LightYellow
"15     White

if version > 700
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "mycolor"

hi Pmenu                ctermbg=Black           ctermfg=Grey
hi PmenuSel             ctermbg=DarkBlue        ctermfg=LightGreen

hi LineNr               ctermfg=LightBlue       ctermbg=none
hi ColorColumn          ctermbg=darkblue
hi CursorLine           cterm=underline

hi Folded               ctermbg=none            ctermfg=darkgrey

hi StatusLineNC         term=bold               cterm=bold
hi StatusLineNC         ctermfg=LightGrey       ctermbg=DarkGray
