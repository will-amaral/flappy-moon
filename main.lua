local Pipe = require('pipe')
local Bg = require('background')

local window = { w = 1000, h = 600 }
local coords = { x = window.w / 4, y = window.h / 2 }
local settings = {
  timer = 0,
  limit = 2,
  start = false
}

local moon = love.graphics.newImage('images/moon.png')

function love.load()
  local r, g, b = love.math.colorFromBytes(132, 193, 238)
  love.graphics.setBackgroundColor(r, g, b)
  love.window.setMode(window.w, window.h)
end

function love.keypressed(key)
  if key == 'space' then
    coords.y = coords.y - 100

    if not settings.start then
      settings.start = true
    end
  end
end

function love.update(dt)
  -- Moon vertical movement
  if settings.start then
    coords.y = coords.y + 300 * dt
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
  love.graphics.draw(moon, coords.x, coords.y, 0, 0.15, 0.15)
end
