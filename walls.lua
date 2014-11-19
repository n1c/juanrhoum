
local Wall = require('wall')

local Walls = {}
function Walls:new(game)
  print('Walls:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self

  o.game = game

  o.collection = {
    Wall:new(o.game, WORLD_SIZE / 2, 0, WORLD_SIZE, WALL_THICKNESS),
    Wall:new(o.game, WORLD_SIZE, WORLD_SIZE / 2, WALL_THICKNESS, WORLD_SIZE),
    Wall:new(o.game, WORLD_SIZE / 2, WORLD_SIZE, WORLD_SIZE, WALL_THICKNESS),
    Wall:new(o.game, 0, WORLD_SIZE / 2, WALL_THICKNESS, WORLD_SIZE),
  }

  return o
end

function Walls:draw(dt)
  -- draw walls
  for i, w in pairs(self.collection) do
    w:draw()
  end
end

return Walls
