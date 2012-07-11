## This file "builds" the examples directory
## by placing the current "mcx.lua" file into
## all of the example projects.

import os, shutil

library = "mcx.lua"

for path, subdirs, files in os.walk("examples"):
	if len(subdirs) > 0:
		examples = subdirs
		
for folder in examples:
	shutil.copyfile("mcx.lua", "examples/" + folder + "/mcx.lua")