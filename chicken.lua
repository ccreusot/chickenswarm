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
		t = 0
		direction = 0
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

function Chicken:update(delta_time)
	local distance = utils.point_distance(self.x, self.y, mouse_x, mouse_y)
	local increment = math.deg(12)
	local amplitude = 2

	t = t + increment * delta_time
	local shift = amplitude * math.sin(t)
	if distance >= 1 then
		if (direction < 45 and direction > -45) or direction < -135 or direction > 135 then
			self.x = self.x + utils.lengthdir_x(direction, 1) + utils.lengthdir_x(direction + 90, shift)
			self.y = self.y + utils.lengthdir_y(direction, 1) + utils.lengthdir_y(direction + 90, shift)
		else
			self.x = self.x + utils.lengthdir_x(direction, 1) + utils.lengthdir_y(direction + 90, shift)
			self.y = self.y + utils.lengthdir_y(direction, 1) + utils.lengthdir_x(direction + 90, shift)
		end
	end
end

return Chicken
