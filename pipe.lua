local topPipe = love.graphics.newImage('images/topPipe.png')
local bottomPipe = love.graphics.newImage('images/bottomPipe.png')

local Pipe = {}
local pipes = {}
local counter = 0

local function newPipe(speed, pipe_img, y)
  local pipe = {
    image = pipe_img,
    x = 1200,
    y = y,
    w = pipe_img:getWidth()  * 0.5,
    h =  pipe_img:getHeight() * 0.5,
    speed = speed
  }
  return pipe
end

function Pipe.update(dt, settings)
  for i, pipe in ipairs(pipes) do
    pipe.x = pipe.x - pipe.speed * dt

    if pipe.x + pipe.w < 0 then
      table.remove(pipes, i)
    end
  end

  if settings.timer >= settings.limit then
    local gap = love.math.random(150,300)
    local posY = love.math.random(0, 540 - gap)
    local height = topPipe:getHeight() * 0.5

    local top = newPipe(settings.speed, topPipe, posY - height)
    local bottom = newPipe(settings.speed, bottomPipe, gap + posY)
    table.insert(pipes, top)
    table.insert(pipes, bottom)

    counter = counter + 1

    settings.timer = 0
    settings.limit = math.random(2, 3)
  end
end

function Pipe.draw()
  for _, pipe in ipairs(pipes) do
    love.graphics.draw(pipe.image, pipe.x, pipe.y, 0, 0.5, 0.5)
  end
end

function Pipe.get()
  return pipes
end

function Pipe.reset()
  pipes = {}
  counter = 0
end

function Pipe.count()
  return counter
end

return Pipe
