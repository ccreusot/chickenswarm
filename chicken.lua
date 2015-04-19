local Chicken = {}
--local sprite = require("sprite")
local utils = require("utils")


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
		t = 0,
		r = img:getWidth()*sx/2,
		cr = 0.2*img:getWidth()*sx/2
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
	local offsetX = (self.img:getWidth() / 2)
	love.graphics.draw(self.img, self.x, self.y, self.d*raddeg, self.sx, self.sy, offsetX)
end

function Chicken:update(delta_time)
	--local distance = utils.point_distance(self.x, self.y, mouse_x, mouse_y)
	if mouse_x < self.x and self.sx > 0 then self.sx = -self.sx
	elseif mouse_x > self.x and self.sx < 0 then self.sx = -self.sx
	end
	--self.sx = -1 * (mouse_x-self.x)
	local increment = math.deg(12)
	local amplitude = 2	
	self.t = self.t + increment * delta_time
	local shift = amplitude * math.sin(self.t)
	--if distance >= 1 then
		local direction = utils.point_direction(self.x, self.y, mouse_x, mouse_y)
		if (direction < 45 and direction > -45) or direction < -135 or direction > 135 then
			self.x = self.x + utils.lengthdir_x(direction, self.speed) + utils.lengthdir_x(direction + 90, shift)
			self.y = self.y + utils.lengthdir_y(direction, self.speed) + utils.lengthdir_y(direction + 90, shift)
		else
			self.x = self.x + utils.lengthdir_x(direction, self.speed) + utils.lengthdir_y(direction + 90, shift)
			self.y = self.y + utils.lengthdir_y(direction, self.speed) + utils.lengthdir_x(direction + 90, shift)
		end
	--end
end

-- c : le chicken à comparer avec self
function Chicken:collide(c, delta_time)
	if utils.circles_collision(self.x, self.y, self.r, c.x, c.y, c.cr) then
		local direction = utils.point_direction(self.x, self.y, c.x, c.y)
		c.x = c.x + utils.lengthdir_x(direction, c.cr)
		c.y = c.y + utils.lengthdir_y(direction, c.cr)
	end
	if c.x == self.x then c.x = c.x+1 end
	if c.y == self.y then c.y = c.y+1 end
end


return Chicken
