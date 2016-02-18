" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
doc/supertab.txt	[[[1
442
*supertab.txt*

Author: Eric Van Dewoestine <ervandew@gmail.com>
        Original concept and versions up to 0.32 written by
        Gergely Kontra <kgergely@mcl.hu>

This plugin is licensed under the terms of the BSD License.  Please see
supertab.vim for the license in its entirety.

==============================================================================
Supertab                                    *supertab*

1. Introduction                             |supertab-intro|
2. Supertab Usage                           |supertab-usage|
3. Supertab Options                         |supertab-options|
    Default completion type                 |supertab-defaultcompletion|
    Secondary default completion type       |supertab-contextdefault|
    Completion contexts                     |supertab-completioncontexts|
        Context text                        |supertab-contexttext|
        Context Discover                    |supertab-contextdiscover|
        Example                             |supertab-contextexample|
    Completion Duration                     |supertab-duration|
    Preventing Completion After/Before...   |supertab-preventcomplete|
    Changing default mapping                |supertab-forwardbackward|
    Inserting true tabs                     |supertab-mappingtabliteral|
    Enhanced longest match support          |supertab-longestenhanced|
    Preselecting the first entry            |supertab-longesthighlight|
    Mapping <cr> to end completion          |supertab-crmapping|
    Auto close the preview window           |supertab-closepreviewonpopupclose|
    Completion Chaining                     |supertab-completionchaining|

==============================================================================
1. Introduction                             *supertab-intro*

Supertab is a plugin which allows you to perform all your insert completion
(|ins-completion|) using the tab key.

Supertab requires Vim version 7.0 or above.

==============================================================================
2. Supertab usage                           *supertab-usage*

Using Supertab is as easy as hitting <Tab> or <S-Tab> (shift+tab) while in
insert mode, with at least one non whitespace character before the cursor, to
start the completion and then <Tab> or <S-Tab> again to cycle forwards or
backwards through the available completions.

Example ('|' denotes the cursor location):

bar
baz
b|<Tab>    Hitting <Tab> here will start the completion, allowing you to
           then cycle through the suggested words ('bar' and 'baz').

==============================================================================
3. Supertab Options                         *supertab-options*

Supertab is configured via several global variables that you can set in your
|vimrc| file according to your needs. Below is a comprehensive list of
the variables available.


Default Completion Type             *supertab-defaultcompletion*
                                    *g:SuperTabDefaultCompletionType*

g:SuperTabDefaultCompletionType (default value: "<c-p>")

Used to set the default completion type. There is no need to escape this
value as that will be done for you when the type is set.

  Example: setting the default completion to 'user' completion:

>
    let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
<

Note: a special value of 'context' is supported which will result in
super tab attempting to use the text preceding the cursor to decide which
type of completion to attempt. Currently supertab can recognize method calls
or attribute references via '.', '::' or '->', and file path references
containing '/'. If the language you are using doesn't use any of the member
reference characters listed above, or you'd like to add aditional patterns,
you can write a custom conxtext function als decribed in the next section
(Completion context).

  Example: setting the default completion to supertab's 'context' completion:
>
    let g:SuperTabDefaultCompletionType = "context"
<

    /usr/l<tab>     # will use filename completion
    myvar.t<tab>    # will use user completion if completefunc set,
                    # or omni completion if omnifunc set.
    myvar-><tab>    # same as above

When using context completion, super tab will fall back to a secondary default
completion type set by |g:SuperTabContextDefaultCompletionType|.

Note: once the buffer has been initialized, changing the value of this setting
will not change the default complete type used. If you want to change the
default completion type for the current buffer after it has been set, perhaps
in an ftplugin, you'll need to call SuperTabSetDefaultCompletionType like so,
supplying the completion type you wish to switch to:

>
    call SuperTabSetDefaultCompletionType("<c-x><c-u>")
<


Secondary default completion type   *supertab-contextdefault*
                                    *g:SuperTabContextDefaultCompletionType*

g:SuperTabContextDefaultCompletionType (default value: "<c-p>")

Sets the default completion type used when g:SuperTabDefaultCompletionType is
set to 'context' and no completion type is returned by any of the configured
contexts.


Completion contexts                 *supertab-completioncontexts*
                                    *g:SuperTabCompletionContexts*

g:SuperTabCompletionContexts (default value: ['s:ContextText'])

Sets the list of contexts used for context completion. This value should
be a list of function names which provide the context implementation.

When supertab starts context completion, each of these contexts will be
consulted, in the order they were supplied, to determine the completion type
to use. If a context returns a completion type, that type will be used,
otherwise the next context in the list will be consulted. If after executing
all the context functions, no completion type has been determined, then the
value of |g:SuperTabContextDefaultCompletionType| will be used.

  Note: supertab also supports the b:SuperTabCompletionContexts variable
  allowing you to set the list of contexts separately for the current buffer,
  like from an ftplugin for example.

Built in completion contexts:

  s:ContextText                     *supertab-contexttext*

  The text context will examine the text near the cursor to decide which type
  of completion to attempt. Currently the text context can recognize method
  calls or attribute references via '.', '::' or '->', and file path
  references containing '/'.

      /usr/l<tab>  # will use filename completion
      myvar.t<tab> # will use user completion if completefunc set, or
                   # omni completion if omnifunc set.
      myvar-><tab> # same as above

  Supported configuration attributes:

    g:SuperTabContextTextFileTypeExclusions
    List of file types for which the text context will be skipped.

    g:SuperTabContextTextOmniPrecedence
    List of omni completion option names in the order of precedence that they
    should be used if available. By default, user completion will be given
    precedence over omni completion, but you can use this variable to give
    omni completion higher precedence by placing it first in the list.

  s:ContextDiscover                 *supertab-contextdiscover*

  This context will use the 'g:SuperTabContextDiscoverDiscovery' variable to
  determine the completion type to use. It will evaluate each value, in the
  order they were defined, until a variable evaluates to a non-zero or
  non-empty value, then the associated completion type is used.

  Supported configuration properties:

    g:SuperTabContextDiscoverDiscovery
    List of variable:completionType mappings.

  Example context configuration:    *supertab-contextexample*

>
    let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
    let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
    let g:SuperTabContextDiscoverDiscovery =
        \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
<

  In addition to the default completion contexts, you can plug in your own
  implementation by creating a globally accessible function that returns
  the completion type to use (eg. "\<c-x>\<c-u>").

>
    function MyTagContext()
      if filereadable(expand('%:p:h') . '/tags')
        return "\<c-x>\<c-]>"
      endif
      " no return will result in the evaluation of the next
      " configured context
    endfunction
    let g:SuperTabCompletionContexts =
        \ ['MyTagContext', 's:ContextText', 's:ContextDiscover']
<

  Here is another example that could be used to add context support for
  clojure, and perhaps other lisp variants:

>
    let b:SuperTabCompletionContexts =
      \ ['ClojureContext'] + g:SuperTabCompletionContexts

    function! ClojureContext()
      let curline = getline('.')
      let cnum = col('.')
      let synname = synIDattr(synID(line('.'), cnum - 1, 1), 'name')
      if curline =~ '(\S\+\%' . cnum . 'c' && synname !~ '\(String\|Comment\)'
        return "\<c-x>\<c-o>"
      endif
    endfunction
<


Completion Duration                 *supertab-duration*
                                    *g:SuperTabRetainCompletionDuration*

g:SuperTabRetainCompletionDuration (default value: 'insert')

Determines if, and for how long, the current completion type is retained.
The possible values include:
'completion' - The current completion type is only retained for the
               current completion. Once you have chosen a completion
               result or exited the completion mode, the default
               completion type is restored.
'insert'     - The current completion type is saved until you exit insert
               mode (via ESC). Once you exit insert mode the default
               completion type is restored. (supertab default)
'session'    - The current completion type is saved for the duration of
               your vim session or until you enter a different completion
               mode.


Preventing completion after...      *supertab-preventcomplete*
                                    *g:SuperTabNoCompleteBefore*
                                    *g:SuperTabNoCompleteAfter*

g:SuperTabNoCompleteBefore (default value: [])
g:SuperTabNoCompleteAfter (default value: ['^', '\s'])

These two variables are used to control when supertab will attempt completion
or instead fall back to inserting a literal <tab>. There are two possible ways
to define these variables:

  1) by specifying a list of patterns which are tested against the text before 
  and after the current cursor position that when matched, prevent completion. 
  So if you don't want supertab to start completion at the start of a line, 
  after a comma, or after a space, you can set g:SuperTabNoCompleteAfter 
  to ['^', ',', '\s'].

  2) by specifying a funcref to a global accessible function which expects
  as parameter the text to be inspected (before or after) and, based on that (or 
  other factors), it returns 1 if completion must be prevented, 0 otherwise.

Note: That a buffer local version of these variables
(b:SuperTabNoCompleteBefore, b:SuperTabNoCompleteAfter) are also supported
should you wish to have different values depending on the file type for
instance.

Changing the default mapping        *supertab-forwardbackward*
                                    *g:SuperTabMappingForward*
                                    *g:SuperTabMappingBackward*

g:SuperTabMappingForward  (default value: '<tab>')
g:SuperTabMappingBackward (default value: '<s-tab>')

These two variables allow you to set the keys used to kick off the current
completion. By default this is <tab> and <s-tab>. To change to something
like <c-space> and <s-c-space>, you can add the following to your |vimrc|.

>
    let g:SuperTabMappingForward = '<c-space>'
    let g:SuperTabMappingBackward = '<s-c-space>'
>

Note: if the above does not have the desired effect (which may happen in
console version of vim), you can try the following mappings. Although the
backwards mapping still doesn't seem to work in the console for me, your
milage may vary.

>
    let g:SuperTabMappingForward = '<nul>'
    let g:SuperTabMappingBackward = '<s-nul>'
<


Inserting true tabs                 *supertab-mappingtabliteral*
                                    *g:SuperTabMappingTabLiteral*

g:SuperTabMappingTabLiteral (default value: '<c-tab>')

Sets the key mapping used to insert a literal tab where supertab would
otherwise attempt to kick off insert completion. The default is '<c-tab>'
(ctrl-tab) which unfortunately might not work at the console. So if you are
using a console vim and want this functionality, you may have to change it to
something that is supported. Alternatively, you can escape the <tab> with
<c-v> (see |i_CTRL-V| for more infos).


Enhanced longest match support      *supertab-longestenhanced*
                                    *g:SuperTabLongestEnhanced*

g:SuperTabLongestEnhanced (default value: 0)

When enabled and 'longest' is in your |completeopt| setting, supertab will
provide an enhanced longest match support where typing one or more letters and
hitting tab again while in a completion mode will complete the longest common
match using the new text in the buffer.

For example, say you have a buffer with the following contents:
  FooBarFoo
  FooBar
  Foo
  FooBarBaz
And you then type F<tab>. Vim's builtin longest support will complete the
longest common text 'Foo' and offer 'FooBarFoo', 'FooBar', 'Foo', and
'FooBarBaz' as possible completions. With supertab's longest match
enhancement disabled, typing B<tab> while still in the completion mode will
end up completing 'FooBarBaz' or 'FooBarFoo' depending your settings, instead
of the next longest common match of 'FooBar'. With supertab's enhanced
longest match feature enabled, the typing of B<tab> will result in the next
longest text being completed.


Preselecting the first entry        *supertab-longesthighlight*
                                    *g:SuperTabLongestHighlight*

g:SuperTabLongestHighlight (default value: 0)

Sets whether or not to pre-highlight the first match when completeopt has the
popup menu enabled and the 'longest' option as well. When enabled, <tab> will
kick off completion and pre-select the first entry in the popup menu, allowing
you to simply hit <enter> to use it.


Mapping <cr> to end completion      *supertab-crmapping*
                                    *g:SuperTabCrMapping*

g:SuperTabCrMapping (default value: 1)

When enabled, <cr> will cancel completion mode preserving the current text.

Compatibility with other plugins:
  - endwise:     compatible
  - delimitMate: not compatible (disabled if the delimitMate <cr> mapping is
    detected.)

Note: if you have an insert expression mapping with a <cr> in it or an insert
abbreviation containing a <cr>, then supertab will not create a <cr> mapping
which could potentially cause problems with those.


Auto close the preview window       *supertab-closepreviewonpopupclose*
                                    *g:SuperTabClosePreviewOnPopupClose*

g:SuperTabClosePreviewOnPopupClose (default value: 0)

When enabled, supertab will attempt to close vim's completion preview window
when the completion popup closes (completion is finished or canceled).

Completion Chaining                  *supertab-completionchaining*

SuperTab provides the ability to chain one of the completion functions
(|completefunc| or |omnifunc|) together with a one of the default vim
completion key sequences (|ins-completion|), giving you the ability to attempt
completion with the first, and upon no results, fall back to the second.

To utilize this feature you need to call the SuperTabChain function where
the first argument is the name of a vim compatible |complete-function| and the
second is one of vim's insert completion (|ins-completion|) key bindings
(<c-p>, <c-n>, <c-x><c-]>, etc). Calling this function will set the current
buffer's |completefunc| option to a supertab provided implementation which
utilizes the supplied arguments to perform the completion. Since the
|completefunc| option is being set, this feature must be used with
|g:SuperTabDefaultCompletionType| set to either "context" or "<c-x><c-u>".

