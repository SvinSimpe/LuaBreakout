
--- Block Patterns ---
local Pattern_Full = require( "Pattern_Full" );


-- Components ---
local BaseState     = require( "BaseState" );
local BlockManager  = require( "BlockManager" );
local Board         = require( "Board" );
local Ball          = require( "Ball" );



----------------------

local PlayState = {
  
  BlockContainer = nil;
  
  };


function PlayState:Init()
  
  newPlayState = BaseState:New();
  
  setmetatable( newPlayState, BaseState );
  
  -- Fill 'BlockContainer' according to requested pattern
  newPlayState.BlockContainer = BlockManager:GenerateBlocks( Pattern_Full );
  
  
  
  -- Methods
  
  function newPlayState:Update( deltaTime )
    self.CheckCollision();
  end

  function newPlayState:Draw()
  
  end
  
  
  function newPlayState:HandleInput()
  
  -- Check LEFT key
  if love.keyboard.isDown( "left" ) then
      Board:MoveLeft();
    -- Check RIGHT key  
    else if love.keyboard.isDown( "right" ) then
        Board:MoveRight(); 
    end
  end
  
  -- Check ESC
  if love.keyboard.isDown( "escape" ) then
    love.event.quit( )
  end
  
  
  
  
  

end


  
  
  
  function newPlayState:CheckCollision()
   
   ----------------------------------
   -- Check Ball collision with walls
   ----------------------------------
   
  
   -- Only check collision with top wall if the upper
   -- row of blocks has been breached
   if( #AllBlocks > 9 ) then
     
     if( Ball:GetY() < 0 ) then
       Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( 0, -1 ) ) );
       -- SoundManager:PlaySound( "wall bounce " );
     end
   end
   
   
   -- Bottom wall
   if( Ball:GetY() > love.graphics.getHeight() ) then
      love.event.quit();  -- Quit game
   end
   
   
   -- Left wall
   if( Ball:GetX() < 0 ) then
    Ball:SetX( 0 );
    Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( 1, 0 ) ) );
     -- SoundManager:PlaySound( "wall bounce " );
   end
   
   -- Left wall
   if( Ball:GetX() > love.graphics.getWidth()  ) then
     Ball:SetX( love.graphics.getWidth() )
    Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( -1, 0 ) ) );
     -- SoundManager:PlaySound( "wall bounce " );
   end
   
   
   ----------------------------------
   -- Check Ball collision with board
   ----------------------------------
      
   if Ball:GetY() < Board:GetY() + Board:GetHeight() and
      Ball:GetY() + Ball:GetRadius() > Board:GetY() and
      Ball:GetX() < Board:GetX() + Board:GetWidth() and
      Ball:GetX() + Ball:GetRadius() > Board:GetX() then
    
    Ball:SetY( Board:GetY() );
    Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( 0, 1 ) ) );
      
    end
    
    
   
   
   -----------------------------------
   -- Check Ball collision with blocks
   ----------------------------------- 
  local rowBelow  = 2;
  local lastRow   = false;
  
  
  for i = 1, #AllBlocks do
      
     -- Check if we're on the last row
     if( rowBelow > #AllBlocks or #AllBlocks[rowBelow] == 0 ) then
        rowBelow  = rowBelow - 1;
        lastRow   = true;
     end
    
     if( #AllBlocks[rowBelow] ~= 0 and #AllBlocks[rowBelow] ~= 9 or lastRow ) then
       
       for j, block in pairs( AllBlocks[i] ) do
         
         if( block ~= nil ) then
           
           block:SetColor( { 255, 255, 255 } );
           if( Toggle_Debug ) then
              block:SetColor( { 0, 255, 0 } ); -- Paint collision visible blocks green
           end
          
           if( Ball:GetY() < block:GetY() + block:GetHeight() and
            Ball:GetY() + Ball:GetRadius() * 4 > block:GetY() and
            Ball:GetX() < block:GetX() + block:GetWidth() and
            Ball:GetX() + Ball:GetRadius() * 4 > block:GetX() ) then
           
             -- We have a hit!
             block:Impact( 1 );
             
             -- Remove block from collection
             if( block:CheckDestroyed() ) then
               print( "Destroy block in row: " .. i .. " and column: " .. j );
               table.remove( AllBlocks[i], j );           
             end
             
             -- Modify Ball
             Ball:SetY( block:GetY() + block:GetHeight() );
             Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( 0, -1 ) ) ); 
             
           end
         end       
       end
     end
     rowBelow = rowBelow + 1;
   end
end
  
  
  
  
  

  -- Returns the new PlayState
  return newPlayState;
  
end





return PlayState;