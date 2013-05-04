require("mcx")

char = mcx.new()
-- enable debugging
char:enableDebugging()

char:newAnim("walk_left", 
			mcx.sequence({name = "walk_left_",
				extension = "png",
				endFrame = 4,
				zeros = 3}),
			48, 48)

char:newAnim("walk_right", 
			mcx.sequence({name = "walk_right_",
				extension = "png",
				endFrame = 4,
				zeros = 3}),
			48, 48)
													
char:newAnim("walk_up", 
			mcx.sequence({name = "walk_down_",
				extension = "png",
				endFrame = 4,
				zeros = 3}),
			48, 48)
													

char:newAnim("walk_down", 
			mcx.sequence({name = "walk_down_",
				extension = "png",
				endFrame = 4,
				zeros = 3}),
			48, 48)												

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