Here is an example that can be added to your .vimrc which will setup the
supertab chaining for any filetype that has a provided |omnifunc| to first
try that, then fall back to supertab's default, <c-p>, completion:

>
  autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    \ endif
<

Notice that this autocmd set's the supertab default completion type to user
completion. This is because the call to SuperTabChain will set your buffer's
|'completefunc'| to a supertab defined function which handles the completion
chaining. If that function is never called, by user completion being invoked
via supertab, then completion chaining will not execute. As noted above though,
instead of setting the default to user completion, you can alternatively set
it supertab's 'context' completion type, in which case supertab's 'context'
completion mechanism document above will execute first, and when that context
logic kicks off a user completion, based on the current context, then
supertab's completion chaining will then take over.

Here is an example where 'context' is the global default and completion
chaining is enabled for file types that have omni completion support:

>
  let g:SuperTabDefaultCompletionType = 'context'
  autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif
<

That configuration will result in a completion flow like so:

  if text before the cursor looks like a file path:
    use file completion
  elif text before the cursor looks like an attempt to access a member
  (method, field, etc):
    use user completion
      where user completion is currently set to supertab's
      completion chaining, resulting in:
        if omni completion has results:
          use omni completion
        else:
          use keyword completion
  else:
    use keyword completion

Note: Completion chaining only supports chaining 1 completion function (omni
or user) with 1 regular completion keybinding. All other combinations of
completions (2 or more completion functions, 2 or more key bindings, etc.) are
not supported due to limitations imposed by vim's code completion
implementation.

