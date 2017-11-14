# Sublime Text Guide

## Writing Code

### Viewing

cmd + n => new window

cmd + t => new tab

cmd + w => close tab

cmd + q => quit subl

cmd + shift + [] => switch tabs

cmd + 1/2/3/4/5 => select tab

ctrl + tab => switch tabs order by recent seq

cmd + shift + t => reopen last closed file

cmd + opt + 1/2/3/4/5 => layout modes

ctrl + 1/2/3/4/5 => select layout mode

edit > line > reindent => reindent

cmd + shift + i => reindent

cmd + opt + [] => hide/show code block

### Basic

lorem + tab => text :0

fn + delete => delete char on the right side of the cursor

cmd + delete => delete line on the left side fo the cursor

option + delete => delete word on the left side of the cursor

### Editing

cmd + [] => move left/right

cmd + ctrl + up/down => move up/down

cmd + shift + d => duplicate

cmd + shift + k => delete

#### Selecting & Multi-Editing

cmd + l => select current line

cmd + shift + space => select color word

cmd + f, opt + enter => edit all find items

cmd + d => add next same item

cmd + click => add cursor

cmd + double click => add item

cmd + click + drag => select more

cmd + shift + l => select line endings

ctrl + shift + w => add wrapper

## Search

cmd + p filename

cmd + p (@)method

cmd + p (#)keyword

cmd + p (:)number

cmd + opt + 0 => goto_definition

cmd + f => find, enter => next, shift enter => previous

cmd + option + f => enhanced find with replacement

cmd + shift + f => search keyword in the project

cmd + i => incremental find, enter => edit

## Project

add folders to project: drag folder into sidebar

save project: palletee > save project as name

switch project: cmd + ctrl + p, then select by name

## Palette

open: `cmd+shift+p`

project: `add, edit, close, save as`

file: `new, rename, move, dup, delete, copy`

convert case: `lower, upper, swap, title`

permute lines: `reverse, shuffle, uniq`

sort lines: `sort lines, case sensitive`

indentation: `reindent, space, tab`

html: `encode`

snippet

package

##### Color Highlighter

##### Emmet

html => todo ...

css => todo ...

[youtube](https://www.youtube.com/watch?v=U4lFXtLF5Cs&list=PLpcSpRrAaOaqQMDlCzE_Y6IUUzaSfYocK&index=7)

## Configuration

### Key bindings

preferences->key bindings

 { "keys": ["super+n"], "command": "new_window" }

## Automate code creation

### Snippets

fields, place holders, mirrored fields, substitutions ...

save snippet as `.sublime-snippet`

### Macros

record macro: `ctrl + q`

playback macro: `ctrl + shift + q`

save macro as `.sublime-macro`

binding key with saved macros.

my bind key: `opt + enter`

**= Sublime Text =**

Sublime Text is a cross-platform text and code editor for OS X, Windows, and Linux with many innovative features and a thriving ecosystem of add-on packages. This course reveals some of the basic, not-so-basic, and downright hidden features of the editor, and shows you how to become a more productive developer. Author Kevin Yank shows how to write and edit basic code, tweak the editing configuration to your preference, and automate code creation with macros and snippets. He also surveys a dozen of the best add-on packages for Sublime Text, which speed up some of the more tedious programming tasks.

Topics include:

- Opening, viewing, and editing files
- Adding custom themes and colour schemes
- Performing different types of find and replace operations
- Editing multiple lines simultaneously
- Automating tasks with macros and snippets
- Working with add-ons like Package Control, Line Endings, and Hyperlink Helper

sublime open from terminal

$ subl file / folder / .

sublime-packages

google ~ sublime text package control

cmd + shift + p => open command palette -> install package

color theme: dracula, dayle, monokai, pred, soda

package: bracket highlighter

package: sidebar enhancement

package: sublime code intel

package: sublime linter (sublimelinter-ruby)

package: markdown editing

package: emmet << emmet livestyle

package: html css js prettify

package: converto utf8

package: themr

package: ctags ~> check source code

other packages with rails dev:

alignment, simple rails navigator, rails related files, ctags, coffeescript, rubytest

basic operations









**Sublime Text**

install package control

package control => shift + cmd + p

plugins:

- [MarkDown Editing](https://github.com/SublimeText-Markdown/MarkdownEditing)
- <https://github.com/SublimeText-Markdown/MarkdownEditing>

[Plain Tasks](https://packagecontrol.io/packages/Plain%E2%80%8BTasks) - 一个自以为是的待办事项列表插件。

[Emmet](https://github.com/sergeche/emmet-sublime) - zen coding的升级版，对于前端来说，可是必备插件。

[GitGutter](https://packagecontrol.io/packages/GitGutter) - 显示Git的状态，比对。



sublime:

TrailingSpaces

{ "keys": ["ctrl+shift+t"], "command": "delete_trailing_spaces" }



subl 快捷键



- - best sublime  plugin for frontend dev - <https://www.shopify.com/partners/blog/the-best-sublime-text-plugins-for-front-end-developers>

  - - <http://engageinteractive.co.uk/blog/getting-setup-on-sublime-text-3-2017-edition>



course

https://www.bilibili.com/video/av11969967/?from=search&seid=1476235877742273679#page=4

config

https://github.com/happypeter/sublime-config/blob/master/Preferences.sublime-settings