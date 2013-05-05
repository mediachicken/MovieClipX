require("mcx")
widget = require("widget")

john = mcx.new()
tom = mcx.new()

timeline = mcx.newTimeline()
timeline:addObject(john)
timeline:addObject(tom)


walk_left = mcx.sequence({name = "walk_left_", extension = "png", endFrame = 4, zeros = 3})
walk_right = mcx.sequence({name = "walk_right_", extension = "png", endFrame = 4, zeros = 3})
walk_up = mcx.sequence({name = "walk_up_", extension = "png", endFrame = 4, zeros = 3})
walk_down = mcx.sequence({name = "walk_down_", extension = "png", endFrame = 4, zeros = 3})

john:newAnim("walk_left", walk_left, 48, 48)
tom:newAnim("walk_right", walk_right, 48, 48)

john.x = display.contentWidth / 2
john.y = display.contentHeight / 2

tom.x = display.contentWidth / 3
tom.y = display.contentHeight / 3


john:play({name = "walk_left"})
tom:play({name = "walk_right"})


local t = display.newText( "Push a button to control the timeline", 0, 0, "AmericanTypewriter-Bold", 16 )
t.x, t.y = display.contentCenterX, 70


local slowDownPress = function( event )
	if (timeline:getSpeed() == mcx.halfSpeed()) then
		t.text = "Normal Speed"
		timeline:alterTime(mcx.normalSpeed())
	else
		t.text = "Half Speed"
		timeline:alterTime(mcx.halfSpeed())
	end
end

local togglePausePress = function( event )
	timeline:togglePause()
end

local slowDown = widget.newButton{
	default = "buttonRed.png",
	over = "buttonRedOver.png",
	onPress = slowDownPress,
	label = "Change Speed",
	emboss = true
}

local togglePause = widget.newButton{
	default = "buttonRed.png",
	over = "buttonRedOver.png",
	onPress = togglePausePress,
	label = "Toggle Pause",
	emboss = true
}

slowDown.x = display.contentWidth / 2
slowDown.y = display.contentHeight - 100

togglePause.x = display.contentWidth / 2
togglePause.y = display.contentHeight - 35

function touchEvent(event)
	if event.phase == "ended" then
		-- you can now use john:togglePause() to toggle between play/pause
		-- however, the method below shows both the use of play/pause and
		-- using isPaused() to grab the current state.
		--john:setLoops("walk_right", 2)
		if john:isPaused() then
			john:play({name = "walk_left", speed = mcx.normalSpeed(), loops = 5})
		else
			john:pause()
		end
	end
end

john:addEventListener( "touch", touchEvent )