Note: If the |completefunc| or |omnifunc| use vim's |complete_add()| instead
of returning completion results as a list, then Supertab's completion chaining
won't work properly with it since Supertab uses the function result to
determine if it should fallback to the next completion type.

vim:tw=78:ts=8:ft=help:norl:
plugin/supertab.vim	[[[1
986
" Author: Eric Van Dewoestine <ervandew@gmail.com>
"         Original concept and versions up to 0.32 written by
"         Gergely Kontra <kgergely@mcl.hu>
" Version: 2.1
" GetLatestVimScripts: 1643 1 :AutoInstall: supertab.vim
"
" Description: {{{
"   Use your tab key to do all your completion in insert mode!
"   You can cycle forward and backward with the <Tab> and <S-Tab> keys
"   Note: you must press <Tab> once to be able to cycle back
"
"   http://www.vim.org/scripts/script.php?script_id=1643
" }}}
"
" License: {{{
"   Copyright (c) 2002 - 2014
"   All rights reserved.
"
"   Redistribution and use of this software in source and binary forms, with
"   or without modification, are permitted provided that the following
"   conditions are met:
"
"   * Redistributions of source code must retain the above
"     copyright notice, this list of conditions and the
"     following disclaimer.
"
"   * Redistributions in binary form must reproduce the above
"     copyright notice, this list of conditions and the
"     following disclaimer in the documentation and/or other
"     materials provided with the distribution.
"
"   * Neither the name of Gergely Kontra or Eric Van Dewoestine nor the names
"   of its contributors may be used to endorse or promote products derived
"   from this software without specific prior written permission of Gergely
"   Kontra or Eric Van Dewoestine.
"
"   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
"   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
"   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
"   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
"   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
"   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
"   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
"   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
"   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
"   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
"   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" }}}
"
" Testing Info: {{{
"   Running vim + supertab with the absolute bare minimum settings:
"     $ vim -u NONE -U NONE -c "set nocp | runtime plugin/supertab.vim"
" }}}

if v:version < 700
  finish
endif

if exists('complType') " Integration with other completion functions.
  finish
endif

if exists("loaded_supertab")
  finish
endif
let loaded_supertab = 1

let s:save_cpo=&cpo
set cpo&vim

" Global Variables {{{

  if !exists("g:SuperTabDefaultCompletionType")
    let g:SuperTabDefaultCompletionType = "<c-p>"
  endif

  if !exists("g:SuperTabContextDefaultCompletionType")
    let g:SuperTabContextDefaultCompletionType = "<c-p>"
  endif

  if !exists("g:SuperTabCompletionContexts")
    let g:SuperTabCompletionContexts = ['s:ContextText']
  endif

  if !exists("g:SuperTabRetainCompletionDuration")
    let g:SuperTabRetainCompletionDuration = 'insert'
  endif

  if !exists("g:SuperTabNoCompleteBefore")
    " retain backwards compatability
    if exists("g:SuperTabMidWordCompletion") && !g:SuperTabMidWordCompletion
      let g:SuperTabNoCompleteBefore = ['\k']
    else
      let g:SuperTabNoCompleteBefore = []
    endif
  endif

  if !exists("g:SuperTabNoCompleteAfter")
    " retain backwards compatability
    if exists("g:SuperTabLeadingSpaceCompletion") && g:SuperTabLeadingSpaceCompletion
      let g:SuperTabNoCompleteAfter = []
    else
      let g:SuperTabNoCompleteAfter = ['^', '\s']
    endif
  endif

  if !exists("g:SuperTabMappingForward")
    let g:SuperTabMappingForward = '<tab>'
  endif
  if !exists("g:SuperTabMappingBackward")
    let g:SuperTabMappingBackward = '<s-tab>'
  endif

  if !exists("g:SuperTabMappingTabLiteral")
    let g:SuperTabMappingTabLiteral = '<c-tab>'
  endif

  if !exists("g:SuperTabLongestEnhanced")
    let g:SuperTabLongestEnhanced = 0
  endif

  if !exists("g:SuperTabLongestHighlight")
    let g:SuperTabLongestHighlight = 0
  endif

  if !exists("g:SuperTabCrMapping")
    let g:SuperTabCrMapping = 1
  endif

  if !exists("g:SuperTabClosePreviewOnPopupClose")
    let g:SuperTabClosePreviewOnPopupClose = 0
  endif

  if !exists("g:SuperTabUndoBreak")
    let g:SuperTabUndoBreak = 0
  endif

