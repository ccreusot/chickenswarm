local Chicken = {}
--local sprite = require("sprite")



-- Methode de création de poulet
-- x : position en x de depart
-- y : position en y de depart
-- img : sprite
-- speed : vitesse de depart. default 0
-- d : angle de rotation de depart en degré. default 0
-- sx : scaling en x du sprite. default 1
-- sy : scaling en y du sprite. default 1
function Chicken:new(x, y, img, speed, d, sx, sy)
	newObj = {
		x= x,
		y= y,
		img= img,
		speed= speed, -- default 0
		d= d, -- default 0
		sx= sx, --default 0
		sy= sy, --default 0
	}
	if speed == nil then speed =0 end
	if d == nil then d =0 end
	if sx == nil then sx =1 end
	if sy == nil then sy =1 end

	self.__index = self
	return setmetatable(newObj, self)
end



function Chicken:load()
--	img = love.graphics.newImage(sprite.chicken)
--	img:setFilter("nearest")
end

function Chicken:draw()
	love.graphics.draw(self.img, self.x, self.y, self.d*raddeg, self.sx, self.sy)
end


return Chicken
