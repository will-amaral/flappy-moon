local jump = love.audio.newSource('sounds/jump.wav', 'static')
local scoreUp = love.audio.newSource('sounds/score_up.ogg', 'static')
local gameOver = love.audio.newSource('sounds/game_over.wav', 'static')
local bg = love.audio.newSource('sounds/bg.ogg', 'stream')
bg:setLooping(true)
bg:setVolume(0.3)

local Sound = {}

function Sound.jump()
  love.audio.play(jump)
end

function Sound.scoreUp()
  love.audio.play(scoreUp)
end

function Sound.gameOver()
  love.audio.play(gameOver)
  bg:stop()
end

function Sound.bg()
  love.audio.play(bg)
end

return Sound


