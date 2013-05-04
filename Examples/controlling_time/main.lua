require("mcx")

char = mcx.new()
-- enable debugging
char:enableDebugging()

char:newAnim("walk_right", {"walk_right_001.png",
													"walk_right_002.png",
													"walk_right_003.png",
													"walk_right_004.png"}, 48, 48)
													


char.x = display.contentWidth / 2
char.y = display.contentHeight / 2


char:play("walk_right")

function touchEvent(event)
	if event.phase == "ended" then

		if char:isPaused() then
			-- we use mcx.halfSpeed() to play the animation at half speed
			-- and loop it twice
			char:play({name = "walk_right", speed = mcx.halfSpeed(), loops = 2})
		else
			char:pause()
		end
	end
end

char:addEventListener( "touch", touchEvent )