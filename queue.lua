local Queue = {}

function Queue:new()
  local queue = {}
  self.items = {}
  setmetatable(queue, self)
  self.__index = self
  return queue
end

function Queue:push(value)
  table.insert(self.items, value)
end

function Queue:pop()
  local value = self.items[#self.items]
  table.remove(self.items, 1)
  return value
end

return Queue
