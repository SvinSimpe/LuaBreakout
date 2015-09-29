
local Block         = require("Block")
local Vector2       = require( "Vector2" );

-------------------------------------------------
----- GlassBlock : public Block
-------------------------------------------------
local GlassBlock = Block:New();
 
-- Constructor
function GlassBlock:New( newPosition, newWidth, newHeight )
    
    local newGlassBlock = Block:New();

    setmetatable( newGlassBlock, Block ); -- TEST
  
    newGlassBlock.position      = newPosition;
    newGlassBlock.width         = newWidth;
    newGlassBlock.height        = newHeight;
    newGlassBlock.current_image = newGlassBlock.AssetManager:RequestAsset( "GlassBlock_Untouched" );     
    
    return newGlassBlock;

end


function GlassBlock:ChangeState()
  
end
   
return GlassBlock;