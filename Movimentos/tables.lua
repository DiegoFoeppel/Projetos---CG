local allObjects = {}

-- Definição de todos os objetos sendo utilizados no projeto

allObjects.car = {
    x = 10,
    y = 10,
    size = 0.15,
    velocidade = 30
}

allObjects.car2 = {
    x = 10,
    y = 120,
    size = 0.15,
    velocidade = 0,
    aceleracao = 10
}

allObjects.lineA = {
    x1 = 5,
    y1 = 80,
    x2 = 630,
    y2 = 80,
}

allObjects.lineB = {
    x1 = 5,
    y1 = 200,
    x2 = 630,
    y2 = 200
}

allObjects.ticks = 10

allObjects.tickSpacing = allObjects.lineA.x2 / (allObjects.ticks - 1)

allObjects.circleA = {
    centerX = 200, 
    centerY = 450,
    x = 0,
    y = 0,
    radius = 100, 
    angle = 0,
    angularSpeed = 0.1 * math.pi,
    totalDistance = 0
}

allObjects.circleB = {
    centerX = 600, 
    centerY = 450,
    x = 0,
    y = 0, 
    radius = 100, 
    angle = 0, 
    angularSpeed = 0.1 * math.pi, 
    angularAcceleration = 0.2,
    maxAngularSpeed = 2,
    totalDistance = 0
}

return allObjects