" }}}

" Script Variables {{{

  " construct the help text.
  let s:tabHelp =
    \ "Hit <CR> or CTRL-] on the completion type you wish to switch to.\n" .
    \ "Use :help ins-completion for more information.\n" .
    \ "\n" .
    \ "|<c-n>|      - Keywords in 'complete' searching down.\n" .
    \ "|<c-p>|      - Keywords in 'complete' searching up (SuperTab default).\n" .
    \ "|<c-x><c-l>| - Whole lines.\n" .
    \ "|<c-x><c-n>| - Keywords in current file.\n" .
    \ "|<c-x><c-k>| - Keywords in 'dictionary'.\n" .
    \ "|<c-x><c-t>| - Keywords in 'thesaurus', thesaurus-style.\n" .
    \ "|<c-x><c-i>| - Keywords in the current and included files.\n" .
    \ "|<c-x><c-]>| - Tags.\n" .
    \ "|<c-x><c-f>| - File names.\n" .
    \ "|<c-x><c-d>| - Definitions or macros.\n" .
    \ "|<c-x><c-v>| - Vim command-line.\n" .
    \ "|<c-x><c-u>| - User defined completion.\n" .
    \ "|<c-x><c-o>| - Omni completion.\n" .
    \ "|<c-x>s|     - Spelling suggestions."

  " set the available completion types and modes.
  let s:types =
    \ "\<c-e>\<c-y>\<c-l>\<c-n>\<c-k>\<c-t>\<c-i>\<c-]>" .
    \ "\<c-f>\<c-d>\<c-v>\<c-n>\<c-p>\<c-u>\<c-o>\<c-n>\<c-p>s"
  let s:modes = '/^E/^Y/^L/^N/^K/^T/^I/^]/^F/^D/^V/^P/^U/^O/s'
  let s:types = s:types . "np"
  let s:modes = s:modes . '/n/p'

" }}}

function! SuperTabSetDefaultCompletionType(type) " {{{
  " Globally available function that users can use to set the default
  " completion type for the current buffer, like in an ftplugin.

  " init hack for <c-x><c-v> workaround.
  let b:complCommandLine = 0

  let b:SuperTabDefaultCompletionType = a:type

  " set the current completion type to the default
  call SuperTabSetCompletionType(b:SuperTabDefaultCompletionType)
endfunction " }}}

function! SuperTabSetCompletionType(type) " {{{
  " Globally available function that users can use to create mappings to quickly
  " switch completion modes.  Useful when a user wants to restore the default or
  " switch to another mode without having to kick off a completion of that type
  " or use SuperTabHelp.  Note, this function only changes the current
  " completion type, not the default, meaning that the default will still be
  " restored once the configured retension duration has been met (see
  " g:SuperTabRetainCompletionDuration).  To change the default for the current
  " buffer, use SuperTabDefaultCompletionType(type) instead.  Example mapping to
  " restore SuperTab default:
  "   nmap <F6> :call SetSuperTabCompletionType("<c-p>")<cr>

  call s:InitBuffer()
  exec "let b:complType = \"" . escape(a:type, '<') . "\""
endfunction " }}}

function! SuperTabAlternateCompletion(type) " {{{
  " Function which can be mapped to a key to kick off an alternate completion
  " other than the default.  For instance, if you have 'context' as the default
  " and want to map ctrl+space to issue keyword completion.
  " Note: due to the way vim expands ctrl characters in mappings, you cannot
  " create the alternate mapping like so:
  "    imap <c-space> <c-r>=SuperTabAlternateCompletion("<c-p>")<cr>
  " instead, you have to use \<lt> to prevent vim from expanding the key
  " when creating the mapping.
  "    gvim:
  "      imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-p>")<cr>
  "    console:
  "      imap <nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-p>")<cr>

  call SuperTabSetCompletionType(a:type)
  " end any current completion before attempting to start the new one.
  " use feedkeys to prevent possible remapping of <c-e> from causing issues.
  "call feedkeys("\<c-e>", 'n')
  " ^ since we can't detect completion mode vs regular insert mode, we force
  " vim into keyword completion mode and end that mode to prevent the regular
  " insert behavior of <c-e> from occurring.
  call feedkeys("\<c-x>\<c-p>\<c-e>", 'n')
  call feedkeys(b:complType, 'n')
  return ''
endfunction " }}}

function! SuperTabLongestHighlight(dir) " {{{
  " When longest highlight is enabled, this function is used to do the actual
  " selection of the completion popup entry.

  if !pumvisible()
    return ''
  endif
  return a:dir == -1 ? "\<up>" : "\<down>"
endfunction " }}}

function! s:Init() " {{{
  " Setup mechanism to restore original completion type upon leaving insert
  " mode if configured to do so
  if g:SuperTabRetainCompletionDuration == 'insert'
    augroup supertab_retain
      autocmd!
      autocmd InsertLeave * call s:SetDefaultCompletionType()
    augroup END
  endif
endfunction " }}}

function! s:InitBuffer() " {{{
  if exists('b:SuperTabNoCompleteBefore')
    return
  endif

  let b:complReset = 0
  let b:complTypeManual = !exists('b:complTypeManual') ? '' : b:complTypeManual
  let b:complTypeContext = ''

  " init hack for <c-x><c-v> workaround.
  let b:complCommandLine = 0

  if !exists('b:SuperTabNoCompleteBefore')
    let b:SuperTabNoCompleteBefore = g:SuperTabNoCompleteBefore
  endif
  if !exists('b:SuperTabNoCompleteAfter')
    let b:SuperTabNoCompleteAfter = g:SuperTabNoCompleteAfter
  endif

  if !exists('b:SuperTabDefaultCompletionType')
    let b:SuperTabDefaultCompletionType = g:SuperTabDefaultCompletionType
  endif

  " set the current completion type to the default
  call SuperTabSetCompletionType(b:SuperTabDefaultCompletionType)

  " hack to programatically revert a change to snipmate that breaks supertab
  " but which the new maintainers don't care about:
  " http://github.com/garbas/vim-snipmate/issues/37
  let snipmate = maparg('<tab>', 'i')
  if snipmate =~ '<C-G>u' && g:SuperTabMappingForward =~? '<tab>'
    let snipmate = substitute(snipmate, '<C-G>u', '', '')
    iunmap <tab>
    exec "inoremap <silent> <tab> " . snipmate
  endif
