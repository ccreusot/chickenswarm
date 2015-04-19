local Farmer = {}

local utils = require("utils")


-- Methode de création de poulet
-- x : position en x de depart
-- y : position en y de depart
-- img : sprite
-- d : angle de rotation de depart en degré. default 0
-- sx : scaling en x du sprite. default 1
-- sy : scaling en y du sprite. default 1
function Farmer:new(x, y, img, quads, d, sx, sy)
	newObj = {
		x= x,
		y= y,
		img= img,
		quads= quads,
		d= d, -- default 0
		sx= sx, --default 0
		sy= sy, --default 0
		index_img= 1,
		animate= false
	}
	if d == nil then newObj.d =0 end
	if sx == nil then newObj.sx =1 end
	if sy == nil then newObj.sy =1 end

	self.__index = self
	return setmetatable(newObj, self)
end

function Farmer:load()

end

function Farmer:launchAnimation()
	self.index_img = 1
	self.animate= true
end

function Farmer:update(delta_time)
	if self.animate then
		self.index_img = (self.index_img + 20 * delta_time)
		if (self.index_img > #self.quads or self.index_img < 1) then
			self.index_img = 1
			self.animate = false
		end
	end
end

function Farmer:draw()
	local x, y, w, h = self.quads[math.floor(self.index_img)]:getViewport()
	local offsetX = (w / 2)
	love.graphics.draw(self.img, self.quads[math.floor(self.index_img)], self.x, self.y, self.d*raddeg, self.sx, self.sy, offsetX)
end


return Farmer
