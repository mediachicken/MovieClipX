require("movieclip")

mc = movieclip.new()
mc:newAnim("checks", {"check.png", "off.png"}, 12, 13)
mc:newAnim("icons", {"corona.png", "wordpress.png"}, 12, 13)

mc.x = display.contentWidth / 2
mc.y = display.contentHeight / 2


mc:play("icons")
mc:play("checks")