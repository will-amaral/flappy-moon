local pipe_img = love.graphics.newImage('images/pipe.png')

local Pipe = {}
local pipes = {}

local function newPipe(speed)
  local pipe = {}
  pipe.x = 1200
  pipe.y = math.random(100, 500)
  pipe.distance = math.random(200, 400)
  pipe.speed = speed or 100
  return pipe
end

function Pipe.update(dt, settings)
  if #pipes >= 8 then
    table.remove(pipes, 1)
  end

  for _, pipe in ipairs(pipes) do
    pipe.x = pipe.x - pipe.speed * dt
  end

  if settings.timer >= settings.limit then
    table.insert(pipes, newPipe())
    settings.timer = 0
    settings.limit = math.random(2, 3)
  end
end

function Pipe.draw()
  for _, pipe in ipairs(pipes) do
    love.graphics.draw(pipe_img, pipe.x, pipe.y, 0, 0.5, 0.5)
    love.graphics.draw(pipe_img, pipe.x, pipe.y - pipe.distance, 0, 0.5, -0.5)
  end
end

return Pipe
