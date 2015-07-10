local grafik = {}

grafik.graphics = {}

grafik.init = function()
    grafik.spriteMap = grafik.loadTransparent('GRAFIK/GFXGROUN.BMP', 0, 0, 0)
    smWidth = grafik.spriteMap:getWidth()
    smHeight = grafik.spriteMap:getHeight()

    -- sand
    sand = {}
    sand.normal = love.graphics.newQuad(62, 512, 62, 32, smWidth, smHeight)
    sand.stony = love.graphics.newQuad(310, 544, 62, 32, smWidth, smHeight)
    sand.grassy = love.graphics.newQuad(310, 576, 62, 32, smWidth, smHeight)
    sand.hole = love.graphics.newQuad(744, 512, 62, 32, smWidth, smHeight)

    -- grass
    grass = {}
    grass.normal = love.graphics.newQuad(124, 512, 62, 32, smWidth, smHeight)
    grass.hilly = love.graphics.newQuad(248, 512, 62, 32, smWidth, smHeight)
    grass.dirty = love.graphics.newQuad(310, 512, 62, 32, smWidth, smHeight)
    grass.stony = love.graphics.newQuad(372, 512, 62, 32, smWidth, smHeight)

    -- highlight
    highlight = {}
    highlight.border = love.graphics.newQuad(496, 512, 62, 32, smWidth, smHeight)

    -- water
    water = {}
    water.normal = love.graphics.newQuad(186, 512, 62, 32, smWidth, smHeight)

    grafik.graphics.water = water
    grafik.graphics.sand = sand
    grafik.graphics.grass = grass
    grafik.graphics.highlight = highlight

    return grafik
end

 grafik.determineGraphicToDraw = function(graphicIndex)

    if graphicIndex == 1 then
        toDraw = grafik.graphics.grass.normal
    elseif graphicIndex == 2 then
        toDraw = grafik.graphics.water.normal
    elseif graphicIndex == 3 then
        toDraw = grafik.graphics.grass.hilly
    elseif graphicIndex == 4 then
        toDraw = grafik.graphics.grass.dirty
    elseif graphicIndex == 5 then
        toDraw = grafik.graphics.grass.stony
    elseif graphicIndex == 6 then
        toDraw = grafik.graphics.sand.normal
    elseif graphicIndex == 7 then
        toDraw = grafik.graphics.sand.hole
    elseif graphicIndex == 8 then
        toDraw = grafik.graphics.sand.stony
    elseif graphicIndex == 9 then
        toDraw = grafik.graphics.sand.grassy
    end

    return toDraw
end

grafik.loadTransparent = function(imagePath, transR, transG, transB)
   imageData = love.image.newImageData( imagePath )
   function mapFunction(x, y, r, g, b, a)
      if r == transR and g == transG and b == transB then a = 0 end
      return r,g,b,a
   end
   imageData:mapPixel( mapFunction )
   return love.graphics.newImage( imageData )
end

return grafik.init()
