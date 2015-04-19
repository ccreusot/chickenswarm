love.graphics.setDefaultFilter("nearest") -- set le filtre d'affichage par defaut des images

local asset = require("sprite")
local Chicken = require("chicken")


local chickenPoule = {} -- le pull de poulet

function love.load()
	local sprite = love.graphics.newImage(asset.chicken)
	background = love.graphics.newImage(asset.background)

	addItemTo(Chicken:new(400, 300, sprite, 0, 45, 4, 4), chickenPoule)
	addItemTo(Chicken:new(200, 400, sprite, 0, 0, 4, 4), chickenPoule)
	addItemTo(Chicken:new(100, 500, sprite, 0, -45, 8, 8), chickenPoule)
	addItemTo(Chicken:new(200, 300, sprite, 0, 0, 3, 3), chickenPoule)
	addItemTo(Chicken:new(300, 500, sprite, 0, 130, 8, 8), chickenPoule)
	addItemTo(Chicken:new(150, 200, sprite, 0, -130, 16, 16), chickenPoule)
	addItemTo(Chicken:new(100, 350, sprite, 0, 90, 2, 2), chickenPoule)

	removeItemFrom(3, chickenPoule)

end

function love.update(delta_time)

end

function love.draw()
	love.graphics.draw(background, 0, 0, 0, 2.5)
	for k,v in ipairs(chickenPoule) do
		--print(k)
		v:draw()
	end
end






-- Rajoute un item dans une liste
-- item : l'item à rajouter
-- to : la liste dans laquelle on va rajouter l'item
function addItemTo(item, to)
	table.insert(to, item)
end

-- Retire un item d'une list
-- item : l'index de l'item dans la liste
-- from : liste dans laquel on va supprimer l'item
function removeItemFrom(item, from)
	table.remove(from, item)
end