endfunction " }}}

function! s:ManualCompletionEnter() " {{{
  " Handles manual entrance into completion mode.

  if &smd
    echo '' | echohl ModeMsg | echo '-- ^X++ mode (' . s:modes . ')' | echohl None
  endif
  let complType = nr2char(getchar())
  if stridx(s:types, complType) != -1
    if !exists('b:supertab_close_preview')
      let b:supertab_close_preview = !s:IsPreviewOpen()
    endif

    if stridx("\<c-e>\<c-y>", complType) != -1 " no memory, just scroll...
      return "\<c-x>" . complType
    elseif stridx('np', complType) != -1
      let complType = nr2char(char2nr(complType) - 96)
    else
      let complType = "\<c-x>" . complType
    endif

    let b:complTypeManual = complType

    if index(['insert', 'session'], g:SuperTabRetainCompletionDuration) != -1
      let b:complType = complType
    endif

    " Hack to workaround bug when invoking command line completion via <c-r>=
    if complType == "\<c-x>\<c-v>"
      return s:CommandLineCompletion()
    endif

    call s:InitBuffer()

    " optionally enable enhanced longest completion
    if g:SuperTabLongestEnhanced && &completeopt =~ 'longest'
      call s:EnableLongestEnhancement()
    " handle backspacing which triggers g:SuperTabNoCompleteAfter match
    elseif s:IsNoCompleteAfterReset()
      call s:EnableNoCompleteAfterReset()
    endif

    if g:SuperTabLongestHighlight &&
     \ &completeopt =~ 'longest' &&
     \ &completeopt =~ 'menu' &&
     \ !pumvisible()
      let dir = (complType == "\<c-x>\<c-p>") ? -1 : 1
      call feedkeys("\<c-r>=SuperTabLongestHighlight(" . dir . ")\<cr>", 'n')
    endif

    return complType
  endif

  echohl "Unknown mode"
  return complType
endfunction " }}}

function! s:SetCompletionType() " {{{
  " Sets the completion type based on what the user has chosen from the help
  " buffer.

  let chosen = substitute(getline('.'), '.*|\(.*\)|.*', '\1', '')
  if chosen != getline('.')
    let winnr = b:winnr
    close
    exec winnr . 'winc w'
    call SuperTabSetCompletionType(chosen)
  endif
endfunction " }}}

function! s:SetDefaultCompletionType() " {{{
  if exists('b:SuperTabDefaultCompletionType') &&
  \ (!exists('b:complCommandLine') || !b:complCommandLine)
    call SuperTabSetCompletionType(b:SuperTabDefaultCompletionType)
  endif
endfunction " }}}

function! SuperTab(command) " {{{
  " Used to perform proper cycle navigation as the user requests the next or
  " previous entry in a completion list, and determines whether or not to simply
  " retain the normal usage of <tab> based on the cursor position.

  if exists('b:SuperTabDisabled') && b:SuperTabDisabled
    if exists('s:Tab')
      return s:Tab()
    endif
    return (
        \ g:SuperTabMappingForward ==? '<tab>' ||
        \ g:SuperTabMappingBackward ==? '<tab>'
      \ ) ? "\<tab>" : ''
  endif

  call s:InitBuffer()

  if s:WillComplete()
    if !exists('b:supertab_close_preview')
      let b:supertab_close_preview = !s:IsPreviewOpen()
    endif

    " optionally enable enhanced longest completion
    if g:SuperTabLongestEnhanced && &completeopt =~ 'longest'
      call s:EnableLongestEnhancement()
    " handle backspacing which triggers g:SuperTabNoCompleteAfter match
    elseif s:IsNoCompleteAfterReset()
      call s:EnableNoCompleteAfterReset()
    endif

    if !pumvisible()
      let b:complTypeManual = ''
    endif

    " exception: if in <c-p> mode, then <c-n> should move up the list, and
    " <c-p> down the list.
    if a:command == 'p' && !b:complReset &&
      \ (b:complType == "\<c-p>" ||
      \   (b:complType == 'context' &&
      \    b:complTypeManual == '' &&
      \    b:complTypeContext == "\<c-p>"))
      return "\<c-n>"

    elseif a:command == 'p' && !b:complReset &&
      \ (b:complType == "\<c-n>" ||
      \   (b:complType == 'context' &&
      \    b:complTypeManual == '' &&
      \    b:complTypeContext == "\<c-n>"))
      return "\<c-p>"

    " already in completion mode and not resetting for longest enhancement, so
    " just scroll to next/previous
    elseif pumvisible() && !b:complReset
      let type = b:complType == 'context' ? b:complTypeContext : b:complType
      if a:command == 'n'
        return type == "\<c-p>" || type == "\<c-x>\<c-p>" ? "\<c-p>" : "\<c-n>"
      endif
      return type == "\<c-p>" || type == "\<c-x>\<c-p>" ? "\<c-n>" : "\<c-p>"
    endif

    " handle 'context' completion.
    if b:complType == 'context'
      let complType = s:ContextCompletion()
      if complType == ''
        exec "let complType = \"" .
          \ escape(g:SuperTabContextDefaultCompletionType, '<') . "\""
      endif
      let b:complTypeContext = complType

    " Hack to workaround bug when invoking command line completion via <c-r>=
    elseif b:complType == "\<c-x>\<c-v>"
      let complType = s:CommandLineCompletion()
    else
      let complType = b:complType
    endif

    " switch <c-x><c-p> / <c-x><c-n> completion in <c-p> mode
    if a:command == 'p'
      if complType == "\<c-x>\<c-p>"
        let complType = "\<c-x>\<c-n>"
      elseif complType == "\<c-x>\<c-n>"
        let complType = "\<c-x>\<c-p>"
      endif
    endif

    " highlight first result if longest enabled
    if g:SuperTabLongestHighlight &&
     \ &completeopt =~ 'longest' &&
     \ &completeopt =~ 'menu' &&
     \ (!pumvisible() || b:complReset)
      let dir = (complType == "\<c-p>") ? -1 : 1
      call feedkeys("\<c-r>=SuperTabLongestHighlight(" . dir . ")\<cr>", 'n')
    endif

    if b:complReset
      let b:complReset = 0
      " not an accurate condition for everyone, but better than sending <c-e>
      " at the wrong time.
      if pumvisible()
        return "\<c-e>" . complType
      endif
    endif

    if g:SuperTabUndoBreak && !pumvisible()
        return "\<c-g>u" . complType
    endif

    return complType
  endif

  if exists('s:Tab')
    return s:Tab()
  endif
  return (
      \ g:SuperTabMappingForward ==? '<tab>' ||
      \ g:SuperTabMappingBackward ==? '<tab>'
    \ ) ? "\<tab>" : ''
