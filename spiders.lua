
local Spider = require('spider')

local Spiders = {}
function Spiders:new(game)
  print('Spiders:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game

  o.collection = {}
  o.last_spawn = 0;
  o.next_spawn = 3;

  return o
end

function Spiders:update(dt)
  self.last_spawn = self.last_spawn + dt;

  -- Spiders
  for i, s in pairs(self.collection) do
    if s.must_die then
      s.body:destroy()
      table.remove(self.collection, i)
    elseif math.dist(s.body:getX(), s.body:getY(), self.game.room:getX(), self.game.room:getY()) < (self.game.room:getRadius() + SPIDER_RADIUS) then
      -- is the spider in the room?
      s.body:destroy()
      table.remove(self.collection, i)
      self.game.room:updateSpiderHit(dt)
    else
      -- move towards the room
      local angle_to_room = math.atan2(
        self.game.room:getY() - s.body:getY(),
        self.game.room:getX() - s.body:getX()
      )

      s.body:applyForce(
        SPIDER_MOVE_FORCE * dt * math.cos(angle_to_room),
        SPIDER_MOVE_FORCE * dt * math.sin(angle_to_room)
      )
    end
  end

  -- Chance to spawn a new spider
  if self.last_spawn > self.next_spawn then
    self.last_spawn = 0
    self.next_spawn = math.random(1, SPIDER_SPAWN_DELAY)
    table.insert(self.collection, Spider:new(self.game))
  end
end

function Spiders:draw(dt)
  for i, s in pairs(self.collection) do
    s:draw()
  end
end

return Spiders
