local moon = {
  image = love.graphics.newImage('images/moon.png'),
  x = 250,
  y = 300,
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

return Player