endfunction " }}}

function! s:SuperTabHelp() " {{{
  " Opens a help window where the user can choose a completion type to enter.

  let winnr = winnr()
  if bufwinnr("SuperTabHelp") == -1
    botright split SuperTabHelp

    setlocal noswapfile
    setlocal buftype=nowrite
    setlocal bufhidden=delete

    silent put =s:tabHelp
    call cursor(1, 1)
    silent 1,delete _
    call cursor(4, 1)
    exec "resize " . line('$')

    syntax match Special "|.\{-}|"

    setlocal readonly
    setlocal nomodifiable

    nmap <silent> <buffer> <cr> :call <SID>SetCompletionType()<cr>
    nmap <silent> <buffer> <c-]> :call <SID>SetCompletionType()<cr>
  else
    exec bufwinnr("SuperTabHelp") . "winc w"
  endif
  let b:winnr = winnr
endfunction " }}}

function! s:WillComplete(...) " {{{
  " Determines if completion should be kicked off at the current location.
  " Optional arg:
  "   col: The column to check at, otherwise use the current column.

  " if an arg was supplied, then we will re-check even if already in
  " completion mode.
  if pumvisible() && !a:0
    return 1
  endif

  let line = getline('.')
  let cnum = a:0 ? a:1 : col('.')

  " honor SuperTabNoCompleteAfter
  let pre = cnum >= 2 ? line[:cnum - 2] : ''
  let complAfterType = type(b:SuperTabNoCompleteAfter)
  if complAfterType == 3
    " the option was provided as a list of patterns
    for pattern in b:SuperTabNoCompleteAfter
      if pre =~ pattern . '$'
        return 0
      endif
    endfor
  elseif complAfterType == 2
    " the option was provided as a funcref
    return !b:SuperTabNoCompleteAfter(pre)
  endif

  " honor SuperTabNoCompleteBefore
  " Within a word, but user does not have mid word completion enabled.
  let post = line[cnum - 1:]
  let complBeforeType = type(b:SuperTabNoCompleteBefore)
  if complBeforeType == 3
    " a list of patterns
    for pattern in b:SuperTabNoCompleteBefore
      if post =~ '^' . pattern
        return 0
      endif
    endfor
  elseif complBeforeType == 2
    " the option was provided as a funcref
    return !b:SuperTabNoCompleteBefore(post)
  endif

  return 1
endfunction " }}}

function! s:EnableLongestEnhancement() " {{{
  augroup supertab_reset
    autocmd!
    autocmd InsertLeave,CursorMovedI <buffer>
      \ call s:ReleaseKeyPresses() | autocmd! supertab_reset
  augroup END
  call s:CaptureKeyPresses()
endfunction " }}}

function! s:IsNoCompleteAfterReset() " {{{
  " if the user has g:SuperTabNoCompleteAfter set, then re-map <bs> so that
  " backspacing to a point where one of the g:SuperTabNoCompleteAfter
  " entries matches will cause completion mode to exit.
  let complAfterType = type(b:SuperTabNoCompleteAfter)
  if complAfterType == 2
    return 1
  endif
  return len(g:SuperTabNoCompleteAfter) && g:SuperTabNoCompleteAfter != ['^', '\s']
endfunction " }}}

function! s:EnableNoCompleteAfterReset() " {{{
  augroup supertab_reset
    autocmd!
    autocmd InsertLeave,CursorMovedI <buffer>
      \ call s:ReleaseKeyPresses() | autocmd! supertab_reset
  augroup END

  " short version of s:CaptureKeyPresses
  if !exists('b:capturing') || !b:capturing
    let b:capturing = 1
    let b:capturing_start = col('.')
    let b:captured = {
        \ '<bs>': maparg('<bs>', 'i'),
        \ '<c-h>': maparg('<c-h>', 'i'),
      \ }
    imap <buffer> <bs> <c-r>=<SID>CompletionReset("\<lt>bs>")<cr>
    imap <buffer> <c-h> <c-r>=<SID>CompletionReset("\<lt>c-h>")<cr>
  endif
endfunction " }}}

function! s:CompletionReset(char) " {{{
  let b:complReset = 1

  " handle exiting completion mode if user has g:SuperTabNoCompleteAfter set
  " and they are about to backspace to a point where that maches one of the
  " entries in that var.
  if (a:char == "\<bs>" || a:char == "\<c-h>") && s:IsNoCompleteAfterReset()
    if !s:WillComplete(col('.') - 1)
      " exit from completion mode then issue the currently requested backspace
      call feedkeys("\<space>\<bs>\<bs>", 'n')
      return ''
    endif
  endif

  return a:char
endfunction " }}}

function! s:CaptureKeyPresses() " {{{
  if !exists('b:capturing') || !b:capturing
    let b:capturing = 1
    let b:capturing_start = col('.')
    " save any previous mappings
    " TODO: capture additional info provided by vim 7.3.032 and up.
    let b:captured = {
        \ '<bs>': maparg('<bs>', 'i'),
        \ '<c-h>': maparg('<c-h>', 'i'),
      \ }
    " TODO: use &keyword to get an accurate list of chars to map
    for c in split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_', '.\zs')
      let existing = maparg(c, 'i')
      let b:captured[c] = existing
      exec 'imap <buffer> ' . c . ' <c-r>=<SID>CompletionReset("' . c . '")<cr>'
    endfor
    imap <buffer> <bs> <c-r>=<SID>CompletionReset("\<lt>bs>")<cr>
    imap <buffer> <c-h> <c-r>=<SID>CompletionReset("\<lt>c-h>")<cr>
  endif
