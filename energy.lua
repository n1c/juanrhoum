
local Energy = {}
function Energy:new(game)
  print('Energy:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game
  o.type = ENTITY_TYPE_ENERGY
  o.color = ENERGY_COLOR
  o.body = love.physics.newBody(o.game.world, math.random(WORLD_SIZE), math.random(WORLD_SIZE), 'dynamic')
  o.shape = love.physics.newCircleShape(ENERGY_RADIUS)
  o.fixture = love.physics.newFixture(o.body, o.shape, 2)

  o.fixture:setUserData(o) -- deep
  o.must_collect = false

  return o
end

function Energy:draw(dt)
  love.graphics.setColor(self.color)
  local ex, ey = self.body:getWorldPoints(self.shape:getPoint())
  love.graphics.circle('fill', ex, ey, ENERGY_RADIUS, 100);
end

return Energy
