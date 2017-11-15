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

cmd + shift + p

project -> new, edit, close, save as

file -> new, rename, move, copy, dup, delete

conver case -> lower, upper, swap, title

permute lines -> reverse, shuffle, uniq

sort lines -> sort line (case sensitive or not)

indentation -> reindent, space, tab

html -> encode

snippet

#### Package Control

color theme: dracula, dayle, monokai, pred, soda

package: bracket highlighter

package: Color Highlighter

package: Gutter Color

package: sidebar enhancement

package: sublime code intel

package: sublime linter

package: markdown editing [site](https://github.com/SublimeText-Markdown/MarkdownEditing)

package: emmet << emmet livestyle [youtube](https://www.youtube.com/watch?v=U4lFXtLF5Cs&list=PLpcSpRrAaOaqQMDlCzE_Y6IUUzaSfYocK&index=7)

package: html css js prettify

package: converto utf8

package: ctags ~> check source code

package: alignment

package: simple rails navigator

package: rails related files

package: PlainTasks [site](https://github.com/aziz/PlainTasks)

package: PlainNotes [site](https://github.com/aziz/PlainNotes)

package: GitGutter

package: TrailingSpaces

package: GhostText

## Configuration

preferences -> settings

preferences -> key bindings

## Automate code creation

### Snippets

save snippet as `.sublime-snippet`

fields, place holders, mirrored fields, substitutions ...

### Macros

ctrl + q => record macro

ctrl + shift + q => playback macro

save macro as `.sublime-macro`

binding key with saved macros.

common bind key: opt + enter

## References

[ref_1](http://engageinteractive.co.uk/blog/getting-setup-on-sublime-text-3-2017-edition)

[ref_2](https://www.bilibili.com/video/av11969967/?from=search&seid=1476235877742273679#page=4)

[ref_3](https://github.com/happypeter/sublime-config/blob/master/Preferences.sublime-settings)