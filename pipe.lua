local topPipe = love.graphics.newImage('images/topPipe.png')
local bottomPipe = love.graphics.newImage('images/bottomPipe.png')
local GROUND_HEIGHT = 50
local MARGIN = 20

local Pipe = {}
local pipes = {}

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
  if #pipes >= 16 then
    table.remove(pipes, 1)
    table.remove(pipes, 1)
  end

  for _, pipe in ipairs(pipes) do
    pipe.x = pipe.x - pipe.speed * dt
  end

  if settings.timer >= settings.limit then
    local windowH = love.graphics.getHeight()
    local gapHeight = love.math.random(150,300)

    local minY = MARGIN + gapHeight /2
    local maxY = windowH - GROUND_HEIGHT - MARGIN - gapHeight/2
    local gapY = love.math.random(minY, maxY)

    local bottomY = gapY + gapHeight/2
    local bottom = newPipe(settings.speed, bottomPipe, bottomY)

    local topY = gapY - gapHeight/2 - (topPipe:getHeight() * 0.5)
    local top    = newPipe(settings.speed, topPipe, topY)
    -- local y = math.random(100, 500)
    -- local distance = math.random(200, 400)
    table.insert(pipes, top)
    table.insert(pipes, bottom)

    settings.timer = 0
    settings.limit = math.random(2, 3)
  end
end

function Pipe.draw()
  for _, pipe in ipairs(pipes) do
    love.graphics.draw(pipe.image, pipe.x, pipe.y, 0, 0.5, 0.5)
    love.graphics.rectangle('line', pipe.x, pipe.y, pipe.w, pipe.h)
  end
end

function Pipe.get()
  return pipes
end

function Pipe.reset()
  pipes = {}
end

return Pipe
