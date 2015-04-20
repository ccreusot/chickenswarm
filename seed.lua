local Seed = {}

local utils = require("utils")


-- Methode de création de poulet
-- x : position en x de depart
-- y : position en y de depart
-- img : sprite
-- speed : vitesse de depart. default 0
-- d : angle de rotation de depart en degré. default 0
-- sx : scaling en x du sprite. default 1
-- sy : scaling en y du sprite. default 1
function Seed:new(x, y, img, d, sx, sy, active)
	newObj = {
		x= x,
		y= y,
		img= img,
		d= d, -- default 0
		sx= sx, --default 0
		sy= sy, --default 0
		r = img:getWidth()*sx/2,
		cr = 0.2*img:getWidth()*sx/2
	}

	if d == nil then newObj.d =0 end
	if sx == nil then newObj.sx =1 end
	if sy == nil then newObj.sy =1 end

	self.__index = self
	return setmetatable(newObj, self)
end

function Seed:draw()
	local offsetX = (self.img:getWidth() / 2)
	love.graphics.draw(self.img, self.x, self.y, self.d*raddeg, self.sx, self.sy, offsetX)
end

function Seed:update(delta_time)

end

-- c : le chicken à comparer avec self
function Seed:collide(c, delta_time)
	if utils.circles_collision(self.x, self.y, self.r, c.x, c.y, c.cr) then
		local direction = utils.point_direction(self.x, self.y, c.x, c.y)
		c.x = c.x + utils.lengthdir_x(direction, c.cr)
		c.y = c.y + utils.lengthdir_y(direction, c.cr)
	end
	if c.x == self.x then c.x = c.x+1 end
	if c.y == self.y then c.y = c.y+1 end
end


return Seed
