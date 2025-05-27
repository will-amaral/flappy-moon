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
local score = 0
local highScore = 0

local function resetGame()
  settings.timer = 0
  settings.limit = 0
  settings.speed = 100
  Player.reset()
  Pipe.reset()
  score = 0
end

function love.load()
  local r, g, b = love.math.colorFromBytes(132, 193, 238)
  love.graphics.setBackgroundColor(r, g, b)
  love.window.setMode(window.w, window.h)
  local font = love.graphics.newFont('fonts/roboto.ttf', 40)
  love.graphics.setFont(font)
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
  if settings.state ~= State.GameOver then
    Bg.update(dt)
  end

  if settings.state ~= State.Play then return end

  if score > highScore then highScore = score end

  Player.update(dt)
  Pipe.update(dt, settings)
  settings.timer = settings.timer + dt

  local moon = Player.get()
  local pipes = Pipe.get()
  local counter = Pipe.count()
  for _, pipe in ipairs(pipes) do
    if pipe.x + pipe.w < moon.x and counter - score == #pipes/2 then
      score = score + 1
    elseif Collision.check(moon, pipe) then
      settings.state = State.GameOver
    end
  end

  if moon.y + moon.h >= window.h - 60 then
    settings.state = State.GameOver
    return
  end
end

function love.draw()
  Bg.draw()
  Pipe.draw()
  Bg.floor(window)
  Player.draw()
  love.graphics.print('Score: ' .. score, 10, 10)
  love.graphics.print('High Score: ' .. highScore, 10, 60)

  if settings.state == State.GameOver then
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf(
      'GAME OVER! Press SPACE to restart',
        0, window.h/2 - 10, window.w, 'center'
    )
    love.graphics.setColor(1, 1, 1)
  end
end

