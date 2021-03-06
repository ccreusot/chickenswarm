local Zombie = {}

local utils = require("utils")

-- Methode de création de poulet
-- x : position en x de depart
-- y : position en y de depart
-- img : sprite
-- speed : vitesse de depart. default 0
-- d : angle de rotation de depart en degré. default 0
-- sx : scaling en x du sprite. default 1
-- sy : scaling en y du sprite. default 1
function Zombie:new(x, y, img, quads, speed, d, sx, sy, hp)
	newObj = {
		x= x,
		y= y,
		img= img,
		quads= quads,
		speed= speed, -- default 0
		d= d, -- default 0
		sx= sx, --default 0
		sy= sy, --default 0
		r = img:getWidth()*sx/2,
		cr = 0.2*img:getWidth()*sx/2,
		direction= 0,
		target= nil,
		index_img= 1,
		hp= hp
	}

	if direction == nil then newObj.direction =0 end
	if speed == nil then newObj.speed =0 end
	if d == nil then newObj.d =0 end
	if sx == nil then newObj.sx =1 end
	if sy == nil then newObj.sy =1 end
	if hp == nil then newObj.hp =1 end

	self.__index = self
	return setmetatable(newObj, self)
end



function Zombie:load()

end

function Zombie:draw()
	local x, y, w, h = self.quads[math.floor(self.index_img)]:getViewport()
	local offsetX = (w / 2)
	love.graphics.draw(self.img, self.quads[math.floor(self.index_img)], self.x, self.y, self.d*raddeg, self.sx, self.sy, offsetX)
end

function Zombie:update(delta_time)
	if not (self.target == nil) then
		if self.target.x < self.x and self.sx > 0 then
			self.sx = -self.sx
		elseif self.target.x > self.x and self.sx < 0 then
			self.sx = math.abs(self.sx)
		end
	end

	self.index_img = (self.index_img + 10 * delta_time)
	if (self.index_img > #self.quads or self.index_img < 1) then
		self.index_img = 1
	end

	self.x = self.x + utils.lengthdir_x(self.direction, self.speed)
	self.y = self.y + utils.lengthdir_y(self.direction, self.speed)
end

-- c : le Zombie à comparer avec self
function Zombie:collide(c, delta_time)
	if utils.circles_collision(self.x, self.y, self.r, c.x, c.y, c.cr) then
		local direction = utils.point_direction(self.x, self.y, c.x, c.y)
		c.x = c.x + utils.lengthdir_x(direction, c.cr)
		c.y = c.y + utils.lengthdir_y(direction, c.cr)
	end
	if c.x == self.x then c.x = c.x+1 end
	if c.y == self.y then c.y = c.y+1 end
end

-- give a target
function Zombie:setTarget(target)
	self.target = target
	self.direction = utils.point_direction(self.x, self.y, self.target.x, self.target.y)
end

function Zombie:die()

	local index = 0
	for k, v in ipairs(zombiePoule) do
		if v == self then
			index = k
		end
	end
	table.remove(zombiePoule, index)
	self = nil
	collectgarbage("collect")
end

return Zombie
