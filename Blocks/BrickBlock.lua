
local Block         = require("Blocks/Block")
local Vector2       = require( "Vector2" );

-------------------------------------------------
----- BrickBlock : public Block
-------------------------------------------------
local BrickBlock = {};--Block:New();
 
-- Constructor
function BrickBlock:New( newPosition, newWidth, newHeight, newMaxHealth, newNumStates )
    
    local newBrickBlock = Block:New();

    setmetatable( newBrickBlock, Block );
  
    newBrickBlock.position        = newPosition;
    newBrickBlock.width           = newWidth;
    newBrickBlock.height          = newHeight;
    newBrickBlock.current_image   = newBrickBlock.AssetManager:RequestAsset( "BrickBlock_Untouched" );   
    newBrickBlock.max_health      = newMaxHealth;
    newBrickBlock.current_health  = newMaxHealth;
    newBrickBlock.num_states      = newNumStates;
    newBrickBlock.change_factor   = newMaxHealth / newNumStates;
    
    newBrickBlock.current_state = Block.BlockStates["Untouched"];
    
    newBrickBlock.color = { 255, 255, 255 };
    
    -- Methods
    function newBrickBlock:ChangeState( destroy )
  
      -- Instant destroy block
      if( destroy ) then
        self = nil;
        return;
      end
    
    
      if( self.current_state == Block.BlockStates["Untouched"] ) then
        self.current_state = Block.BlockStates["Damaged"];  -- Change block state
        self.current_image = self.AssetManager:RequestAsset( "BrickBlock_Damaged" );  -- Change block image
        self.SoundManager.PlaySound( "BrickBlock_Damaged" );
        
  
      elseif( self.current_state == Block.BlockStates["Damaged"] ) then
        self.current_state = Block.BlockStates["Broken"];  -- Change block state
        self.current_image = self.AssetManager:RequestAsset( "BrickBlock_Broken" );  -- Change block image
        self.SoundManager.PlaySound( "BrickBlock_Broken" );
        
      elseif( self.current_state == Block.BlockStates["Broken"] ) then
        self.current_state = Block.BlockStates["Destroyed"];  -- Change block state
        self.SoundManager.PlaySound( "BrickBlock_Destroyed" );
      
      end 
    end

    function newBrickBlock:Impact( ball_damage )
        
      -- Remove ball damage on Block health
      self.current_health = self.current_health - ball_damage;
      
      if( self.current_health % self.change_factor == 0 ) then -- Change state
        
        self:ChangeState();
      end
        
    end
    
    
    
    
    return newBrickBlock;

end



   
return BrickBlock;