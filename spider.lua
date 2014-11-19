
local Spider = {}
function Spider:new(game)
  print('Spider:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game
  o.type = ENTITY_TYPE_SPIDER
  o.color = SPIDER_COLOR
  local spawnx, spawny = unpack(random_spawn())
  o.body = love.physics.newBody(o.game.world, spawnx, spawny, 'dynamic')
  o.shape = love.physics.newCircleShape(SPIDER_RADIUS)
  o.fixture = love.physics.newFixture(o.body, o.shape, 2)

  o.body:setBullet(true)
  o.fixture:setUserData(o) -- deep
  o.must_die = false

  return o
end

function Spider:draw(dt)
  love.graphics.setColor(self.color)
  local ex, ey = self.body:getWorldPoints(self.shape:getPoint())
  love.graphics.circle('fill', ex, ey, SPIDER_RADIUS, 100);
end

function random_spawn()
  local direction = math.random(4)
  local position = math.random(WORLD_SIZE)

  if direction == 1 then -- top
    return { position, WALL_THICKNESS*3 }
  elseif direction == 2 then -- right
    return { WORLD_SIZE - WALL_THICKNESS*3, position }
  elseif direction == 3 then -- bottom
    return { position, WORLD_SIZE - WALL_THICKNESS*3 }
  else -- left
    return { WALL_THICKNESS*3, position }
  end
end

return Spider
