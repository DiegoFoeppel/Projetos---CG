
-- Função que carrega os objetos a serem utilizados no projeto
function love.load()
    carPicture = love.graphics.newImage("car.png")

    font = love.graphics.newFont(16)

    -- O é um shortcut para allObjects
    local allObjects = require("tables")

    obj = allObjects
    tempo = 0
    tempoFinal = 10

end 

-- Função que atualiza os frames utilizando o delta time
function love.update(dt) 
    tempo = tempo + dt 

    -- Lógica e cálculos dos 4 tipos de movimentos --

    obj.circleA.angle = obj.circleA.angle + obj.circleA.angularSpeed * dt 
    
    obj.circleB.angularSpeed = obj.circleB.angularSpeed + obj.circleB.angularAcceleration * dt
    obj.circleB.angularSpeed = math.min(obj.circleB.angularSpeed, obj.circleB.maxAngularSpeed)  
    obj.circleB.angle = obj.circleB.angle + obj.circleB.angularSpeed * dt
    
    local distanceA = obj.circleA.angularSpeed * obj.circleA.radius * dt

    obj.circleA.totalDistance = obj.circleA.totalDistance + distanceA

    local distanceB = obj.circleB.angularSpeed * obj.circleB.radius * dt

    obj.circleB.totalDistance = obj.circleB.totalDistance + distanceB


    -- Realiza o MRU e o MRUV durante 10 segundos
    if tempo <= tempoFinal then 
        -- Deslocamento carro --
        deslocamento = obj.car.velocidade * dt
        obj.car.x = obj.car.x + deslocamento

        obj.car2.velocidade = obj.car2.velocidade + obj.car2.aceleracao * dt 
        obj.car2.x = obj.car2.x + obj.car2.velocidade  * dt 
    -- Após os 10 segundos há uma pausa de 3 segundos e reinicia o deslocamento
    elseif tempo >= tempoFinal + 3 then 
        tempo = 0 

        obj.car.x = 10
        obj.car.y = 10
    
        obj.car2.x = 10
        obj.car2.y = 100
        obj.car2.velocidade = 0

    end 
    
end 

-- Função que desenha os traços na linha 
-- A ideia é utilizar como uma referência da distância percorrida
function drawTicks (line)

    love.graphics.line(line.x1, line.y1, line.x2, line.y2)

    for i = 0, obj.ticks - 1 do
        local tickX = line.x1 + i * obj.tickSpacing
        local tickY = line.y1
        
        -- Draw the tick
        love.graphics.line(tickX, tickY - 5, tickX, tickY + 5)
        
        -- Optionally, draw text indicating the value of the tick
        love.graphics.print(tostring(tickX) .. "px", tickX - 5, tickY + 10)
    end
end 

-- Função responsável pelo cálculo da posição mais atual do círculo
-- Utilizando trigonometria para chegar ao resultado desejado
-- MCU e MCUV
function calculatePosition (circle) 

    circle.x = circle.centerX + circle.radius * math.cos(circle.angle)
    circle.y = circle.centerY + circle.radius * math.sin(circle.angle)
    
end 

function love.draw()

    -- Nesta parte estão todas as funções que renderizam os objetos para a Tela

    love.graphics.setColor(255, 255, 255) -- Define a cor para vermelho (R, G, B)
    love.graphics.draw(carPicture, obj.car.x, obj.car.y, 0,obj.car.size)
    love.graphics.draw(carPicture, obj.car2.x, obj.car2.y, 0, obj.car2.size)

    drawTicks(obj.lineA)
    drawTicks(obj.lineB)

    love.graphics.print("Velocidade carro 1: " .. obj.car.velocidade, 600, 10)
    love.graphics.print("Distância carro 2: " .. math.floor(obj.car.x) .. "px", 600, 30)


    love.graphics.print("Velocidade carro 2: " .. math.floor(obj.car2.velocidade), 600, 120)
    love.graphics.print("Aceleração carro 2: " .. obj.car2.aceleracao, 600, 140)
    love.graphics.print("Distância carro 2: " .. math.floor(obj.car2.x) .. "px", 600, 160)

    love.graphics.setFont(font)
    love.graphics.print("Tempo decorrido: " .. math.floor(tempo), 0, 10)

    love.graphics.setColor(1, 0, 0)
    love.graphics.line(0, 250, 800, 250)

    love.graphics.setColor(1, 1, 1)
 
    calculatePosition(obj.circleA)
    calculatePosition(obj.circleB)

    love.graphics.circle("fill", obj.circleA.x, obj.circleA.y, 20)
    love.graphics.circle("fill", obj.circleA.centerX, obj.circleA.centerY, 1)

    love.graphics.circle("fill", obj.circleB.x, obj.circleB.y, 20)
    love.graphics.circle("fill", obj.circleB.centerX, obj.circleB.centerY, 1)

    love.graphics.print("Velocidade angular círculo 1: " .. obj.circleA.angularSpeed, 20, 260)
    love.graphics.print("Distância percorrida círculo 1: " .. math.floor(obj.circleA.totalDistance), 20, 280)
    love.graphics.print("Velocidade angular círculo 2: " .. math.floor(obj.circleB.angularSpeed), 520, 260)
    love.graphics.print("Aceleração angular círculo 2: " .. obj.circleB.angularSpeed, 520, 280)
    love.graphics.print("Distância percorrida círculo 2: " .. math.floor(obj.circleB.totalDistance), 500, 300)

end
