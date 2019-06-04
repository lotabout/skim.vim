This is a fork of [fzf.vim](https://github.com/junegunn/fzf.vim)
but for [skim](https://github.com/lotabout/skim). I'd like to take advanctage
of fzf.vim as much as possible and only maintain the features where skim is
not compatible with fzf.

Besides, skim.vim add the interactive version of `ag` and `rg` function, you
could add these lines to your vimrc and try out.

```
command! -bang -nargs=* Ag call skim#vim#ag_interactive(<q-args>, skim#vim#with_preview('right:50%:hidden', 'alt-h'))
command! -bang -nargs=* Rg call skim#vim#rg_interactive(<q-args>, skim#vim#with_preview('right:50%:hidden', 'alt-h'))
```

ALL THE FOLLOWING ARE Skim's DOC.

fzf :heart: vim
===============

Things you can do with [skim][fzf] and Vim.

Rationale
---------

[skim][skim] in itself is not a Vim plugin, and the official repository only
provides the [basic wrapper function][run] for Vim and it's up to the users to
write their own Vim commands with it. However, I've learned that many users of
skim are not familiar with Vimscript and are looking for the "default"
implementation of the features they can find in the alternative Vim plugins.

This repository is a bundle of skim-based commands and mappings extracted from
my [.vimrc][vimrc] to address such needs. They are *not* designed to be
flexible or configurable, and there's no guarantee of backward-compatibility.

Why you should use skim on Vim
-----------------------------

Because you can and you love skim.

skim runs asynchronously and can be orders of magnitude faster than similar Vim
plugins. However, the benefit may not be noticeable if the size of the input
is small, which is the case for many of the commands provided here.
Nevertheless I wrote them anyway since it's really easy to implement custom
selector with skim.

Installation
------------

skim.vim depends on the basic Vim plugin of [the main skim
repository][skim-main], which means you need to **set up both "skim" and
"skim.vim" on Vim**. To learn more about skim/Vim integration, see
[README-VIM][README-VIM].

[skim-main]: https://github.com/lotabout/skim
[README-VIM]: https://github.com/lotabout/skim/blob/master/README-VIM.md

### Using [vim-plug](https://github.com/lotabout/vim-plug)

If you already installed skim using [Homebrew](https://brew.sh/), the following
should suffice:

```vim
Plug '/usr/local/opt/skim'
Plug 'lotabout/skim.vim'
```

But if you want to install skim as well using vim-plug:

```vim
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
```

- `dir` and `do` options are not mandatory
- Use `./install --bin` instead if you don't need skim outside of Vim
- Make sure to use Vim 7.4 or above

Commands
--------

| Command           | List                                                                    |
| ---               | ---                                                                     |
| `Files [PATH]`    | Files (similar to `:skim`)                                               |
| `GFiles [OPTS]`   | Git files (`git ls-files`)                                              |
| `GFiles?`         | Git files (`git status`)                                                |
| `Buffers`         | Open buffers                                                            |
| `Colors`          | Color schemes                                                           |
| `Ag [PATTERN]`    | [ag][ag] search result (`ALT-A` to select all, `ALT-D` to deselect all) |
| `Rg [PATTERN]`    | [rg][rg] search result (`ALT-A` to select all, `ALT-D` to deselect all) |
| `Lines [QUERY]`   | Lines in loaded buffers                                                 |
| `BLines [QUERY]`  | Lines in the current buffer                                             |
| `Tags [QUERY]`    | Tags in the project (`ctags -R`)                                        |
| `BTags [QUERY]`   | Tags in the current buffer                                              |
| `Marks`           | Marks                                                                   |
| `Windows`         | Windows                                                                 |
| `Locate PATTERN`  | `locate` command output                                                 |
| `History`         | `v:oldfiles` and open buffers                                           |
| `History:`        | Command history                                                         |
| `History/`        | Search history                                                          |
| `Snippets`        | Snippets ([UltiSnips][us])                                              |
| `Commits`         | Git commits (requires [fugitive.vim][f])                                |
| `BCommits`        | Git commits for the current buffer                                      |
| `Commands`        | Commands                                                                |
| `Maps`            | Normal mode mappings                                                    |
| `Helptags`        | Help tags <sup id="a1">[1](#helptags)</sup>                             |
| `Filetypes`       | File types

- Most commands support `CTRL-T` / `CTRL-X` / `CTRL-V` key
  bindings to open in a new tab, a new split, or in a new vertical split
- Bang-versions of the commands (e.g. `Ag!`) will open skim in fullscreen
- You can set `g:skim_command_prefix` to give the same prefix to the commands
    - e.g. `let g:skim_command_prefix = 'skim'` and you have `skimFiles`, etc.

(<a name="helptags">1</a>: `Helptags` will shadow the command of the same name
from [pathogen][pat]. But its functionality is still available via `call
pathogen#helptags()`. [↩](#a1))

[pat]: https://github.com/tpope/vim-pathogen
[f]:   https://github.com/tpope/vim-fugitive

### Customization

#### Global options

See [README-VIM.md][readme-vim] of the main skim repository for details.

[readme-vim]: https://github.com/lotabout/skim/blob/master/README-VIM.md#configuration

```vim
" This is the default extra key bindings
let g:skim_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default skim layout
" - down / up / left / right
let g:skim_layout = { 'down': '~40%' }

" In Neovim, you can set up skim window using a Vim command
let g:skim_layout = { 'window': 'enew' }
let g:skim_layout = { 'window': '-tabnew' }
let g:skim_layout = { 'window': '10split' }

" Customize skim colors to match your color scheme
let g:skim_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $skim_DEFAULT_OPTS.
let g:skim_history_dir = '~/.local/share/skim-history'
```

#### Command-local options

```vim
" [Buffers] Jump to the existing window if possible
let g:skim_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:skim_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:skim_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:skim_commands_expect = 'alt-enter,ctrl-x'
```

#### Advanced customization

You can use autoload functions to define your own commands.

```vim
" Command for git grep
" - skim#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call skim#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as skim.vim
" will not override existing commands.
command! -bang Colors
  \ call skim#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using skim#vim#with_preview function
"   * skim#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start skim with hidden preview window that can be enabled with "?" key
"   :Ag! - Start skim in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call skim#vim#ag(<q-args>,
  \                 <bang>0 ? skim#vim#with_preview('up:60%')
  \                         : skim#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to skim#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call skim#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? skim#vim#with_preview('up:60%')
  \           : skim#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call skim#vim#files(<q-args>, skim#vim#with_preview(), <bang>0)
```

Mappings
--------

| Mapping                            | Description                               |
| ---                                | ---                                       |
| `<plug>(skim-maps-n)`               | Normal mode mappings                      |
| `<plug>(skim-maps-i)`               | Insert mode mappings                      |
| `<plug>(skim-maps-x)`               | Visual mode mappings                      |
| `<plug>(skim-maps-o)`               | Operator-pending mappings                 |
| `<plug>(skim-complete-word)`        | `cat /usr/share/dict/words`               |
| `<plug>(skim-complete-path)`        | Path completion using `find` (file + dir) |
| `<plug>(skim-complete-file)`        | File completion using `find`              |
| `<plug>(skim-complete-file-ag)`     | File completion using `ag`                |
| `<plug>(skim-complete-line)`        | Line completion (all open buffers)        |
| `<plug>(skim-complete-buffer-line)` | Line completion (current buffer only)     |

### Usage

```vim
" Mapping selecting mappings
nmap <leader><tab> <plug>(skim-maps-n)
xmap <leader><tab> <plug>(skim-maps-x)
omap <leader><tab> <plug>(skim-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(skim-complete-word)
imap <c-x><c-f> <plug>(skim-complete-path)
imap <c-x><c-j> <plug>(skim-complete-file-ag)
imap <c-x><c-l> <plug>(skim-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> skim#vim#complete#word({'left': '15%'})
```

### Completion helper

`skim#vim#complete` is a helper function for creating custom fuzzy completion
using skim. If the first parameter is a command string or a Vim list, it will
be used as the source.

```vim
" Replace the default dictionary completion with skim-based fuzzy completion
inoremap <expr> <c-x><c-k> skim#vim#complete('cat /usr/share/dict/words')
```

For advanced uses, you can pass an options dictionary to the function. The set
of options is pretty much identical to that for `skim#run` only with the
following exceptions:

- `reducer` (funcref)
    - Reducer transforms the output lines of skim into a single string value
- `prefix` (string or funcref; default: `\k*$`)
    - Regular expression pattern to extract the completion prefix
    - Or a function to extract completion prefix
- Both `source` and `options` can be given as funcrefs that take the
  completion prefix as the argument and return the final value
- `sink` or `sink*` are ignored

```vim
" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> skim#vim#complete(skim#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
```

#### Reducer example

```vim
function! s:make_sentence(lines)
  return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
endfunction

inoremap <expr> <c-x><c-s> skim#vim#complete({
  \ 'source':  'cat /usr/share/dict/words',
  \ 'reducer': function('<sid>make_sentence'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'left':    20})
```

Status line of terminal buffer
------------------------------

When skim starts in a terminal buffer (see [skim/README-VIM.md][termbuf]), you
may want to customize the statusline of the containing buffer.

[termbuf]: https://github.com/lotabout/skim/blob/master/README-VIM.md#skim-inside-terminal-buffer

### Hide statusline

```vim
autocmd! FileType skim
autocmd  FileType skim set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
```

### Custom statusline

```vim
function! s:skim_statusline()
  " Override statusline as you like
  highlight skim1 ctermfg=161 ctermbg=251
  highlight skim2 ctermfg=23 ctermbg=251
  highlight skim3 ctermfg=237 ctermbg=251
  setlocal statusline=%#skim1#\ >\ %#skim2#fz%#skim3#f
endfunction

autocmd! User skimStatusLine call <SID>skim_statusline()
```

License
-------

MIT

[skim]:   https://github.com/lotabout/skim
[run]:   https://github.com/lotabout/skim#usage-as-vim-plugin
[vimrc]: https://github.com/lotabout/dotfiles/blob/master/vimrc
[ag]:    https://github.com/ggreer/the_silver_searcher
[rg]:    https://github.com/BurntSushi/ripgrep
[us]:    https://github.com/SirVer/ultisnips
