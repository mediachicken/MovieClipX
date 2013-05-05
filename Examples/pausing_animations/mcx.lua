-- @title MovieClipX
-- @tagline A better way to animate.
-- @author Garet McKinley (@iGaret)
build = 215

module(..., package.seeall)

env = system.getInfo("environment")

if (env == "simulator") then
	print("MovieClipX v2013." .. build)
	local function networkListener( event )
		if (build < tonumber(event.response)) then
			print("Warning: You are running an old version of MCX!")
			print("Visit https://github.com/iGARET/MovieClipX/ to download the latest version.")
		end
	end
	network.request( "https://raw.github.com/iGARET/MovieClipX/master/config", "GET", networkListener)
end


function normalSpeed()
	return 1.0
end

function halfSpeed()
	return 0.5
end

function doubleSpeed()
	return 2.0
end

function forward()
	return "forward"
end

function backward()
	return "backward"
end

function sequence(params)
	if (params) then
		if (params.name == nil) then
			print("MCX SEQUENCE ERROR: Missing name")
		end
		if (params.extension == nil) then
			print("MCX SEQUENCE ERROR: Missing extension")
		end
		if (params.endFrame == nil) then
			print("MCX SEQUENCE ERROR: Missing endFrame")
		end
		if (params.name ~= nil and params.extension ~= nil and params.endFrame ~= nil) then
			if (params.startFrame == nil) then
				params.startFrame = 1
			end
			if (params.zeros == nil) then
				params.zeros = 0
			end

			tmpTable = {}
			for i = params.startFrame, params.endFrame do
				count = string.format("%0" .. params.zeros .. "d", i)
				table.insert( tmpTable, params.name .. count .. "." .. params.extension )
			end
			return tmpTable
		end
	else
		print("MCX SEQUENCE ERROR: Missing name, extension, and endFrame")
	end
	return false
end


function newTimeline()
	local tl = display.newGroup()
	local objects = {}
	local paused = false
	tl.speed = 1.0
	
	function tl:addObject(object)
		tl:insert(object)
	end
	

	function tl:play()
		for i = 1,tl.numChildren do
			tl[i]:play()
		end
	end
	
	function tl:pause()
		for i = 1,tl.numChildren do
			tl[i]:pause()
		end
	end
	
	function tl:stop()
		for i = 1,tl.numChildren do
			tl[i]:stop()
		end
	end
	
	function tl:togglePause()
		if paused then
			for i = 1,tl.numChildren do
				tl[i]:play()
				paused = false
			end
		else
			for i = 1,tl.numChildren do
				tl[i]:pause()
				paused = true
			end
		end
	end
	
	function tl:alterTime(speed)
		for i = 1,tl.numChildren do
			tl[i]:setSpeed(tl[i]:currentAnimation(), speed)
			tl.speed = speed 
		end
	end
	
	function tl:getSpeed()
		return tl.speed
	end
	
	-- return the timeline object
	return tl
end

