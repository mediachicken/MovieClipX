require("mcx")

char = mcx.new()
-- enable debugging
char:enableDebugging()

char:newAnim("walk_left", {"walk_left_001.png",
													"walk_left_002.png",
													"walk_left_003.png",
													"walk_left_004.png"}, 48, 48)

char:newAnim("walk_right", {"walk_right_001.png",
													"walk_right_002.png",
													"walk_right_003.png",
													"walk_right_004.png"}, 48, 48)
													
char:newAnim("walk_up", {"walk_up_001.png",
													"walk_up_002.png",
													"walk_up_003.png",
													"walk_up_004.png"}, 48, 48)
													

char:newAnim("walk_down", {"walk_down_001.png",
													"walk_down_002.png",
													"walk_down_003.png",
													"walk_down_004.png"}, 48, 48)												

char.x = display.contentWidth / 2
char.y = display.contentHeight / 2


char:play("walk_left")

function touchEvent(event)
	if event.phase == "ended" then
		if char:currentAnimation() == "walk_down" then
			char:play({name = "walk_left"})
		elseif char:currentAnimation() == "walk_left" then
			char:play({name = "walk_right"})
		elseif char:currentAnimation() == "walk_right" then
			char:play({name = "walk_up"})
		else
			char:play({name = "walk_down"})
		end
	end
end

char:addEventListener( "touch", touchEvent )