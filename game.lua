
local Game = {}
function Game:new()
  print('Game:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.status = 'new'

  love.physics.setMeter(WORLD_METER)
  o.world = love.physics.newWorld(0, 0, true)
  o.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  o.walls = require('walls'):new(o)
  o.player = require('player'):new(o)
  o.room = require('room'):new(o)
  o.spiders = require('spiders'):new(o)
  o.energies = require('energies'):new(o)
  o.survival_time = 0

  return o
end

function Game:update(dt)
  if love.keyboard.isDown('escape') then love.event.quit() end
  self.survival_time = self.survival_time + dt
  self.player:update(dt)
  self.spiders:update(dt)
  self.energies:update(dt)

  if math.dist(self.player:getX(), self.player:getY(), self.room:getX(), self.room:getY()) < self.room:getRadius() then
    if self.player.energy > 0 then
      self.player.energy = self.player.energy - ENERGY_COST;
      self.room:updatePlayerIsOver(dt)
    end
  else
    self.room:updatePlayerNotOver(dt)
  end

  if self.room:isTooSmall() then
    self.status = 'over'
    -- self.room:respawn()
  end

  self.world:update(dt)
end

function Game:draw()
  self.walls:draw()
  self.room:draw()
  self.player:draw()
  self.spiders:draw()
  self.energies:draw()

  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Juan Rhoum has survived for " .. math.ceil(self.survival_time) .. " seconds", 10, 10)
  love.graphics.print("Energy: " .. self.player.energy, 10, 25)
end -- draw

-- Contact callbacks
function beginContact(a, b, coll)
  if a:getUserData().type and b:getUserData().type then
    -- print('collide ' .. a:getUserData().type .. ' - ' ..  b:getUserData().type)
  end

  if a:getUserData().type == ENTITY_TYPE_PLAYER and b:getUserData().type == ENTITY_TYPE_ENERGY then
    b:getUserData().must_collect = true -- mark this energy for collection
  end

  if a:getUserData().type == ENTITY_TYPE_WALL and b:getUserData().type == ENTITY_TYPE_SPIDER then
    b:getUserData().must_die = true
  end
end

return Game
