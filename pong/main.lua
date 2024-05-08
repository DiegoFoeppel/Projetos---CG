

function love.load()

    -- Define o tamanho da fonte a ser utilizada
    local myfont = love.graphics.newFont(30)

    -- Seleciona fonte
    love.graphics.setFont(myfont)
    
    love.graphics.setColor(255, 255, 255, 225)
    love.graphics.setBackgroundColor(0, 0, 0)

    -- Define as propriedades da barra lateral esquerda, 
    -- da bolinha e da barra lateral direita
    player1 = {}

    player1.x = 35
    player1.y = 200
    player1.w = 15
    player1.h = 75

    player1.speed = 3

    player2 = {}

    player2.x = 750
    player2.y = 200
    player2.w = 15
    player2.h = 75

    player2.speed = 1

    ball = {}

    ball.x = 350
    ball.y = 350

    ball.w = 10
    ball.h = 10

    valueX = 2
    valueY = -2

    scoreP1 = 0
    scoreP2 = 0
    
end

function love.update(dt)

    -- Configurações de keyboard, reação ao clique
    -- Lógica do pong
    -- Configuração básica da lógica da bolinha
    -- Estão bem simples mas funcionais 

    if love.keyboard.isDown("w") and player1.y > 0 then
        player1.y = player1.y - 1.75
       -- player2.y = player2.y - player2.speed
    end

    if love.keyboard.isDown("s") and player1.y < 525 then
        player1.y = player1.y + 1.75
        --player2.y = player2.y + player2.speed
    end

    if love.keyboard.isDown("up") and player2.y > 0 then
        player2.y = player2.y - 1.75
       -- player2.y = player2.y - player2.speed
    end

    if love.keyboard.isDown("down") and player2.y < 525 then
        player2.y = player2.y + 1.75
        --player2.y = player2.y + player2.speed
    end
    
    ball.x = ball.x + valueX
    ball.y = ball.y + valueY 

    --minX = player1.x
    minY = player1.y 
   -- maxX = player2.x
    maxY = player2.y 


    if (ball.y == 10 or ball.y == 590) then 
        --score = score + 1 
        valueY = valueY* -1 
    end 

    if (ball.x == 10 or ball.x == 790) then 
        -- score = score + 1 
        valueX = valueX* -1 
    end 

    if ball.x >= player1.x and ball.x <= player1.x + player1.w and
       ball.y >= player1.y and ball.y <= player1.y + player1.h then
        valueX = -valueX
    end

    -- Check for collision with the corners of player2
    if ball.x >= player2.x and ball.x <= player2.x + player2.w and
       ball.y >= player2.y and ball.y <= player2.y + player2.h then
        valueX = -valueX
    end

    if (ball.x == 10) then
        scoreP2 = scoreP2 + 1
        ball.x = 350
        ball.y = 350
    elseif (ball.x == 790) then 
        scoreP1 = scoreP1 + 1
        ball.x = 350
        ball.y = 350
    end 


end

function love.draw()

    -- Funções que renderizam os objetos na tela
    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.rectangle("fill", player1.x, player1.y, player1.w, player1.h)
    love.graphics.rectangle("fill", player2.x, player2.y, player2.w, player2.h)
    love.graphics.circle("fill", ball.x, ball.y, ball.w, ball.h)
    love.graphics.print(scoreP1.." : "..scoreP2, 350, 30)
    love.window.setFullscreen = true
end

