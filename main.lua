function love.conf()
    t.screen.width = 1024
    t.screen.height = 768
end

-- groundx : 482
-- groundy : 124
-- grundw : 62
-- groundh : 31

function love.load()
    spriteMap = loadTransparent('GRAFIK/GFXGROUN.BMP', 0, 0, 0)

    -- water = love.graphics.newImage('sprites/water.png');
    -- grass = love.graphics.newImage('sprites/grass.png');
    -- dirt = love.graphics.newImage('sprites/dirt.png');
    --
    -- water = love.graphics.newImage('tiles/landscapeTiles_066.png');
    -- grass = love.graphics.newImage('tiles/landscapeTiles_067.png');
    -- dirt = love.graphics.newImage('tiles/landscapeTiles_083.png');

    sand = love.graphics.newQuad(62, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())
    sandStony = love.graphics.newQuad(310, 544, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())
    sandGrassy = love.graphics.newQuad(310, 576, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())
    sandHole = love.graphics.newQuad(744, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())

    -- grass
    grass = love.graphics.newQuad(124, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())
    grassHilly = love.graphics.newQuad(248, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())
    grassDirty = love.graphics.newQuad(310, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())
    grassStony = love.graphics.newQuad(372, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())

    highlightBorder = love.graphics.newQuad(496, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())

    -- water
    water = love.graphics.newQuad(186, 512, 62, 32, spriteMap:getWidth(), spriteMap:getHeight())

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

            if grid[x][y] == 1 then
                toDraw = grass
            elseif grid[x][y] == 2 then
                toDraw = water
            elseif grid[x][y] == 3 then
                toDraw = grassHilly
            elseif grid[x][y] == 4 then
                toDraw = grassDirty
            elseif grid[x][y] == 5 then
                toDraw = grassStony
            elseif grid[x][y] == 6 then
                toDraw = sand
            elseif grid[x][y] == 7 then
                toDraw = sandHole
            elseif grid[x][y] == 8 then
                toDraw = sandStony
            elseif grid[x][y] == 9 then
                toDraw = sandGrassy
            end

            love.graphics.draw(
            spriteMap,
            toDraw,
            map_x + ((y-x) * (block_width/2)),
            map_y + ((x+y) * (block_depth/2)) - (block_depth * (grid_size/2))
            )

            if x == 10 and y == 12 then
            love.graphics.draw(
            spriteMap,
            highlightBorder,
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
