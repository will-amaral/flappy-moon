local image = love.graphics.newImage('images/moon.png')
local moon = {
  image = image,
  x = 250,
  y = 300,
  w = image:getWidth() * 0.15,
  h = image:getHeight() * 0.15,
  vx = 0,
  vy = 0
}

local GRAVITY = 500
local Player = {}

function Player.jump()
  moon.vy = -200
end

function Player.update(dt)
  moon.vy = moon.vy + GRAVITY * dt
  moon.y  = moon.y + moon.vy * dt
end

function Player.draw()
  love.graphics.draw(moon.image, moon.x, moon.y, 0, 0.15, 0.15)
end

function Player.get()
  return moon
end

function Player.reset()
  moon.x = 250
  moon.y = 300
  moon.vx = 0
  moon.vy = 0
end

return Player, moon
