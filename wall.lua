
local Wall = {}
function Wall:new(game, x, y, w, h)
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game
  o.type = ENTITY_TYPE_WALL
  o.color = WALL_COLOR
  o.body = love.physics.newBody(o.game.world, x, y, 'static')
  o.shape = love.physics.newRectangleShape(w, h)
  o.fixture = love.physics.newFixture(o.body, o.shape, 1)
  o.fixture:setUserData(o) -- deep

  return o
end

function Wall:draw(dt)
  love.graphics.setColor(self.color)
  love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

return Wall
