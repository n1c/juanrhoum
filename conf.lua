
function love.conf(t)
  t.identity = "Juan Rhoum's nightmare"
  t.version = '0.9.1'
  t.console = true
  t.window.icon = nil
  t.window.width = 800
  t.window.height = 800
  t.window.borderless = false
  t.window.resizable = false
  t.window.minwidth = 800
  t.window.minheight = 800
  t.window.fullscreen = false
  t.window.fullscreentype = 'normal'
  t.window.vsync = true
  t.window.fsaa = 0
  t.window.display = 1
  t.modules.event = true
  t.modules.graphics = true
  t.modules.image = true
  t.modules.keyboard = true
  t.modules.math = true
  t.modules.mouse = true
  t.modules.system = true
  t.modules.timer = true
  t.modules.window = true
  t.modules.physics = true

  t.modules.joystick = false
  t.modules.audio = false
  t.modules.sound = false
end