endfunction " }}}

function! s:IsPreviewOpen() " {{{
  let wins = tabpagewinnr(tabpagenr(), '$')
  let winnr = 1
  while winnr <= wins
    if getwinvar(winnr, '&previewwindow') == 1
      return 1
    endif
    let winnr += 1
  endwhile
  return 0
endfunction " }}}

function! s:ClosePreview() " {{{
  if exists('b:supertab_close_preview') && b:supertab_close_preview
    let preview = 0
    for bufnum in tabpagebuflist()
      if getwinvar(bufwinnr(bufnum), '&previewwindow')
        let preview = 1
        break
      endif
    endfor
    if preview
      pclose
      try
        doautocmd <nomodeline> supertab_preview_closed User <supertab>
      catch /E216/
        " ignore: no autocmds defined
      endtry
    endif
  endif
  silent! unlet b:supertab_close_preview
endfunction " }}}

function! s:ReleaseKeyPresses() " {{{
  if exists('b:capturing') && b:capturing
    let b:capturing = 0
    for c in keys(b:captured)
      exec 'iunmap <buffer> ' . c
    endfor

    " restore any previous mappings
    for [key, rhs] in items(b:captured)
      if rhs != ''
        let args = substitute(rhs, '.*\(".\{-}"\).*', '\1', '')
        if args != rhs
          let args = substitute(args, '<', '<lt>', 'g')
          let expr = substitute(rhs, '\(.*\)".\{-}"\(.*\)', '\1%s\2', '')
          let rhs = printf(expr, args)
        endif
        exec printf("imap <silent> <buffer> %s %s", key, rhs)
      endif
    endfor
    unlet b:captured

    if mode() == 'i' && &completeopt =~ 'menu' && b:capturing_start != col('.')
      " force full exit from completion mode (don't exit insert mode since
      " that will break repeating with '.')
      call feedkeys("\<space>\<bs>", 'n')
    endif
    unlet b:capturing_start
  endif
endfunction " }}}

function! s:CommandLineCompletion() " {{{
  " Hack needed to account for apparent bug in vim command line mode completion
  " when invoked via <c-r>=

  " This hack will trigger InsertLeave which will then invoke
  " s:SetDefaultCompletionType.  To prevent default completion from being
  " restored prematurely, set an internal flag for s:SetDefaultCompletionType
  " to check for.
  let b:complCommandLine = 1
  return "\<c-\>\<c-o>:call feedkeys('\<c-x>\<c-v>\<c-v>', 'n') | " .
    \ "let b:complCommandLine = 0\<cr>"
endfunction " }}}

function! s:ContextCompletion() " {{{
  let contexts = exists('b:SuperTabCompletionContexts') ?
    \ b:SuperTabCompletionContexts : g:SuperTabCompletionContexts

  for context in contexts
    try
      let Context = function(context)
      let complType = Context()
      unlet Context
      if type(complType) == 1 && complType != ''
        return complType
      endif
    catch /E700/
      echohl Error
      echom 'supertab: no context function "' . context . '" found.'
      echohl None
    endtry
  endfor
  return ''
endfunction " }}}

function! s:ContextDiscover() " {{{
  let discovery = exists('g:SuperTabContextDiscoverDiscovery') ?
    \ g:SuperTabContextDiscoverDiscovery : []

  " loop through discovery list to find the default
  if !empty(discovery)
    for pair in discovery
      let var = substitute(pair, '\(.*\):.*', '\1', '')
      let type = substitute(pair, '.*:\(.*\)', '\1', '')
      exec 'let value = ' . var
      if value !~ '^\s*$' && value != '0'
        exec "let complType = \"" . escape(type, '<') . "\""
        return complType
      endif
    endfor
  endif
endfunction " }}}

function! s:ContextText() " {{{
  let exclusions = exists('g:SuperTabContextTextFileTypeExclusions') ?
    \ g:SuperTabContextTextFileTypeExclusions : []

  if index(exclusions, &ft) == -1
    let curline = getline('.')
    let cnum = col('.')
    let synname = synIDattr(synID(line('.'), cnum - 1, 1), 'name')
    if curline =~ '.*/\w*\%' . cnum . 'c' ||
      \ ((has('win32') || has('win64')) && curline =~ '.*\\\w*\%' . cnum . 'c')
      return "\<c-x>\<c-f>"

    elseif curline =~ '.*\(\w\|[\])]\)\(\.\|>\?::\|->\)\w*\%' . cnum . 'c' &&
      \ synname !~ '\(String\|Comment\)'
      let omniPrecedence = exists('g:SuperTabContextTextOmniPrecedence') ?
        \ g:SuperTabContextTextOmniPrecedence : ['&completefunc', '&omnifunc']

      for omniFunc in omniPrecedence
        if omniFunc !~ '^&'
          let omniFunc = '&' . omniFunc
        endif
        if getbufvar(bufnr('%'), omniFunc) != ''
          return omniFunc == '&omnifunc' ? "\<c-x>\<c-o>" : "\<c-x>\<c-u>"
        endif
      endfor
    endif
  endif
endfunction " }}}

function! s:ExpandMap(map) " {{{
  let map = a:map
  if map =~ '<Plug>'
    let plug = substitute(map, '.\{-}\(<Plug>\w\+\).*', '\1', '')
    let plug_map = maparg(plug, 'i')
    let map = substitute(map, '.\{-}\(<Plug>\w\+\).*', plug_map, '')
  endif
  return map
endfunction " }}}

function! SuperTabChain(completefunc, completekeys) " {{{
  if a:completefunc != 'SuperTabCodeComplete'
    let b:SuperTabChain = [a:completefunc, a:completekeys]
    setlocal completefunc=SuperTabCodeComplete
  endif
endfunction " }}}

