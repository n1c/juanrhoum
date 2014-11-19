
require('util')
local Game = require('game')

WORLD_SIZE = 800
WORLD_METER = 64

ROOM_RADIUS = 100
ROOM_MIN_RADIUS = 30
ROOM_GROWTH_STEP = 20
ROOM_SHRINK_STEP = 2
ROOM_SHRINK_SPIDER_HIT = 200

ENTITY_TYPE_PLAYER = 'PLAYER'
ENTITY_TYPE_WALL = 'WALL'
ENTITY_TYPE_ENERGY = 'ENERGY'
ENTITY_TYPE_SPIDER = 'SPIDER'

PLAYER_MOVE_FORCE = 60000
PLAYER_JUMP_IMPULSE = 8000
PLAYER_RADIUS = 15
PLAYER_COLOR = { 52, 152, 219 }
PLAYER_MIN_DASH_WAIT = 0.3

ENERGY_COST = 2;
ENERGY_BONUS = 50;
ENERGY_RADIUS = 5;
ENERGY_SPAWN_DELAY = 8;
ENERGY_COLOR = { 46, 204, 113 }

SPIDER_MOVE_FORCE = 4000
SPIDER_RADIUS = 10;
SPIDER_SPAWN_DELAY = 2;
SPIDER_COLOR = { 192, 57, 43 }

WALL_COLOR = { 46, 204, 113 }
WALL_THICKNESS = 5
ROOM_COLOR = { 44, 62, 80 }

TEXT_WELCOME = [[
Welcome to Juan Rhoum's nightmare.

Use left click to move and right click to dash.

Energy (green) is good. Collect it and return to your room.
Spiders (red) are bad and want to destroy your room.
Bounce them into walls!

Hit enter to start!
]]

TEXT_PAUSED = [[
Paused!
]]

TEXT_OVER = [[
Game over! :(
Hit enter to try again.
]]

local game
function love.load()
  print('love.load')
  math.randomseed(os.time())
  game = Game:new()
end

function love.focus(f)
  if f then
    if game.status == 'paused' then
      game.status = 'running'
    end
  else
    if game.status == 'running' then
      game.status = 'paused'
    end
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  if key == 'return' then
    -- Reset if running
    if game.status == 'running' then
      game = Game:new()
    end

    game.status = 'running'
  end
end

function love.update(dt)
  if game.status == 'running' then
    game:update(dt)
  end
end

function love.draw()
  if game.status == 'new' then
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(TEXT_WELCOME, 0, love.graphics.getWidth() / 3, love.graphics.getWidth(), 'center')
  elseif game.status == 'over' then
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(TEXT_OVER, 0, love.graphics.getWidth() / 3, love.graphics.getWidth(), 'center')
  elseif game.status == 'paused' then
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(TEXT_PAUSED, 0, love.graphics.getWidth() / 3, love.graphics.getWidth(), 'center')
  else
    game:draw()
  end
end
