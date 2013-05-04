require("mcx")

char = mcx.new()
-- enable debugging
char:enableDebugging()

char:newAnim("walk_right", {"walk_right_001.png",
													"walk_right_002.png",
													"walk_right_003.png",
													"walk_right_004.png"}, 48, 48, {speed = 5, loops = 2})
													


char.x = display.contentWidth / 2
char.y = display.contentHeight / 2


char:play("walk_right")

function touchEvent(event)
	if event.phase == "ended" then
		-- you can now use char:togglePause() to toggle between play/pause
		-- however, the method below shows both the use of play/pause and
		-- using isPaused() to grab the current state.
		if char:isPaused() then
			-- set the number of times to loop the animation
			-- you can also set this parameter inside the play() function
			char:setLoops("walk_right", 5)
			char:play()
		else
			char:pause()
		end
	end
end

char:addEventListener( "touch", touchEvent )