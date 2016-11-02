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

"hi Normal               ctermfg=Grey            ctermbg=Black
hi ColorColumn          ctermfg=White           ctermbg=Grey

hi ErrorMsg             term=standout
hi ErrorMsg             ctermfg=Red             ctermbg=none
hi WarningMsg           term=standout
hi WarningMsg           ctermfg=Yellow          ctermbg=none
hi ModeMsg              term=bold               cterm=bold
hi ModeMsg              ctermfg=LightBlue       ctermbg=none
hi MoreMsg              term=bold               ctermfg=LightGreen
hi MoreMsg              ctermfg=LightBlue       ctermbg=Black
hi Question             term=standout           gui=bold
hi Question             ctermfg=LightBlue       ctermbg=Black
hi Error                term=bold               cterm=bold
hi Error                ctermfg=Red       ctermbg=Black

hi LineNr               ctermfg=DarkGrey        ctermbg=none
hi ColorColumn          ctermbg=darkblue
hi CursorLine           cterm=underline
hi ColorColumn          ctermfg=White           ctermbg=Grey

hi IncSearch            ctermfg=DarkYellow      ctermbg=Black
hi Search               ctermfg=Black           ctermbg=Yellow
"hi StatusLine           term=bold               cterm=bold
"hi StatusLine           ctermfg=Black           ctermbg=Grey
hi StatusLineNC         term=bold               cterm=bold
hi StatusLineNC         ctermfg=LightGrey       ctermbg=black

"hi VertSplit            ctermfg=Grey            ctermbg=Grey
hi Visual               term=bold               cterm=bold
hi Visual               ctermfg=Black           ctermbg=Grey

hi Pmenu                ctermbg=Black           ctermfg=Grey
hi PmenuSel             ctermbg=DarkBlue        ctermfg=LightGreen

hi Comment              ctermfg=DarkCyan        ctermbg=none
hi PreProc              ctermfg=DarkBlue        ctermbg=none
hi Type                 ctermfg=DarkGreen      ctermbg=none           cterm=bold
hi Constant             ctermfg=Blue            ctermbg=none           cterm=bold
hi Statement            ctermfg=Yellow     ctermbg=none           cterm=bold
hi Special              ctermfg=Red             ctermbg=none           cterm=bold
"hi SpecialKey           ctermfg=Red             ctermbg=none           cterm=bold
hi Number               ctermfg=Blue            ctermbg=none
hi cCppString           ctermfg=Magenta         ctermbg=none
hi String               ctermfg=Magenta         ctermbg=none
"hi Identifier           ctermfg=Red             ctermbg=none           cterm=bold
hi Todo                 ctermfg=Black           ctermbg=Gray           cterm=bold
hi NonText              ctermfg=LightBlue       ctermbg=none
hi Directory            ctermfg=Blue            ctermbg=Black
hi Folded               ctermfg=DarkBlue        ctermbg=Black          cterm=bold
hi FoldColumn           ctermfg=LightBlue       ctermbg=Black
hi Underlined           ctermfg=LightBlue       ctermbg=Black          cterm=underline
hi Title                ctermfg=Magenta         ctermbg=none
hi Ignore               ctermfg=LightBlue       ctermbg=Black

hi Directory            ctermfg=gray            ctermbg=none
hi browseSynopsis       ctermfg=LightBlue       ctermbg=Black
hi browseCurDir         ctermfg=LightBlue       ctermbg=Black
hi favoriteDirectory    ctermfg=LightBlue       ctermbg=Black
hi browseDirectory      ctermfg=LightBlue       ctermbg=Black
hi browseSuffixInfo     ctermfg=LightBlue       ctermbg=Black
hi browseSortBy         ctermfg=LightBlue       ctermbg=Black
hi browseFilter         ctermfg=LightBlue       ctermbg=Black
hi browseFiletime       ctermfg=LightBlue       ctermbg=Black
hi browseSuffixes       ctermfg=LightBlue       ctermbg=Black

hi TagListComment       ctermfg=LightBlue       ctermbg=Black
hi TagListFileName      ctermfg=LightBlue       ctermbg=Black
hi TagListTitle         ctermfg=LightBlue       ctermbg=Black
hi TagListTagScope      ctermfg=LightBlue       ctermbg=Black
hi TagListTagName       ctermfg=LightGreen           ctermbg=Black cterm=bold
hi Tag                  ctermfg=LightBlue       ctermbg=Black


" user-defined
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