function! SuperTabCodeComplete(findstart, base) " {{{
  if !exists('b:SuperTabChain')
    echoe 'No completion chain has been set.'
    return -2
  endif

  if len(b:SuperTabChain) != 2
    echoe 'Completion chain can only be used with 1 completion function ' .
        \ 'and 1 fallback completion key binding.'
    return -2
  endif

  let Func = function(b:SuperTabChain[0])

  if a:findstart
    let start = Func(a:findstart, a:base)
    if start >= 0
      return start
    endif

    return col('.') - 1
  endif

  let results = Func(a:findstart, a:base)
  if len(results)
    return results
  endif

  exec 'let keys = "' . escape(b:SuperTabChain[1], '<') . '"'
  call feedkeys("\<c-e>" . keys, 'nt')
  return []
endfunction " }}}

" Autocmds {{{
  if g:SuperTabClosePreviewOnPopupClose
    augroup supertab_close_preview
      autocmd!
      autocmd InsertLeave,CursorMovedI * call s:ClosePreview()
    augroup END
  endif
" }}}

" Key Mappings {{{
  " map a regular tab to ctrl-tab (note: doesn't work in console vim)
  exec 'inoremap ' . g:SuperTabMappingTabLiteral . ' <tab>'

  imap <silent> <c-x> <c-r>=<SID>ManualCompletionEnter()<cr>

  imap <script> <Plug>SuperTabForward <c-r>=SuperTab('n')<cr>
  imap <script> <Plug>SuperTabBackward <c-r>=SuperTab('p')<cr>

  " support delegating to smart tabs plugin
  if g:SuperTabMappingForward ==? '<tab>' || g:SuperTabMappingBackward ==? '<tab>'
    let existing = maparg('<tab>', 'i')
    if existing =~ '\d\+_InsertSmartTab()$'
      let s:Tab = function(substitute(existing, '()$', '', ''))
    endif
  endif

  exec 'imap ' . g:SuperTabMappingForward . ' <Plug>SuperTabForward'
  exec 'imap ' . g:SuperTabMappingBackward . ' <Plug>SuperTabBackward'

  if g:SuperTabCrMapping
    let expr_map = 0
    if v:version > 703 || (v:version == 703 && has('patch32'))
      let map_dict = maparg('<cr>', 'i', 0, 1)
      let expr_map = has_key(map_dict, 'expr') && map_dict.expr
    else
      let expr_map = maparg('<cr>', 'i') =~? '\<cr>'
    endif

    redir => iabbrevs
    silent iabbrev
    redir END
    let iabbrev_map = iabbrevs =~? '\<cr>'

    if expr_map
      " Not compatible w/ expr mappings. This is most likely a user mapping,
      " typically with the same functionality anyways.
    elseif iabbrev_map
      " Not compatible w/ insert abbreviations containing <cr>
    elseif maparg('<CR>', 'i') =~ '<Plug>delimitMateCR'
      " Not compatible w/ delimitMate since it doesn't play well with others
      " and will always return a <cr> which we don't want when selecting a
      " completion.
    elseif maparg('<CR>','i') =~ '<CR>'
      let map = maparg('<cr>', 'i')
      let cr = (map =~? '\(^\|[^)]\)<cr>')
      let map = s:ExpandMap(map)
      exec "inoremap <script> <cr> <c-r>=<SID>SelectCompletion(" . cr . ")<cr>" . map
    else
      inoremap <silent> <cr> <c-r>=<SID>SelectCompletion(1)<cr>
    endif
    function! s:SelectCompletion(cr)
      " selecting a completion
      if pumvisible()
        " ugly hack to let other <cr> mappings for other plugins cooperate
        " with supertab
        let b:supertab_pumwasvisible = 1

        " close the preview window if configured to do so
        if &completeopt =~ 'preview' && g:SuperTabClosePreviewOnPopupClose
          if !exists('b:supertab_close_preview')
            let b:supertab_close_preview = !s:IsPreviewOpen()
          endif
          call s:ClosePreview()
        endif

        return "\<c-y>"
      endif

      " only needed when chained with other mappings and one of them will
      " issue a <cr>.
      if exists('b:supertab_pumwasvisible') && !a:cr
        unlet b:supertab_pumwasvisible
        return ''
      endif

      " not so pleasant hack to keep <cr> working for abbreviations
      let word = substitute(getline('.'), '^.*\s\+\(.*\%' . col('.') . 'c\).*', '\1', '')
      let result = maparg(word, 'i', 1)
      if result != ''
        let bs = ""
        let i = 0
        while i < len(word)
          let bs .= "\<bs>"
          let i += 1
        endwhile
        " escape keys
        let result = substitute(result, '\(<[a-zA-Z][-a-zA-Z]*>\)', '\\\1', 'g')
        " ensure escaped keys are properly recognized
        exec 'let result = "' . escape(result, '"') . '"'
        return bs . result . (a:cr ? "\<cr>" : "")
      endif

      " only return a cr if nothing else is mapped to it since we don't want
      " to duplicate a cr returned by another mapping.
      return a:cr ? "\<cr>" : ""
    endfunction
  endif
" }}}

" Command Mappings {{{
  if !exists(":SuperTabHelp")
    command SuperTabHelp :call <SID>SuperTabHelp()
  endif
" }}}

call s:Init()

function! TestSuperTabCodeComplete(findstart, base) " {{{
  " Test supertab completion chaining w/ a minimal vim environment:
  " $ vim -u NONE -U NONE \
  "   --cmd "set nocp | sy on" \
  "   -c "so ~/.vim/plugin/supertab.vim" \
  "   -c "let g:SuperTabDefaultCompletionType = '<c-x><c-u>'" \
  "   -c "set completefunc=TestSuperTabCodeComplete" \
  "   -c "call SuperTabChain(&completefunc, '<c-p>')"
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    if line[start] =~ '\.'
      let start -= 1
    endif
    while start > 0 && line[start - 1] =~ '\w'
      let start -= 1
    endwhile
    return start
  else
    let completions = []
    if getline('.') =~ 'TestC'
      call add(completions, {
          \ 'word': 'test1(',
          \ 'kind': 'm',
          \ 'menu': 'test1(...)',
        \ })
      call add(completions, {
          \ 'word': 'testing2(',
          \ 'kind': 'm',
          \ 'menu': 'testing2(...)',
        \ })
    endif

    return completions
  endif
endfunction " }}}

let &cpo = s:save_cpo

" vim:ft=vim:fdm=marker
