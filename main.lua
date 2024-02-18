require "score_enemy"

function love.load()
    love.window.setTitle("break-the-interface")

    scoreSpeed = 20

    scoreNpc = ScoreEnemy:new(nil, 100, 100, 12, 40)

end

function love.update(dt) 
    scoreNpc:update(scoreNpc.x + scoreSpeed * dt, scoreNpc.y + scoreSpeed * dt)
end

function love.draw()
    scoreNpc:draw()
end

