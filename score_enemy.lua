ScoreEnemy = {x = 0, y = 0, labelSize = 0, valueSize = 0}

function ScoreEnemy:new(o, x, y, labelSize, valueSize)
    o = {} or o
    setmetatable(o, self)
    self.__index = self
    self.x = x
    self.y = y
    self.scoreValue = 0
    self.scoreLabel = "score"
    self.labelSize = labelSize
    self.fontLabel = love.graphics.newFont(labelSize)
    self.valueSize = valueSize
    self.valueLabel = love.graphics.newFont(valueSize)
    return o
end

function ScoreEnemy:update(x, y)
    self.x = x
    self.y = y
end

function ScoreEnemy:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(self.valueLabel)
    love.graphics.print(self.scoreLabel, self.x, self.y - 20 - 6)
    love.graphics.setFont(self.valueLabel)
    love.graphics.print(self.scoreValue, self.x, self.y - 10)
end
