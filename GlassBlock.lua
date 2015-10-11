
local Block         = require("Block")
local Vector2       = require( "Vector2" );

-------------------------------------------------
----- GlassBlock : public Block
-------------------------------------------------
local GlassBlock = {};--Block:New();
 
-- Constructor
function GlassBlock:New( newPosition, newWidth, newHeight, newMaxHealth, newNumStates )
    
    local newGlassBlock = Block:New();

    setmetatable( newGlassBlock, Block ); -- TEST
  
    newGlassBlock.position        = newPosition;
    newGlassBlock.width           = newWidth;
    newGlassBlock.height          = newHeight;
    newGlassBlock.current_image   = newGlassBlock.AssetManager:RequestAsset( "GlassBlock_Untouched" );   
    newGlassBlock.max_health      = newMaxHealth;
    newGlassBlock.current_health  = newMaxHealth;
    newGlassBlock.num_states      = newNumStates;
    newGlassBlock.change_factor   = newMaxHealth / newNumStates;
    
    newGlassBlock.current_state = Block.BlockStates["Untouched"];
    
    newGlassBlock.color = { 255, 255, 255 };
    
    -- Methods
    function newGlassBlock:ChangeState( destroy )
  
      -- Instant destroy block
      if( destroy ) then
        self = nil;
        return;
      end
    

    
    
      if( self.current_state == Block.BlockStates["Untouched"] ) then
        self.current_state = Block.BlockStates["Damaged"];  -- Change block state
        self.current_image = self.AssetManager:RequestAsset( "GlassBlock_Damaged" );  -- Change block image
        self.SoundManager.PlaySound( "GlassBlock_Damaged" );
        
  
      elseif( self.current_state == Block.BlockStates["Damaged"] ) then
        self.current_state = Block.BlockStates["Broken"];  -- Change block state
        self.current_image = self.AssetManager:RequestAsset( "GlassBlock_Broken" );  -- Change block image
        self.SoundManager.PlaySound( "GlassBlock_Broken" );
        
      elseif( self.current_state == Block.BlockStates["Broken"] ) then
        self.current_state = Block.BlockStates["Destroyed"];  -- Change block state
        self.SoundManager.PlaySound( "GlassBlock_Destroyed" );
      
      end 

   
      

     
    
    end

    function newGlassBlock:Impact( ball_damage )
      
--      if( ball_damage >= self.max_health or self.current_health - ball_damage < 1 ) then
--        --Block will be destroyed
--        self:ChangeState( true );
--        return;
--      end
      
      -- Remove ball damage on Block health
      self.current_health = self.current_health - ball_damage;
      
      if( self.current_health % self.change_factor == 0 ) then -- Change state
        
        self:ChangeState();
      end
        
    end
    
    
    
    
    return newGlassBlock;

end















--function GlassBlock:ChangeState( destroy )
  
--  -- Instant destroy block
--  if( destroy ) then
--    self = nil;
--    return;
--  end
  
  
--  if( self.current_state == Block.BlockStates[Untouched] ) then
--    self.current_state = Block.BlockStates[Damaged];  -- Change block state
--    self.current_image = self.AssetManager:RequestAsset( "GlassBlock_Damaged" );  -- Change block image
  
--  else if( self.current_state == Block.BlockStates[Damaged] ) then
--    self.current_state = Block.BlockStates[Broken];  -- Change block state
--    self.current_image = self.AssetManager:RequestAsset( "GlassBlock_Broken" );  -- Change block image
    
--  else if( self.current_state == Block.BlockStates[Broken] ) then
--    self.current_state = Block.BlockStates[Destroyed];  -- Change block state
--    self = nil; -- TEST remove itself!
--  end
--  end
--  end

   
  
--end

--function GlassBlock:Impact( ball_damage )
  
--  if( ball_damage >= self.max_health or self.current_health - ball_damage < 1 ) then
--    --Block will be destroyed
--    self:ChangeState( true );
--    return;
--  end
  
--  -- Remove ball damage on Block health
--  self.current_health = self.current_health - ball_damage;
  
--  if( self.current_health % self.change_factor == 0 ) then -- Change state
--    self:ChangeState();
--  end
    
--end

   
return GlassBlock;