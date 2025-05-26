local Pipe = require('pipe')
local Bg = require('background')
local Player = require('player')

local window = { w = 1000, h = 600 }
local settings = {
  timer = 0,
  limit = 2,
  start = false,
  speed = 100
}

function love.load()
  local r, g, b = love.math.colorFromBytes(132, 193, 238)
  love.graphics.setBackgroundColor(r, g, b)
  love.window.setMode(window.w, window.h)
end

function love.keypressed(key)
  if key == 'space' then
    Player.jump()

    if not settings.start then
      settings.start = true
    end
  end
end

function love.update(dt)
  -- Moon vertical movement
  if settings.start then
    Player.update(dt)
  end

  -- Background movement
  Bg.update(dt)

  -- pipes movement
  Pipe.update(dt, settings)
  settings.timer = settings.timer + dt
end

function love.draw()
  -- render background
  Bg.draw(window)

  -- render pipes
  Pipe.draw()

  -- render moon
  Player.draw()
end
