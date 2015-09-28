local Block = require("Block")


local GlassBlock = Block:New();
  
  GlassBlock.image_untouched = nil;  -- Image used when GlassBlock is untouched
  GlassBlock.image_damaged   = nil;  -- Image usen when GlassBlock is damaged
  GlassBlock.image_broken    = nil;  -- Image usen when GlassBlock is broken
  
  GlassBlock.current_image   = nil;  -- Current image used
 
-- Constructor
function GlassBlock:New( newX, newY, width, height )

    local newGlassBlock = {};
    
    setmetatable( newGlassBlock, Block );
    
    
    newGlassBlock.x            = newX;
    newGlassBlock.y            = newY;
    newGlassBlock.width        = width;
    newGlassBlock.height       = height;
    newGlassBlock.drop_chance  = 10;

    
    
    -- GlassBlock methods
    newItem.IsBall = function()
      return isBall;
    end
    
    
    
    return newItem;
    
end


return GlassBlock;