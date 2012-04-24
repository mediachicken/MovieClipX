require("mcx")

char = mcx.new()
char:newAnim("walk_forward", {"walk_001.png", "walk_002.png", "walk_003.png", "walk_004.png"}, 85, 85, 3)
char:newAnim("walk_backward", {"walk_004.png", "walk_003.png", "walk_002.png", "walk_001.png"}, 85, 85, 3)

char.x = display.contentWidth / 2
char.y = display.contentHeight / 2


char:play("walk_forward")


function touchEvent(event)
	if event.phase == "ended" then
		if char:currentAnimation() == "walk_forward" then
			char:play("walk_backward")
		else
			char:play("walk_forward")
		end
	end
end

char:addEventListener( "touch", touchEvent )