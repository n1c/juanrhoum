
local Room = {}
function Room:new(game)
  print('Room:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game
  o.color = ROOM_COLOR

  o:respawn()

  return o
end

function Room:respawn()
  self.radius = ROOM_RADIUS
  self.x = WORLD_SIZE / 2
  self.y = WORLD_SIZE / 2
end

function Room:getRadius()
  return self.radius
end

function Room:getX()
  return self.x
end

function Room:getY()
  return self.y
end

function Room:updatePlayerIsOver(dt)
  self.radius = self.radius + (ROOM_GROWTH_STEP * dt)
end

function Room:updatePlayerNotOver(dt)
  self.radius = self.radius - (ROOM_SHRINK_STEP * dt)
end

function Room:updateSpiderHit(dt)
  self.radius = self.radius - (ROOM_SHRINK_SPIDER_HIT * dt)
end

function Room:isTooSmall()
  if (self.radius < ROOM_MIN_RADIUS) then
    return true
  else
    return false
  end
end

function Room:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle('fill', self:getX(), self:getY(), self:getRadius(), 100)
end

return Room
