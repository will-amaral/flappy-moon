local Pipe = require('pipe')
local Bg = require('background')
local Player = require('player')
local Collision = require('collision')

local State = { Idle = {}, Play = {}, GameOver = {}}
local window = { w = 1000, h = 600 }
local settings = {
  timer = 0,
  limit = 0,
  state = State.Idle,
  speed = 100
}
local pipes = Pipe.get()
local moon = Player.get()
local function resetGame()
  settings.timer = 0
  settings.limit = 0
  settings.speed = 100
  Player.reset()
  Pipe.reset()
end

function love.load()
  local r, g, b = love.math.colorFromBytes(132, 193, 238)
  love.graphics.setBackgroundColor(r, g, b)
  love.window.setMode(window.w, window.h)
end

function love.keypressed(key)
  if key ~= 'space' then return end

  if settings.state == State.GameOver then
    settings.state = State.Idle
    resetGame()
    return
  end

  if settings.state == State.Idle then
    settings.state = State.Play
  end

  Player.jump()
end

function love.update(dt)
  -- Keep Background movement only when idle or playing
  if settings.state ~= State.GameOver then
    Bg.update(dt)
  end

  -- Stop updates and early return if game is idle or over
  if settings.state ~= State.Play then return end

  -- Moon and Pipes movement
  Player.update(dt)
  Pipe.update(dt, settings)
  settings.timer = settings.timer + dt

  -- Collision checks
  if moon.y + moon.h >= window.h - 50 then
    settings.state = State.GameOver
    return
  end

  for _, pipe in ipairs(pipes) do
    if Collision.check(moon, pipe) then
      settings.state = State.GameOver
      return
    end
  end
end

function love.draw()
  -- render background
  Bg.draw()

  -- render pipes
  Pipe.draw()

  -- render floor
  Bg.floor(window)

  -- render moon
  Player.draw()

  -- game over screen
  if settings.state == State.GameOver then
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf(
      'GAME OVER! Press SPACE to restart',
        0, window.h/2 - 10, window.w, 'center'
    )
    love.graphics.setColor(1, 1, 1)
  end
end

