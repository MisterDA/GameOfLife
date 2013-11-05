Conway's Game of Life
=====================

This is my little implementation of the [Conway's Game of Life](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), using a very simple algorithm.

It is written in [Lua](http://www.lua.org), using the amazing [Löve2D](https://love2d.org) framework.


## Download

Löve and Lua are not required when running on OSX nor Windows, but if you use a UNIX-like or the standard `.love` file, you must get them from their website or from your distribution's repository.
Notice that you can use [love-release](https://github.com/MisterDA/love-release) to make your own releases, after having cloned the project.

* Every OS and Linux: [GameOfLife.love](https://dl.dropboxusercontent.com/u/30919824/GameOfLife/GameOfLife.love)
* Macintosh:          [GameOfLife-osx.zip](https://dl.dropboxusercontent.com/u/30919824/GameOfLife/GameOfLife-osx.zip)
* Windows x86:        [GameOfLife-win-x86.zip](https://dl.dropboxusercontent.com/u/30919824/GameOfLife/GameOfLife-win-x86.zip)
* Windows x64:        [GameOfLife-win-x64.zip](https://dl.dropboxusercontent.com/u/30919824/GameOfLife/GameOfLife-win-x64.zip)


## Controls

* `r` fills the matrix with random generated cells,
* `c` clears the matrix,
* `d` toggles drawing mode,
* `space` pauses the game,
* `up` and `down` control the speed,
* `+`, `-` and the `mouse wheel` can be used as zoom,
* `q` or `escape` quit the game.

You can use `d` to enter in the _drawing mode_. While in drawing mode, `left` and `right` can be used to select a predefined lifeform.
Just click anywhere to render the lifeform. To quit the drawing mode, press `space` or `d` again.
Moreover, when you are not in the drawing mode, a simple click on a cell will change its state.


## Lifeforms

You can write your own lifeforms and then use them in drawing mode. You just have to edit the `lifeforms.lua` file. Default is:
* `'#'` for a living cell,
* `' '` for a dead cell,
* `'$'` for a newline.

Any number written before one of this characters will add _n_ times this character.
By example, `###` (the blinker) is the same as `3#`.


## Future

In the future, I will try to improve the zoom, make rotation of pre-defined lifeform possible, and, why not, an [Hashlife](http://en.wikipedia.org/wiki/Hashlife) algorithm.
Please have fun !
