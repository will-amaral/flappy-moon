local window = { w = 1000, h = 600 }
local coords = { x = window.w / 4, y = window.h / 2 }
local moon = love.graphics.newImage('moon.png')
local timer = 0
local limit = 2
local pipes = {}
local Pipe = require('pipe')

function love.load()
  local r, g, b = love.math.colorFromBytes(132, 193, 238)
  love.graphics.setBackgroundColor(r, g, b)
  love.window.setMode(window.w, window.h)
end

function love.keypressed(key)
  if key == 'space' then
    coords.y = coords.y - 100
  end
end

function love.update(dt)
  if #pipes >= 8 then
    table.remove(pipes,1)
  end
  coords.y = coords.y + 300 * dt
  for i in ipairs(pipes) do
    pipes[i].x = pipes[i].x - 100 * dt
  end
  timer = timer + dt
  if timer >= limit then
    local pipe = Pipe:new()
    table.insert(pipes, pipe)
    timer = 0
    limit = math.random(2,3)
  end
end

function love.draw()
  love.graphics.draw(moon, coords.x, coords.y, 0, 0.15, 0.15)
  for i,v in ipairs(pipes) do
    pipes[i]:draw()
  end
end
