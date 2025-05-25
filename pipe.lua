local pipe_img = love.graphics.newImage('pipe.png')

local Pipe = {}

function Pipe:new(speed)
  local pipe = {}
  setmetatable(pipe, self)
  self.__index = self
  pipe.x = 1000
  pipe.y = math.random(1,600)
  pipe.distance = math.random(150,300)
  pipe.speed = speed or 100
  return pipe
end

function Pipe:update(dt)
  self.x = self.x - self.speed * dt
end

function Pipe:draw()
  love.graphics.draw(pipe_img, self.x, self.y, 0, 0.5, 0.5)
  love.graphics.draw(pipe_img, self.x, self.y - self.distance, 0, 0.5, -0.5)
end

return Pipe

