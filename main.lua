love.graphics.setDefaultFilter('nearest', 'nearest')
enemy = {}
enemies_controller = {}
enemies_controller.enemies = {}
enemies_controller.image = love.graphics.newImage("midia/enemy.png")

function love.load()
    player = {}
    player.x = 0
    player.y = 550
    player.bullets = {}
    player.cooldown = 20
    player.speed = 2
    player.image = love.graphics.newImage("midia/player.png")
    player.fire = function()
        if player.cooldown <= 0 then
            player.cooldown = 20
            bullet = {}
            bullet.x = player.x + 35
            bullet.y = player.y
            table.insert(player.bullets, bullet)
        end
    end
    enemies_controller:spawnEnemy(0, 0)
    enemies_controller:spawnEnemy(100, 0)
end

function enemies_controller:spawnEnemy(x, y)
    enemies = {}
    enemy = {}
    enemy.x = x
    enemy.y = y
    enemy.bullets = {}
    enemy.cooldown = 20
    enemy.speed = 2
    table.insert(self.enemies, enemy)
end

function enemy:fire()
    if self.cooldown <= 0 then
        self.cooldown = 20
        bullet = {}
        bullet.x = player.x + 35
        bullet.y = player.y
        table.insert(self.bullets, bullet)
    end
end

function love.update(dt)
    player.cooldown = player.cooldown - 1

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
    elseif love.keyboard.isDown("left") then
        player.x = player.x - player.speed
    end

    if love.keyboard.isDown("up") then
        player.fire()
    end

    for _,e in pairs(enemies_controller.enemies) do
        e.y = e.y + 1
    end

    for i,b in ipairs(player.bullets) do    
        if b.y < -10 then
            table.remove(player.bullets, i)
        end
        b.y = b.y - 10
    end
end

    function love.draw()
        --love.graphics.scale(5)
        -- draw the player
        love.graphics.setColor(255 , 255, 255)

        love.graphics.draw(player.image, player.x, player.y)

        -- draw enemy
        for _,e in pairs(enemies_controller.enemies) do
            love.graphics.draw(enemies_controller.image, e.x, e.y, 0)
        end

        -- draw the bullets
        love.graphics.setColor(255,255,255)
        for _, b in pairs(player.bullets) do
            love.graphics.rectangle("fill", b.x, b.y, 10, 10)
        end
    end