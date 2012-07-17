## This file "builds" the examples directory
## by placing the current "mcx.lua" file into
## all of the example projects.

# note: this script has only been tested on Mac OSX

import os, shutil

library = "prototype/mcx.lua"

for path, subdirs, files in os.walk("examples"):
	if len(subdirs) > 0:
		examples = subdirs
		
for folder in examples:
	shutil.copyfile(library, "examples/" + folder + "/mcx.lua")
	

#uncomment the lines below when using the prototype/ folder for development
shutil.copyfile(library, "mcx.lua")