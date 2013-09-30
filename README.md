![ScreenShot](https://raw.github.com/iGARET/MovieClipX/master/pr/banner.png)

## MovieClipX
MovieClipX (mcx) is a very slick library based off the original MovieClip library for Corona SDK. It adds a few very awesome features including
* mcx objects. A MovieClip master object capable of housing multiple different MovieClip animations.
* Retina display support.
* Animation speed control.
* And more features coming soon.

## NEW in build 2013.215, Timeline functions!
Use `mcx.newTimeline()` to create a new timeline object! You can then add mcx objects into the timeline by using `timeline:addObject(mcxObject)` to manipulate groups of animations at once! Great for pausing every animation or activating a global "slow-mo" mode!


## Usage Tutorials
## [Beginner Tutorial →](http://igaret.com/tutorials/using-movieclipx-with-your-corona-sdk-projects/ "iGaret MovieClipX Tutorial")
## [NEW! Using Timelines →](http://igaret.com/tutorials/using-timelines-in-corona-sdk-movieclipx "Using Timelines in Corona SDK")

__Extra tip: to automatically scale down your graphics for older phones use my utility MultiRezer instead of doing your sprites one by one!__
MultiRezer download: http://project239.com/multirezer


## Documentation

### Objects
`mcx.new()`
> Creates a new mcxObject

`mcx.newTimeline()`
> Creates a new timelineObject

### Core functions
`mcx.normalSpeed()`
> Returns the value to play the animation at normal speed

`mcx.halfSpeed()`
> Returns the value to play the animation at half speed

`mcx.halfSpeed()`
> Returns the value to play the animation at double speed

`mcx.sequence({name = string, extension = string, startFrame = int, endFrame = int, zeros = int})`
> Creates a table for an image sequence

### mcxObject functions
`mcxObject:newAnim(newAnim("animation_name", {frames}, width, height, {speed = int, loops = int})`
> Creates a new animation in an mcx object

`mcxObject:play({name = string, speed = float, loops = int})`
> Plays an animation in an mcx object with the parameters given

`mcxObject:pause()`
> Pauses the current animation in an mcx object

`mcxObject:togglePause()`
> Toggles between the playing/paused states

`mcxObject:stop()`
> Stops an animation in an mcx object

`mcxObject:setLoops("animation_name", loops)`
> Sets the amount of times an animation will loop

`mcxObject:setSpeed("animation_name", speed)`
> Sets the speed for the specified animation

`mcxObject:currentAnimation()`
> Returns the name of the current animation

`mcxObject:currentFrame()`
> Returns the number of the current frame

`mcxObject:isPaused()`
> Returns a boolean with the current paused state

`mcxObject:isPlaying()`
> Returns a boolean with the current playing state

`mcxObject:enableDebugging()`
> Enable terminal output for your mcx object

`mcxObject:disableDebugging()`
> Disable terminal output for your mcx object

### Timeline functions
`timelineObject:addObject(mcxObject)`
> Adds an mcxObject to the timeline

`timelineObject:play()`
> Play the timeline

`timelineObject:pause()`
> Pause the timeline

`timelineObject:stop()`
> Stop the timeline

`timelineObject:togglePause`
> Toggles between playing/paused states

`timelineObject:alterTime(speed)`
> Alters the speed of the timeline

`timelineObject:getSpeed()`
> Returns the current speed

## Credits
Garet McKinley (iGARET.com)

## Not satisfied?
### [Go to the issue tracker →](https://github.com/iGARET/MovieClipX/issues)

### Thanks for using the MovieClipX library!