--- Creates a new MovieClipX container
-- mxc containers are the core of the MovieClipX library.
-- In order to do anything with the library, you first need
-- a mcx container.
function new()
	local mcx = display.newGroup()
	local clips = {}
	local active = nil
	local animName = nil
	local timeWarp = 1
	local debug = false
	local paused = false
	
	function mcx:newAnim (name,imageTable, width, height, params)
		



		-- Set up graphics
		local g = display.newGroup()
		local animFrames = {}
		local animLabels = {}
		local limitX, limitY, transpose
		local startX, startY
		if (params ~= nil) then
			g.speed = params.speed * timeWarp
			g.loops = params.loops
			g.progress = 0
		else
			g.speed = 5
			g.loops = 0
			g.progress = 0
		end

		local i = 1
		while imageTable[i] do
			animFrames[i] = display.newImageRect(imageTable[i],width,height);
			g:insert(animFrames[i], true)
			animLabels[i] = i -- default frame label is frame number
			animFrames[i].isVisible = false
			i = i + 1
		end
		
		-- show first frame by default
		animFrames[1].isVisible = false

		-------------------------
		-- Define private methods
	
		local currentFrame = 1
		local totalFrames = #animFrames
		local startFrame = 1
		local endFrame = #animFrames
		local loop = g.loops
		local loopCount = 0
		local remove = false
		local dragBounds = nil
		local dragLeft, dragTop, dragWidth, dragHeight
	
		-- flag to distinguish initial default case (where no sequence parameters are submitted)
		local inSequence = false

		local function resetDefaults()
			currentFrame = 1
			startFrame = 1
			endFrame = #animFrames
			loop = 0
			loopCount = 0
			remove = false
		end
	
		local function resetReverseDefaults()
			currentFrame = #animFrames
			startFrame = #animFrames
			endFrame = 1
			loop = 0
			loopCount = 0
			remove = false
		end
	
		local function nextFrame( self, event )
			animFrames[currentFrame].isVisible = false
			currentFrame = currentFrame + 1
			if (currentFrame == endFrame + 1) then
				if (loop > 0) then
					loopCount = loopCount + 1

					if (loopCount == loop) then
						-- stop looping
						currentFrame = currentFrame - 1
						animFrames[currentFrame].isVisible = true
						Runtime:removeEventListener( "enterFrame", self )
						paused = true
						g.aspeed = nil
						mcx:log("Finished " .. animName)
						if (remove) then
							-- delete self (only gets garbage collected if there are no other references)
							self.parent:remove(self)
						end

					else
						currentFrame = startFrame
						animFrames[currentFrame].isVisible = true
					end

				else
					currentFrame = startFrame
					animFrames[currentFrame].isVisible = true
				end
			
			elseif (currentFrame > #animFrames) then
				currentFrame = 1
				animFrames[currentFrame].isVisible = true
			
			else
				animFrames[currentFrame].isVisible = true
			
			end
		end

	
		local function prevFrame( self, event )
			animFrames[currentFrame].isVisible = false
			currentFrame = currentFrame - 1
		
			if (currentFrame == endFrame - 1) then
				if (loop > 0) then
					loopCount = loopCount + 1

					if (loopCount == loop) then 
						-- stop looping
						currentFrame = currentFrame + 1
						animFrames[currentFrame].isVisible = true
						Runtime:removeEventListener( "enterFrame", self )

						if (remove) then
							-- delete self
							self.parent:remove(self)
						end

					else
						currentFrame = startFrame
						animFrames[currentFrame].isVisible = true
					end

				else
					currentFrame = startFrame
					animFrames[currentFrame].isVisible = true
				end
			
			elseif (currentFrame < 1) then
				currentFrame = #animFrames
				animFrames[currentFrame].isVisible = true
			
			else
				animFrames[currentFrame].isVisible = true
			
			end
		end
	
	
		local function dragMe(self, event)
			local onPress = self._onPress
			local onDrag = self._onDrag
			local onRelease = self._onRelease
	
			if event.phase == "began" then
				display.getCurrentStage():setFocus( self )
				startX = g.x
				startY = g.y
			
				if onPress then
					result = onPress( event )
				end
			
			elseif event.phase == "moved" then
	
				if transpose == true then
					-- Note: "transpose" is deprecated now that Corona supports native landscape mode
					-- dragBounds is omitted in transposed mode, but feel free to implement it
					if limitX ~= true then
						g.x = startX - (event.yStart - event.y)
					end
					if limitY ~= true then
						g.y = startY + (event.xStart - event.x)
					end
				else
					if limitX ~= true then
						g.x = startX - (event.xStart - event.x)
						if (dragBounds) then
							if (g.x < dragLeft) then g.x = dragLeft end
							if (g.x > dragLeft + dragWidth) then g.x = dragLeft + dragWidth end
						end
					end
					if limitY ~= true then
						g.y = startY - (event.yStart - event.y)
						if (dragBounds) then
							if (g.y < dragTop) then g.y = dragTop end
							if (g.y > dragTop + dragHeight) then g.y = dragTop + dragHeight end
						end
					end
				end

				if onDrag then
					result = onDrag( event )
				end
				
			elseif event.phase == "ended" then
				display.getCurrentStage():setFocus( nil )

				if onRelease then
					result = onRelease( event )
				end
			
			end
		
			-- stop touch from falling through to objects underneath
			return true
		end


		------------------------
		-- Define public methods

		function g:enterFrame( event )
			--mcx:log(g.progress)
			if (g.progress == 0) then
				self:repeatFunction( event )
				if (g.aspeed == nil) then
					--print(g.speed)
					g.progress = g.speed
				else
					g.progress = g.speed/g.aspeed
				end
			else
				--print("waiting")
				g.progress = g.progress - 1
			end
		end

		function g:play(params)
			Runtime:removeEventListener( "enterFrame", self )
			if ( params ) then
				-- if any parameters are submitted, assume this is a new sequence and reset all default values
				animFrames[currentFrame].isVisible = false
				resetDefaults()				
				inSequence = true
				-- apply optional parameters (with some boundary and type checking)
				if ( params.startFrame and type(params.startFrame) == "number" ) then startFrame=params.startFrame end
				if ( startFrame > #animFrames or startFrame < 1 ) then startFrame = 1 end
		
				if ( params.endFrame and type(params.endFrame) == "number" ) then endFrame=params.endFrame end
				if ( endFrame > #animFrames or endFrame < 1 ) then endFrame = #animFrames end
		
				if ( params.loop and type(params.loop) == "number" ) then loop=params.loop end
				if ( loop < 0 ) then loop = 0 end
			
				if ( params.remove and type(params.remove) == "boolean" ) then remove=params.remove end
				if params.loops == nil then
					loop = g.loops
				else
					loop = params.loops
				end
				loopCount = 0
				if (params.speed ~= nil) then
					g.aspeed = params.speed
				end
			else
				if (not inSequence) then
					animFrames[currentFrame].isVisible = false
					-- use default values
					startFrame = 1
					endFrame = #animFrames
					loop = g.loops
					loopCount = 0
					remove = false
				end			
			end
					
			currentFrame = startFrame
			animFrames[startFrame].isVisible = true 
		
			self.repeatFunction = nextFrame
			Runtime:addEventListener( "enterFrame", self )
		end
	
	
		function g:reverse( params )
			Runtime:removeEventListener( "enterFrame", self )
		
			if ( params ) then
				-- if any parameters are submitted, assume this is a new sequence and reset all default values
				animFrames[currentFrame].isVisible = false
				resetReverseDefaults()
				inSequence = true
				-- apply optional parameters (with some boundary and type checking)
				if ( params.startFrame and type(params.startFrame) == "number" ) then startFrame=params.startFrame end
				if ( startFrame > #animFrames or startFrame < 1 ) then startFrame = #animFrames end
		
				if ( params.endFrame and type(params.endFrame) == "number" ) then endFrame=params.endFrame end
				if ( endFrame > #animFrames or endFrame < 1 ) then endFrame = 1 end
		
				if ( params.loop and type(params.loop) == "number" ) then loop=params.loop end
				if ( loop < 0 ) then loop = 0 end
		
				if ( params.remove and type(params.remove) == "boolean" ) then remove=params.remove end
			else
				if (not inSequence) then
					-- use default values
					startFrame = #animFrames
					endFrame = 1
					loop = 0
					loopCount = 0
					remove = false
				end
			end
		
			currentFrame = startFrame
			animFrames[startFrame].isVisible = true 
		
			self.repeatFunction = prevFrame
			Runtime:addEventListener( "enterFrame", self )
		end

	
		function g:nextFrame()
			-- stop current sequence, if any, and reset to defaults
			Runtime:removeEventListener( "enterFrame", self )
			inSequence = false
		
			animFrames[currentFrame].isVisible = false
			currentFrame = currentFrame + 1
			if ( currentFrame > #animFrames ) then
				currentFrame = 1
			end
			animFrames[currentFrame].isVisible = true
		end
	
	
		function g:previousFrame()
			-- stop current sequence, if any, and reset to defaults
			Runtime:removeEventListener( "enterFrame", self )
			inSequence = false
		
			animFrames[currentFrame].isVisible = false
			currentFrame = currentFrame - 1
			if ( currentFrame < 1 ) then
				currentFrame = #animFrames
			end
			animFrames[currentFrame].isVisible = true
		end

		function g:currentFrame()
			return currentFrame
		end
	
		function g:totalFrames()
			return totalFrames
		end
	
		function g:stop()
			Runtime:removeEventListener( "enterFrame", self )
		end

		function g:stopAtFrame(label)
			-- This works for either numerical indices or optional text labels
			if (type(label) == "number") then
				Runtime:removeEventListener( "enterFrame", self )
				animFrames[currentFrame].isVisible = false
				currentFrame = label
				animFrames[currentFrame].isVisible = true
			
			elseif (type(label) == "string") then
				for k, v in next, animLabels do
					if (v == label) then
						Runtime:removeEventListener( "enterFrame", self )
						animFrames[currentFrame].isVisible = false
						currentFrame = k
						animFrames[currentFrame].isVisible = true
					end
				end
			end
		end

	
		function g:playAtFrame(label)
			-- This works for either numerical indices or optional text labels
			if (type(label) == "number") then
				Runtime:removeEventListener( "enterFrame", self )
				animFrames[currentFrame].isVisible = false
				currentFrame = label
				animFrames[currentFrame].isVisible = true
			
			elseif (type(label) == "string") then
				for k, v in next, animLabels do
					if (v == label) then
						Runtime:removeEventListener( "enterFrame", self )
						animFrames[currentFrame].isVisible = false
						currentFrame = k
						animFrames[currentFrame].isVisible = true
					end
				end
			end
			self.repeatFunction = nextFrame
			Runtime:addEventListener( "enterFrame", self )
		end


		function g:setDrag( params )
			if ( params ) then
				if params.drag == true then
					limitX = (params.limitX == true)
					limitY = (params.limitY == true)
					transpose = (params.transpose == true)
					dragBounds = nil
				
					if ( params.onPress and ( type(params.onPress) == "function" ) ) then
						g._onPress = params.onPress
					end
					if ( params.onDrag and ( type(params.onDrag) == "function" ) ) then
						g._onDrag = params.onDrag
					end
					if ( params.onRelease and ( type(params.onRelease) == "function" ) ) then
						g._onRelease = params.onRelease
					end
					if ( params.bounds and ( type(params.bounds) == "table" ) ) then
						dragBounds = params.bounds
						dragLeft = dragBounds[1]
						dragTop = dragBounds[2]
						dragWidth = dragBounds[3]
						dragHeight = dragBounds[4]
					end
				
					g.touch = dragMe
					g:addEventListener( "touch", g )
				
				else
					g:removeEventListener( "touch", g )
					dragBounds = nil
				
				end
			end
		end


		-- Optional function to assign text labels to frames
		function g:setLabels(labelTable)
			for k, v in next, labelTable do
				if (type(k) == "string") then
					animLabels[v] = k
				end
			end		
		end
	
		clips[name] = g
		mcx:insert(g)
		active = g
		animName = name
	end
	
	function mcx:log(msg)
		if debug == true then
			print("MCX_MSG: " .. msg)
		end
	end
	
	function mcx:play(params)
		if params ~= nil then
			if params.name == nil then
				name = animName
			else
				name = params.name
			end
			if params.speed == nil then
				speed = normalSpeed()
			else
				speed = params.speed
			end
			if params.loops == nil then
				loops = clips[name].loops
			else
				loops = params.loops
			end
		else
			name = animName
			speed = normalSpeed()
			loops = clips[name].loops
		end
		if name == nil and animName == nil then
			mcx:log("Error, no animation name given and no animations to be resumed.")
		else


			mcx:log("Playing " .. name)
			mcx:stop()
			active = clips[name]
			active.isVisible = true
			

			clips[name]:play({speed = speed, loops = loops})

			
			animName = name
			paused = false
		end
	end
	
	function mcx:stop()
		clips[animName]:stop()
		active.isVisible = false
		active = nil
		animName = nil
	end
	
	function mcx:pause()
		clips[animName]:stop()
		paused = true
		mcx:log("Paused " .. animName)
	end
	
	function mcx:isPaused()
		return paused
	end
	
	function mcx:isPlaying()
		if paused == true then
			return false
		end
		return true
	end

	function mcx:setLoops(name, loops)
		clips[name].loops = loops
	end
	
	function mcx:setSpeed(name, speed)
		clips[name].aspeed = speed
	end
	
	function mcx:currentFrame()
		return clips[animName]:currentFrame()
	end
	
	function mcx:togglePause()
		if paused then
			paused = false
			mcx:play()
		else
			paused = true
			mcx:pause()
		end
	end
	
	function mcx:currentAnimation()
		return animName
	end
	
	function mcx:enableDebugging()
		debug = true
	end
	
	function mcx:disableDebugging()
		debug = false
	end
		
	return mcx
end