
local Energy = require('energy')

local Energies = {}
function Energies:new(game)
  print('Energies:new')
  local o = {}
  setmetatable(o, self)
  self.__index = self
  o.game = game

  o.collection = {}
  o.last_spawn = 0;
  o.next_spawn = 10;

  return o
end

function Energies:update(dt)
  self.last_spawn = self.last_spawn + dt;

  -- Energies
  for i, e in pairs(self.collection) do
    if e.must_collect then
      e.body:destroy()
      table.remove(self.collection, i)
      self.game.player.energy = self.game.player.energy + ENERGY_BONUS
    end
  end

  -- Chance to spawn a new energy
  if self.last_spawn > self.next_spawn then
    self.last_spawn = 0
    self.next_spawn = math.random(1, ENERGY_SPAWN_DELAY)
    table.insert(self.collection, Energy:new(self.game))
  end
end

function Energies:draw(dt)
  for i, e in pairs(self.collection) do
    e:draw()
  end
end

return Energies
