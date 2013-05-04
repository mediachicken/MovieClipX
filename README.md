![ScreenShot](https://raw.github.com/iGARET/MovieClipX/master/pr/banner.png)

## MovieClipX
MovieClipX (mcx) is a very slick library based off the original MovieClip library for Corona SDK. It adds a few very awesome features including
* mcx objects. A MovieClip master object capable of housing multiple different MovieClip animations.
* Retina display support.
* Animation speed control.
* And more features coming soon.


## Usage Tutorial
__I'd recommend following the tutorial listed [here](http://igaret.com/tutorials/using-movieclipx-with-your-corona-sdk-projects/ "iGaret MovieClipX Tutorial") to learn the proper way to use MovieClipX.__


__Extra tip: to automatically scale down your graphics for older phones use my utility MultiRezer instead of doing your sprites one by one!__
MultiRezer download: http://project239.com/multirezer


## Functions
`mcx.new()`
> Creates a new mcx object

`myMCXObject:newAnim(newAnim("animation_name", {frames}, width, height, {speed = int, loops = int})`
> Creates a new animation in an mcx object

`myMCXObject:play({name = string, speed = float, loops = int})`
> Plays an animation in an mcx object with the parameters given

`myMCXObject:pause()`
> Pauses the current animation in an mcx object

`myMCXObject:togglePause()`
> Toggles between the playing/paused states

`myMCXObject:stop()`
> Stops an animation in an mcx object

`myMCXObject:setLoops("animation_name", loops)`
> Sets the amount of times an animation will loop

`myMCXObject:currentAnimation()`
> Returns the name of the current animation

`myMCXObject:currentFrame()`
> Returns the number of the current frame

`myMCXObject:isPaused()`
> Returns a boolean with the current paused state

`myMCXObject:isPlaying()`
> Returns a boolean with the current playing state

`myMCXObject:enableDebugging()`
> Enable terminal output for your mcx object

`myMCXObject:disableDebugging()`
> Disable terminal output for your mcx object

`mcx.normalSpeed()`
> Returns the value to play the animation at normal speed

`mcx.halfSpeed()`
> Returns the value to play the animation at half speed

`mcx.halfSpeed()`
> Returns the value to play the animation at double speed

`mcx.sequence({name = string, extension = string, startFrame = int, endFrame = int, zeros = int})`
> Creates a table for an image sequence

## Credits
Garet McKinley (iGARET.com)

## Not satisfied?
If you've found a problem or want to make a suggestion please by all means, do so! I love to hear feedback! It's what makes it grow with features that people really need.

### Thanks for using the MovieClipX library!
