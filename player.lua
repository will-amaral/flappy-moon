local moon = {
  image = love.graphics.newImage('images/moon.png'),
  x = 250,
  y = 300,
  vx = 0,
  vy = 0
}

moon.w = moon.image:getWidth()  * 0.15
moon.h = moon.image:getHeight() * 0.15

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
  love.graphics.rectangle('line', moon.x, moon.y, moon.w, moon.h)
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
