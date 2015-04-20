love.graphics.setDefaultFilter("nearest") -- set le filtre d'affichage par defaut des images

local utils = require("utils")
local asset = require("sprite")
local sound = require("sound")
local Chicken = require("chicken")
local Farmer = require("farmer")
local Zombie = require("zombie")
local Seed = require("seed")

mouse_x = 400
mouse_y = 300

local zombieQuads = {} -- l'ensemble des quads de l'image zombie
local chickenPoule = {} -- le pull de poulets
zombiePoule = {} -- le pull de zombies
local farmerPoule = 0 -- le fermier
local seedPoule = 0 -- seeds
local background = nil

function love.load()
	bgm = love.audio.newSource(sound.bg, "stream")
	love.audio.setVolume( 0.5 )
	love.audio.play(bgm)
	bgm:setLooping( 1 )

	local spritePoulet = love.graphics.newImage(asset.chicken) -- et mon Q c'est du poulet?
	local soundPoulet = love.audio.newSource(sound.cot, "static")
	local spriteFermier = love.graphics.newImage(asset.farmer)
	local spriteZombie = love.graphics.newImage(asset.zombie)
	local spriteSeed = love.graphics.newImage(asset.seed)
	background = love.graphics.newImage(asset.background)

	-- seed
	seedPoule = Seed:new(400, 300, spriteSeed, 0, 3, 3)


	-- Zombie quads for animations
	table.insert(zombieQuads, love.graphics.newQuad(0, 0, 16, 16, spriteZombie:getWidth(), spriteZombie:getHeight()))
	table.insert(zombieQuads, love.graphics.newQuad(16, 0, 16, 16, spriteZombie:getWidth(), spriteZombie:getHeight()))
	table.insert(zombieQuads, love.graphics.newQuad(32, 0, 16, 16, spriteZombie:getWidth(), spriteZombie:getHeight()))
	table.insert(zombieQuads, love.graphics.newQuad(48, 0, 16, 16, spriteZombie:getWidth(), spriteZombie:getHeight()))

	-- Chicken flock
	addItemTo(Chicken:new(400, 300, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)
	addItemTo(Chicken:new(200, 400, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)
	addItemTo(Chicken:new(100, 500, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)
	addItemTo(Chicken:new(200, 300, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)
	addItemTo(Chicken:new(300, 500, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)
	addItemTo(Chicken:new(300, 500, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)
	addItemTo(Chicken:new(300, 500, spritePoulet, 1.5, 0, 2, 2, soundPoulet), chickenPoule)

	-- fermier quads
	local fermierQuads = {}
	table.insert(fermierQuads, love.graphics.newQuad(0, 0, 16, 16, spriteFermier:getWidth(), spriteFermier:getHeight()))
	table.insert(fermierQuads, love.graphics.newQuad(16, 0, 16, 16, spriteFermier:getWidth(), spriteFermier:getHeight()))
	table.insert(fermierQuads, love.graphics.newQuad(32, 0, 16, 16, spriteFermier:getWidth(), spriteFermier:getHeight()))
	table.insert(fermierQuads, love.graphics.newQuad(48, 0, 16, 16, spriteFermier:getWidth(), spriteFermier:getHeight()))

	farmerPoule = Farmer:new(400, 0, spriteFermier, fermierQuads, 0, 5, 5)

	addItemTo(Zombie:new(700, 400, spriteZombie, zombieQuads, 0.15, 0, 5, 5, 1), zombiePoule)
	for k,v in ipairs(zombiePoule) do
		v:setTarget(farmerPoule)
	end

end

-- event triggered when mouse is pressed
function love.mousepressed(x, y, button)
	if button == 'l' then
		farmerPoule:launchAnimation()
		seedPoule.x = x
		seedPoule.y = y
		mouse_x = x
		mouse_y = y
	end
end

function love.update(delta_time)
	for k,v in ipairs(zombiePoule) do
		--print(k)
		v:update(delta_time)
	end
	for k,v in ipairs(chickenPoule) do
		if #zombiePoule > 0 then
			for k2, v2 in ipairs(zombiePoule) do
				v:collideZ(v2)
			end
		end
	end
	for k,v in ipairs(chickenPoule) do
		v:update(delta_time)
	end
	
			
	for k,v in ipairs(chickenPoule) do
		for k2, v2 in ipairs(chickenPoule) do
			if not (k == k2) then
				v:collide(v2)
			end
		end
	end
	farmerPoule:update(delta_time)
end

function love.draw()
	love.graphics.draw(background, 0, 0, 0, 2.5)
	seedPoule:draw()
	farmerPoule:draw()

	for k,v in ipairs(chickenPoule) do
		--print(k)
		v:draw()
	end
	for k,v in ipairs(zombiePoule) do
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












