require "enemy"

function love.load()
    music = love.audio.newSource("thepartydemo.mp3", "stream")
    music:setVolume(0.75)
    background = love.graphics.newImage("bj_grad.png")
    bgm = love.graphics.newImage("bg1.png")

    love.window.setTitle("catch-the-interface")

    score = {}
    score.val = 0
    rot = 0

    dataScore = {}
    dataScore.titleSize = 40
    dataScore.titleText = "score"
    dataScore.valueSize = 60

    scoreNpc = Enemy:new(love.graphics.getWidth() / 4,
    (dataScore.titleSize + dataScore.valueSize) / 2, 80, dataScore, score)

    dataTimer = {}
    dataTimer.titleSize = 40
    dataTimer.titleText = "timer"
    dataTimer.valueSize = 60

    timer = {}
    timer.val = 120

    timerNpc = Enemy:new(love.graphics.getWidth() / 2,
     (dataTimer.titleSize + dataTimer.valueSize) / 2, 80, dataTimer, timer)

    isRunning = false
    entryScreen = true
    musicPlay = true

    exitBtn = {}
    exitBtn.x = 0
    exitBtn.y = 0

    color = {}
    exitBtn.radius = 80
    exitBtn.color = color
    exitBtn.color.r = 1
    exitBtn.color.g = 1
    exitBtn.color.b = 1
    

end

function love.update(dt)
    if isRunning then 
        timer.val = timer.val - dt
        rot = rot + dt / 2
    end 
    if timer.val <= 0 then
        isRunning = false
        timer.val = 0
    end
    if musicPlay then
        love.audio.play(music)
    else
        love.audio.stop(music)
    end
    scoreNpc:update(scoreNpc.x, scoreNpc.y)
    timerNpc:update(timerNpc.x, timerNpc.y)
end

function love.draw()
    if isRunning then 
        love.graphics.setColor(1,1,1)
        love.graphics.draw(bgm, 0,  0)
        love.graphics.draw(bgm, love.graphics.getWidth() / 2,  love.graphics.getHeight(), -3 * rot )
        love.graphics.draw(background, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, rot)
        love.graphics.draw(background, love.graphics.getWidth() / 2, 0, -2 * rot)
        love.graphics.draw(background, love.graphics.getWidth() / 2, love.graphics.getHeight(), 4 * rot)
        fnt = love.graphics.newFont("Stepalange-x3BLm.otf", 60)
        love.graphics.setFont(fnt)
        love.graphics.print("exit", exitBtn.x, exitBtn.y)
        scoreNpc:draw()
        timerNpc:draw()
    else
        if entryScreen then 
        love.graphics.setColor(1,1,1)
        love.graphics.draw(background, 0, 0)
        fnt = love.graphics.newFont("Stepalange-x3BLm.otf", 60)
        love.graphics.setFont(fnt)
        love.graphics.print(string.format("\nCatch the interface\n\n\nFind interface elements\nand catch them for 2 minutes\n\n\nPress RMB to turn off music", score.val))
        else
        love.graphics.setColor(1,1,1)
        fnt = love.graphics.newFont("Stepalange-x3BLm.otf", 60)
        love.graphics.setFont(fnt)
        love.graphics.draw(bgm, 0, 0)
        love.graphics.print(string.format("Game Over\n\nYou're score is %d\nPress LMB to restart the game", score.val))
        end
    end
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 2 then
        musicPlay = not musicPlay
    end

    if isRunning and button == 1 then
        local mouseToExit = distance(x, y, exitBtn.x, exitBtn.y)
        if  mouseToExit < exitBtn.radius then
            score.val = score.val + 1
            isRunning = false
            love.event.quit(0)
        end

        local mouseToScore = distance(x, y, scoreNpc.x, scoreNpc.y)
        if mouseToScore < scoreNpc.radius then
            score.val = score.val + 1
            scoreNpc.x = math.random(scoreNpc.radius, love.graphics.getWidth() - scoreNpc.radius)
            scoreNpc.y = math.random(scoreNpc.radius, love.graphics.getHeight() - scoreNpc.radius)
            scoreNpc.color.r = math.random(0.85, 1)
            scoreNpc.color.g = math.random(0.85, 1)
            scoreNpc.color.b = math.random(0.85, 1)

            exitBtn.x = math.random(exitBtn.radius, love.graphics.getWidth() - exitBtn.radius)
            exitBtn.y = math.random(exitBtn.radius, love.graphics.getHeight() - exitBtn.radius)
            exitBtn.color.r = math.random(0.85, 1)
            exitBtn.color.g = math.random(0.85, 1)
            exitBtn.color.b = math.random(0.85, 1)
        end

        local mouseToTimer = distance(x, y, timerNpc.x, timerNpc.y)
        if mouseToTimer < timerNpc.radius then
            score.val = score.val + 1
            timerNpc.x = math.random(timerNpc.radius, love.graphics.getWidth() - timerNpc.radius)
            timerNpc.y = math.random(timerNpc.radius, love.graphics.getHeight() - timerNpc.radius)
            timerNpc.color.r = math.random(0.85, 1)
            timerNpc.color.g = math.random(0.85, 1)
            timerNpc.color.b = math.random(0.85, 1)

            exitBtn.x = math.random(exitBtn.radius, love.graphics.getWidth() - exitBtn.radius)
            exitBtn.y = math.random(exitBtn.radius, love.graphics.getHeight() - exitBtn.radius)
            exitBtn.color.r = math.random(0.85, 1)
            exitBtn.color.g = math.random(0.85, 1)
            exitBtn.color.b = math.random(0.85, 1)
        end
    end

    if entryScreen and button == 1  then 
        isRunning = true
        entryScreen = false
    end

    if not entryScreen and not isRunning and button == 1 then
        love.event.quit("restart")
    end 

    if not entryScreen and not isRunning and button == 2 then
        love.event.quit(0)
    end 

end

function distance(x1,y1,x2,y2)
    return math.sqrt((x2 - x1)^2 + (y2-y1)^2)
end
