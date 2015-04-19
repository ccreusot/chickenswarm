local Chicken = {}

local utils = require("utils")


-- Methode de création de poulet
-- x : position en x de depart
-- y : position en y de depart
-- img : sprite
-- speed : vitesse de depart. default 0
-- d : angle de rotation de depart en degré. default 0
-- sx : scaling en x du sprite. default 1
-- sy : scaling en y du sprite. default 1
function Chicken:new(x, y, img, speed, d, sx, sy, sound, power)
	newObj = {
		x= x,
		y= y,
		img= img,
		speed= speed, -- default 0
		d= d, -- default 0
		sx= sx, --default 0
		sy= sy, --default 0
		sound= sound, -- default nil
		t = 0,
		r = img:getWidth()*sx/2,
		cr = 0.2*img:getWidth()*sx/2,
		power= power
	}
	
	if speed == nil then speed =0 end
	if d == nil then d =0 end
	if sx == nil then sx =1 end
	if sy == nil then sy =1 end
	if power == nil then power =1 end

	self.__index = self
	return setmetatable(newObj, self)
end



function Chicken:load()

end

function Chicken:draw()
	local offsetX = (self.img:getWidth() / 2)
	love.graphics.draw(self.img, self.x, self.y, self.d*raddeg, self.sx, self.sy, offsetX)
end

function Chicken:update(delta_time)
	love.audio.play(self.sound)
	if mouse_x < self.x and self.sx > 0 then self.sx = -self.sx
	elseif mouse_x > self.x and self.sx < 0 then self.sx = -self.sx
	end

	local increment = math.deg(12)
	local amplitude = 2	
	self.t = self.t + increment * delta_time
	local shift = amplitude * math.sin(self.t)

	local direction = utils.point_direction(self.x, self.y, mouse_x, mouse_y)
	if (direction < 45 and direction > -45) or direction < -135 or direction > 135 then
		self.x = self.x + utils.lengthdir_x(direction, self.speed) + utils.lengthdir_x(direction + 90, shift)
		self.y = self.y + utils.lengthdir_y(direction, self.speed) + utils.lengthdir_y(direction + 90, shift)
	else
		self.x = self.x + utils.lengthdir_x(direction, self.speed) + utils.lengthdir_y(direction + 90, shift)
		self.y = self.y + utils.lengthdir_y(direction, self.speed) + utils.lengthdir_x(direction + 90, shift)
	end

	if self.x > love.window.getWidth() then self.x = love.window.getWidth() end
	if self.x < 0 then self.x = 0 end
	if self.y > love.window.getHeight() - 60 then self.y = love.window.getHeight() - 60 end
	if self.y < 20 then self.y = 20 end

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


function Chicken:collideZ(z, delta_time)
	print(zombiePoule)
	if z == nil then return end
	if utils.circles_collision(self.x, self.y, self.r, z.x, z.y, z.cr) then
		z.hp = z.hp - self.power
	end
	if z.hp <= 0 then
		for k,v in ipairs(zombiePoule) do if v == z then zombiePoule.remove( k ) return end end

	end
end



return Chicken
