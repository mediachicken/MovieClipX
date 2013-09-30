## This file "builds" the examples directory
## by placing the current "mcx.lua" file into
## all of the example projects.

# note: this script has only been tested on Mac OSX

import os, shutil

library = "prototype/mcx.lua"


#uncomment the lines below when using the prototype/ folder for development
f = open('config','r')
build = f.read()
f.close()

build = int(build)+1
build = str(build)


f = open('config','w')
f.write(build)
f.close()

f = open(library,'r')
lua = f.readlines()
f.close()

lua[3] = "build = " + build + "\n"

f = open(library,'w')
f.writelines(lua)
f.close()


for path, subdirs, files in os.walk("examples"):
	if len(subdirs) > 0:
		examples = subdirs
		
for folder in examples:
	shutil.copyfile(library, "examples/" + folder + "/mcx.lua")

shutil.copyfile(library, "./mcx.lua")
