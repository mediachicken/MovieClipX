## Simple Lua Documentation Generator
## @author Garet McKinley (@iGaret)
## This is incomplete and doesn't work... yet

# open our config file
config = open("config", "r")


# convert lines to variables
for line in config.readlines():
	exec(line)
	
luaFile = open(luaFile, "r")

for line in luaFile.readlines():
	print(line)