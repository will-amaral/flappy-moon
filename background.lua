local image = love.graphics.newImage('images/clouds.png')
local bg = love.graphics.newImage('images/bg.png')
local stars = love.graphics.newImage('images/stars.png')
local size = image:getWidth()
local height = image:getHeight()
local coords = {
  y = 600 - height,
  x = 0,
}
local starsX = 0
local Bg = {}

function Bg.draw()
  love.graphics.draw(bg)
  love.graphics.draw(stars, starsX)
  love.graphics.draw(stars, starsX + size)
  love.graphics.draw(image, coords.x, coords.y)
  love.graphics.draw(image, coords.x + size, coords.y)
end

function Bg.update(dt)
  coords.x = coords.x - 50 * dt
  starsX = starsX - 5 * dt
  if coords.x <= -size then
    coords.x = 0
  end

  if starsX <= -size then
    starsX = 0
  end
end

return Bg
