--AABB test
local  Collision = {}

function Collision.check(moon, pipe)
  return moon.x < pipe.x + pipe.w 
    and pipe.x < moon.x + moon.w
    and moon.y < pipe.y + pipe.h
    and pipe.y < moon.y + moon.h
end

return Collision
