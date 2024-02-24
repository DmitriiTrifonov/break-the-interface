Enemy = {}

function Enemy:new(x, y, r, data, text)
    local color = {}
        color.r = 1
        color.g = 1
        color.b = 1

    local obj = {}
        obj.x = x
        obj.y = y
    
        obj.val = 0

        obj.data = data
        obj.radius = r
        obj.titleFont = love.graphics.newFont("Stepalange-x3BLm.otf", data.titleSize)
        obj.valueFont = love.graphics.newFont("Stepalange-x3BLm.otf", data.valueSize)
        obj.color = color
        obj.text = text

    setmetatable(obj, self)
    self.__index = self; return obj
end

function Enemy:update(x, y)
    self.x = x
    self.y = y
    self.val = self.text.val
end

function Enemy:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.setFont(self.titleFont)
    love.graphics.print(self.data.titleText, 
    self.x - self.titleFont:getWidth(self.data.titleText) / 2 , 
    self.y - self.titleFont:getHeight() / 2 - self.valueFont:getHeight() / 2)
    love.graphics.setFont(self.valueFont)
    formatted = string.format("%.0f", self.val)
    love.graphics.print(formatted, self.x - self.titleFont:getWidth(formatted) / 2, self.y + self.valueFont:getHeight() / 8)
end