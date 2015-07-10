function love.conf()
    t.screen.width = 1024
    t.screen.height = 768
end

-- groundx : 482
-- groundy : 124
-- grundw : 62
-- groundh : 31

function love.load()
    grafik = require 'grafik'

    block_width = 62
    -- grass:getWidth()
    block_height = 32
    -- grass:getHeight()
    block_depth = block_height
    -- block_depth = block_height/2

    map_w = 20
    map_h = 20
    map_x = 0
    map_y = 0
    map_display_buffer = 10

    map_display_w = 20
    map_display_h = 15

    grid_size = 200
    grid = {}
    for x = 1,grid_size do
        grid[x] = {}
        for y = 1,grid_size do
            grid[x][y] = math.random(9)
        end
    end

    lastmousex = 0
    lastmousey = 0
end

function love.update(dt)
    cameraUpdate(dt)
end

function love.draw()
    draw_map()
    love.graphics.setColor(255,255,255)
    love.graphics.print("Isometric Map Test\ndarookee", 15, 15)
    love.graphics.print("x:" .. lastmousex .. " y:" .. lastmousey, 15, 115)
    love.graphics.print("x:" .. map_x .. " y:" .. map_y, 15, 125)
end

function love.keypressed(key, u)
    if key == "rctrl" then
        debug.debug()
    end

    if key == "up" then
        map_y = map_y + 10
        if map_y > grid_size-100 then map_y = grid_size-100; end
    end
    if key == "down" then
        map_y = map_y - 10
        if map_y < 0 then map_y = 0; end
    end
    if key == "left" then
        map_x = math.min(map_x+10, grid_size-50)
    end
    if key == "right" then
        map_x = math.max(map_x-10, 0)
    end
end

function love.mousepressed(x,y,button)
    lastmousex = x
    lastmousey = y
end

function love.mousereleased(x,y,button)
    lastmousex = x
    lastmousey = y
end

function draw_map()
    for x = 1,grid_size do
        for y = 1,grid_size do

            toDraw = grafik.determineGraphicToDraw(grid[x][y])

            love.graphics.draw(
            grafik.spriteMap,
            toDraw,
            map_x + ((y-x) * (block_width/2)),
            map_y + ((x+y) * (block_depth/2)) - (block_depth * (grid_size/2))
            )

            if x == 10 and y == 12 then
            love.graphics.draw(
            grafik.spriteMap,
            grafik.graphics.highlight.border,
            map_x + ((y-x) * (block_width/2)),
            map_y + ((x+y) * (block_depth/2)) - (block_depth * (grid_size/2))
            )
            end
        end
    end
end

function cameraUpdate(dt)
    if love.mouse.isDown('r') then
        map_x = math.floor(map_x - ((lastmousex - love.mouse.getX())) / block_width*4)
        map_y = math.floor(map_y - ((lastmousey - love.mouse.getY())) / block_height*4)
    end
    -- Handle keyboard panning
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        if love.keyboard.isDown("left") then
            map_x = map_x + 300 * dt
        end
        if love.keyboard.isDown("right") then
            map_x = map_x - 300 * dt
        end
        if love.keyboard.isDown("up") then
            map_y = map_y + 300 * dt
        end
        if love.keyboard.isDown("down") then
            map_y = map_y - 300 * dt
        end
    end
end

function loadTransparent(imagePath, transR, transG, transB)
   imageData = love.image.newImageData( imagePath )
   function mapFunction(x, y, r, g, b, a)
      if r == transR and g == transG and b == transB then a = 0 end
      return r,g,b,a
   end
   imageData:mapPixel( mapFunction )
   return love.graphics.newImage( imageData )
end
