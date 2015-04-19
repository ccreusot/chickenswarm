local Farmer = {}

local utils = require("utils")


-- Methode de création de poulet
-- x : position en x de depart
-- y : position en y de depart
-- img : sprite
-- d : angle de rotation de depart en degré. default 0
-- sx : scaling en x du sprite. default 1
-- sy : scaling en y du sprite. default 1
function Farmer:new(x, y, img, d, sx, sy)
	newObj = {
		x= x,
		y= y,
		img= img,
		d= d, -- default 0
		sx= sx, --default 0
		sy= sy, --default 0
		t = 0,
	}
	if d == nil then d =0 end
	if sx == nil then sx =1 end
	if sy == nil then sy =1 end

	self.__index = self
	return setmetatable(newObj, self)
end

function Farmer:load()

end

function Farmer:draw()
	local offsetX = (self.img:getWidth() / 2)
	love.graphics.draw(self.img, self.x, self.y, self.d*raddeg, self.sx, self.sy, offsetX)
end


return Farmer
