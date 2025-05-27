local HIT_MARGIN = 10

local  Collision = {}

local function clamp(value, min, max)
  if value < min then return min end
  if value > max then return max end
  return value
end

function Collision.check(moon, pipe)
  local circleX = moon.x + moon.w/2
  local circleY = moon.y + moon.h/2
  local radius = math.min(moon.w, moon.h)/2

  local deltaX = circleX - clamp(circleX, pipe.x, pipe.x + pipe.w)
  local deltaY = circleY - clamp(circleY, pipe.y, pipe.y + pipe.h)

  -- 3) If the distance squared is less than radius squared → collision
  return (deltaX * deltaX + deltaY * deltaY) <= (radius * radius)
end

return Collision
