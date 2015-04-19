love.graphics.setDefaultFilter("nearest") -- set le filtre d'affichage par defaut des images

local utils = require("utils")
local asset = require("sprite")
local sound = require("sound")
local Chicken = require("chicken")
local Farmer = require("farmer")
local Zombie = require("zombie")
local Seed = require("seed")

mouse_x = 0
mouse_y = 0

local zombieQuads = {} -- l'ensemble des quads de l'image zombie
local chickenPoule = {} -- le pull de poulet
local farmerPoule = 0 -- le fermier
local seedPoule = 0 -- seeds
local background = nil

function love.load()
	bgm = love.audio.newSource(sound.bg, "stream")
	love.audio.setVolume( 1 )
	love.audio.play(bgm)
	bgm:setLooping( 1 )

	local spritePoulet = love.graphics.newImage(asset.chicken) -- et mon Q c'est du poulet?
	local soundPoulet = love.audio.newSource(sound.cot, "static")
	local spriteFermier = love.graphics.newImage(asset.farmer)
	local spriteZombie = love.graphics.newImage(asset.zombie)
	local spriteSeed = love.graphics.newImage(asset.seed)
	background = love.graphics.newImage(asset.background)

	-- seed
	seedPoule = Seed:new(400, 300, spriteSeed, 0, 3, 3, false)


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

	zombie = Zombie:new(700, 400, spriteZombie, zombieQuads, 0.15, 0, 5, 5)
	zombie:setTarget(farmerPoule)
end

function love.mousepressed(x, y, button)
	if button == 'l' then
		farmerPoule:launchAnimation()
		seedPoule.x = x
		seedPoule.y = y
		seedPoule.active = true
	end
end

function love.update(delta_time)
	if love.mouse.isDown('l') then
		mouse_x = love.mouse.getX()
		mouse_y = love.mouse.getY()
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
	end
	farmerPoule:update(delta_time)
	zombie:update(delta_time)
end

function love.draw()
	love.graphics.draw(background, 0, 0, 0, 2.5)
	seedPoule:draw()
	farmerPoule:draw()
	zombie:draw()

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











