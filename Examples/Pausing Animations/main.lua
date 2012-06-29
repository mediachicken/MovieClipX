require("mcx")

char = mcx.new()


char:newAnim("walk_right", {"walk_right_001.png",
													"walk_right_002.png",
													"walk_right_003.png",
													"walk_right_004.png"}, 96, 96, 5)
													


char.x = display.contentWidth / 2
char.y = display.contentHeight / 2


char:play("walk_right")

function touchEvent(event)
	if event.phase == "ended" then
		if char:isPaused() then
			char:play()
		else
			char:pause()
		end
	end
end

char:addEventListener( "touch", touchEvent )