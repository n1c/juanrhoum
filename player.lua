
local Player = {}
function Player:new(game)
  print('Player:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game
  o.type = ENTITY_TYPE_PLAYER
  o.color = PLAYER_COLOR
  o.body = love.physics.newBody(o.game.world, WORLD_SIZE / 2, WORLD_SIZE / 2, 'dynamic')
  o.shape = love.physics.newCircleShape(PLAYER_RADIUS)
  o.fixture = love.physics.newFixture(o.body, o.shape, 1)

  o.fixture:setUserData(o) -- deep
  o.fixture:setRestitution(0.8)
  o.body:setLinearDamping(10)
  o.body:setAngularDamping(8)

  o.angle = 0
  o.energy = 100
  o.last_dash = 0

  return o
end

function Player:getX()
  return self.body:getX()
end

function Player:getY()
  return self.body:getY()
end

function Player:update(dt)
  self.last_dash = self.last_dash + dt;

  self.angle = math.atan2(
    love.mouse.getY() - self:getY(),
    love.mouse.getX() - self:getX()
  )
  self.body:setAngle(self.angle)

  if love.mouse.isDown('l') then
    self.body:applyForce(
      PLAYER_MOVE_FORCE * dt * math.cos(self.angle),
      PLAYER_MOVE_FORCE * dt * math.sin(self.angle)
    )
  end

  if love.mouse.isDown('r') then
    if self.last_dash > PLAYER_MIN_DASH_WAIT then
      self.body:applyLinearImpulse(PLAYER_JUMP_IMPULSE * dt * math.cos(self.angle), PLAYER_JUMP_IMPULSE * dt * math.sin(self.angle))
      self.last_dash = 0;
    end
  end
end

function Player:draw(dt)
  love.graphics.setColor(self.color);
  local ex, ey = self.body:getWorldPoints(self.shape:getPoint())
  love.graphics.circle('fill', ex, ey, PLAYER_RADIUS, 100);
end

return Player
