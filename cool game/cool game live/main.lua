function love.load()
    highscore = love.filesystem.read("string","save.txt")
    math.randomseed(os.clock())
    font = love.graphics.newFont("affection_ldr.ttf", 20)
    state = 0
    enemy = {}
    score = 0
    cooldown = 0
    buffer = 90
    button1 = 0
    button2 = 0
    button3 = 0
    for i=0,100 do
        enemy[i] = math.random(1,4)
    end
	arrow = love.graphics.newImage("arrow.png")
    arrowwidth = love.image.newImageData("arrow.png"):getWidth()
    arrowheight = (love.image.newImageData("arrow.png"):getHeight())

end
function love.draw()
    love.graphics.setFont(font)
    love.graphics.setBackgroundColor(0,0,0)
    if state == 0 then
        for a=score,score+5 do
            --x pos on individual instances of arrow
            local x = arrowwidth*(a-score)
            if enemy[a] == 1 or enemy[a] == 2 then
                x = x + arrowwidth
            end
            --y pos on individual instances of arrow
            local y = love.graphics.getHeight()/2-arrowheight/2
            if enemy[a] == 2 or enemy[a] == 3 then
                y = y + arrowheight
            end
            love.graphics.draw(arrow,x,y,1.57079632*enemy[a])
        end
        --checks if there's a new highscore
        if score < tonumber(highscore) then
            love.graphics.print("score = " .. tostring(score),10,10)
            
        else
            love.graphics.print("New high score = " .. tostring(score),10,10)
        end
        --displays highscore
        love.graphics.print("highscore = " .. tostring(highscore),10,40)
        --displays timer
        bar = love.graphics.rectangle("fill",100,500,timeLeft,30)

    --failure screen
    else
        text = "You screwed up your rhythm"
        text2 = "Final score = " .. tostring(score)
        
        love.graphics.print(text,love.graphics.getWidth()/2-font:getWidth(text)/2,100,0)
        love.graphics.print(text2,love.graphics.getWidth()/2-font:getWidth(text2)/2,200,0)
        --button1
        if button1 < 1 then
            love.graphics.rectangle("line",100,320,250,100)
            love.graphics.print("Try Again",135,360)
        else
            love.graphics.rectangle("fill",100,320,250,100)
            love.graphics.setColor(0,0,0)
            love.graphics.print("Try Again",135,360)
            love.graphics.setColor(255,255,255)
        end
        --button2
        if button2 < 1 then
            love.graphics.rectangle("line",450,320,250,100)
            love.graphics.print("Give Up",510,360)
        else
            love.graphics.rectangle("fill",450,320,250,100)
            love.graphics.setColor(0,0,0)
            love.graphics.print("Give Up",510,360)
            love.graphics.setColor(255,255,255)
        end
        --button3
        if button3 < 1 then
            love.graphics.rectangle("line",275,450,250,100)
            love.graphics.print("     Wipe\nHighscore",315,480)
        else
            love.graphics.rectangle("fill",275,450,250,100)
            love.graphics.setColor(0,0,0)
            love.graphics.print("     Wipe\nhighscore",315,480)
            love.graphics.setColor(255,255,255)
        end
    end
end
function love.update(dt)
    timeLeft = 600 - cooldown*(math.sqrt(score/1.5))*3
    --adds more arrows after buffer is reached
    if score == buffer then
        for i=score+10,score+110 do
            enemy[i] = math.random(1,4)
        end
        buffer = score + 100
    end
    --cooldown countdown
    cooldown = cooldown + 25 * dt

    --failure if timer = 0
    if (timeLeft) <= 0 then
        state = 1
    end

    --checks the option chosen on failure

    --restart game
    if button1 == 2 then
        cooldown = 0
        score = 0
        button1 = 0
        button2 = 0
        state = 0
        for i=0,100 do
            enemy[i] = math.random(1,4)
        end

    --quit    
    elseif button2 == 2 then
        love.event.quit()

    --wipe highscore
    elseif button3 == 2 then
        love.filesystem.write("save.txt","0")
        highscore = "0"
        button3 = 0
    end
end


function love.keypressed(key, scancode, isrepeat)
    --selects the failure buttons
    if state == 1 then
        if isrepeat == false then
            if key == "left" then
                button1 = button1 + 1
                button2 = 0
                button3 = 0
            elseif key == "right" then
                button1 = 0
                button2 = button2 + 1
                button3 = 0
            elseif key == "down" then
                button1 = 0
                button2 = 0
                button3 = button3 + 1
            end
        end
    end

    --figures out if you fucked up
    if state == 0 then
        if isrepeat == false then
            if key == "up" and enemy[score] == 4 then
                score = score + 1
                cooldown = 0
            elseif key == "right" and enemy[score] == 1 then
                score = score + 1
                cooldown = 0
            elseif key == "down" and enemy[score] == 2 then
                score = score + 1
                cooldown = 0
            elseif key == "left" and enemy[score] == 3 then
                score = score + 1
                cooldown = 0
            else
                if score > tonumber(highscore) then
                    highscore = tostring(score)
                    love.filesystem.write("save.txt",highscore)
                end
                state = 1
            end
        end
    end
end