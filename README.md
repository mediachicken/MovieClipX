## Feeling Adventurous?
Switch to the experimental branch if you'd like to try out experimental features. It's undocumented, but has a __LOT__ of incredible features that have yet to be added to the master branch.
> note: although the experimental branch is awesome, some features may be unstable. If you'd like to help get these features to the master branch please report any issues to the github page. It would help a ton!

## MovieClipX Library
The MovieClipX library (originally Retina MovieClip library) is a version of the MovieClip library that supports the retina display. it's the MovieClip library with added support for retina displays (@2x graphics for the iPhone 4 and the new iPad) while simultaneously supporting the original non-retina devices.

## Usage
1. Make sure your `config.lua` file has this tag in it:

`imageSuffix = { ["@2x"] = 2 }`


2. Make sure you have copies of all your images, one for the high resolution graphic for the retina screen and one halfsized for old devices. You must name the files like so: 
Retina graphic = filename@2x.png
Non-Retina = filename.png
> __note: they don't have to be .png files.__

3. You can use the MovieClipX library exactly the way the original can be used, except instead of `newAnim({frames})` you must use `newAnim({frames}, width, height)`
> __note: you must enter the width and height of the non-retina graphic. So if the retina graphic is 128x128 you'd enter 64 for the width and height.__

__Extra tip: to automatically scale down your graphics for older phones use my utility MultiRezer instead of of doing your sprites one by one!__
MultiRezer download: http://project239.com/multirezer


Thanks for using MovieClipX!