function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    
    gameFont = love.graphics.newFont(40)
    --计时器
    timer = 0
    sprites = {}
    sprites.sky = love.graphics.newImage("/Assets/sky.png")
    sprites.target = love.graphics.newImage("/Assets/target.png")
    sprites.crosshairs = love.graphics.newImage("/Assets/crosshairs.png")
    love.mouse.setVisible(false)
    gameState = 1
end

function love.update(dt)
    --dt 也是下一帧和上一帧的时间差 👇 这是时间变化量
    if timer > 0 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print(score, 0, 0)
    --fill 矩形
    --line 边框
    --从0，0 到 200，100

    love.graphics.print(math.ceil(timer), 300, 0)
    -- 后边的两个参数是打印生成的位置
    -- math.ceil() 取整函数

    --后面那两个参数是生成位置，决定因素是锚点
    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
end
--1左键、2右键、3滑轮
function love.mousepressed(x, y, button, isTouch, press)
    if button == 1 and gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        --这将获取我们当前窗口的像素
        end
    elseif gameState == 1 and button == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
--
