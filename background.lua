local coords = {
  y = -180,
  x = 0,
  size = 1200
}

local Bg = {}

function Bg.draw(window)
  local r, g, b = love.math.colorFromBytes(205, 193, 165)
  local image = love.graphics.newImage('images/skyline.png')

  love.graphics.setColor(255, 255, 255, 0.4)
  love.graphics.draw(image, coords.x, coords.y)
  love.graphics.draw(image, coords.x + coords.size, coords.y)

  love.graphics.setColor(r, g, b)
  love.graphics.rectangle('fill', 0, window.h - 50, window.w, 50)
  love.graphics.setColor(0, 1, 0)
  love.graphics.rectangle('fill', 0, window.h - 60, window.w, 10)
  love.graphics.setColor(255, 255, 255)
end

function Bg.update(dt)
  coords.x = coords.x - 50 * dt

  if coords.x <= -coords.size then
    coords.x = 0
  end
end

return Bg
