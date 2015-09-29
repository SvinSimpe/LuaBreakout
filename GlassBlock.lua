
local Block   = require("Block")
local Vector2 = require( "Vector2" );

-------------------------------------------------
----- GlassBlock : public Block
-------------------------------------------------
local GlassBlock = Block:New();
  
  GlassBlock.image_untouched = nil;  -- Image used when GlassBlock is untouched
  GlassBlock.image_damaged   = nil;  -- Image usen when GlassBlock is damaged
  GlassBlock.image_broken    = nil;  -- Image usen when GlassBlock is broken
  
  GlassBlock.current_image   = nil;  -- Current image used
 
-- Constructor
function GlassBlock:New( newPosition, newWidth, newHeight )
    
    --local newGlassBlock = {};
    local newGlassBlock = Block:New();

    setmetatable( newGlassBlock, Block ); -- TEST
    --setmetatable( newGlassBlock, Block );
  
    newGlassBlock.position = newPosition;
    newGlassBlock.width    = newWidth;
    newGlassBlock.height   = newHeight;
    
    return newGlassBlock;
    
end

function GlassBlock:LoadImages()
    
    self.image_untouched = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockUntouched.png" );
    self.image_damaged   = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockDamaged.png" );
    self.image_broken    = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockBroken.png" );
    
    self.current_image   = newGlassBlock.image_untouched;
    
end


return GlassBlock;