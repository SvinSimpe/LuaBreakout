
--- Block Patterns ---
local Pattern_Full = require( "Pattern_Full" );


-- Components ---
local BaseState     = require( "States/BaseState" );
local BlockManager  = require( "BlockManager" );
local BoardRef      = require( "Board" );
local BallRef       = require( "Ball" );
local Vector2       = require( "Vector2" );



local Toggle_Debug = false;



local PlayState = {
  
  BlockContainer = nil;
  Board          = nil;
  Ball           = nil;
  
  };


function PlayState:Init()
  
  newPlayState = BaseState:New();
  
  setmetatable( newPlayState, BaseState );

  
  -- Fill 'BlockContainer' according to requested pattern
  newPlayState.BlockContainer = BlockManager:GenerateBlocks( Pattern_Full );
  
  -- Init Board
  newPlayState.Board = BoardRef;
  newPlayState.Board:Init( Vector2:New( 430, 550 ), 60, 10, 500 )
  
  -- Init Ball
  local ballSpeed = 400;
  
  
  
  
  newPlayState.Ball = BallRef;
  newPlayState.Ball:Init( Vector2:New( newPlayState.Board:GetX() + newPlayState.Board:GetWidth() * 0.5, newPlayState.Board:GetY() - 10 ),
             Vector2:New( math.cos( math.rad( 45 ) ), math.sin( math.rad( -45 ) ) ), ballSpeed, 5 );
  
  
  
  
  
  
  -- Methods
  
  function newPlayState:Update( deltaTime )
    
    
    self.HandleStaticKeyInput();
    self.CheckCollision();
    
    Ball:Update( deltaTime );
    newPlayState.Board:Update( deltaTime );
    
  end

  function newPlayState:Draw()
    
    -- Draw Background
    love.graphics.setColor( 255, 255, 255 );
    love.graphics.draw( self.AssetManager:RequestAsset( "Background_DesertNight" ) );
    
    -- Draw Ball
    love.graphics.setColor( 51, 204, 255 );
    love.graphics.circle( "fill", Ball:GetX(), Ball:GetY(), Ball:GetRadius(), 100 ); -- Draw light blue circle with 100 segments.
    
    -- Draw Board
    love.graphics.setColor( 255, 255, 102 );
    love.graphics.rectangle( "fill", newPlayState.Board:GetX(), newPlayState.Board:GetY(), newPlayState.Board:GetWidth(), newPlayState.Board:GetHeight() );
    

    
    
    for _, row in pairs( newPlayState.BlockContainer ) do
      for _, block in pairs( row ) do
        love.graphics.setColor( block:GetColor() );
        love.graphics.draw( block:GetImage(), block:GetX(), block:GetY() ); 
      end 
    end
    
    
    if( Toggle_Debug ) then
      -- Print FPS
      love.graphics.setColor( 255, 255, 255 );
      love.graphics.print( "FPS:" .. love.timer.getFPS(), love.graphics.getWidth() * 0.5 - 20, love.graphics.getHeight() * 0.5, 0, 1.5, 1.5  );
    end
    
    
    local font = love.graphics.newFont("atari full.ttf", 15)
    love.graphics.setFont( font );
    love.graphics.print( "Hej", 400, 400 );
    
    
    
  end
  
  



  
  
  
  function newPlayState:CheckCollision()
   
   ----------------------------------
   -- Check Ball collision with walls
   ----------------------------------
   
  
   -- Only check collision with top wall if the upper
   -- row of blocks has been breached
   if( #newPlayState.BlockContainer > 9 ) then
     
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
      
   if Ball:GetY() < newPlayState.Board:GetY() + newPlayState.Board:GetHeight() and
      Ball:GetY() + Ball:GetRadius() > newPlayState.Board:GetY() and
      Ball:GetX() < newPlayState.Board:GetX() + newPlayState.Board:GetWidth() and
      Ball:GetX() + Ball:GetRadius() > newPlayState.Board:GetX() then
    
    Ball:SetY( newPlayState.Board:GetY() - 10 );
    Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( 0, 1 ) ) ); 
    end
    
   
   -----------------------------------
   -- Check Ball collision with blocks
   ----------------------------------- 
  local rowBelow  = 2;
  local lastRow   = false;
  
  
  for i = 1, #newPlayState.BlockContainer do
      
     -- Check if we're on the last row
     if( rowBelow > #newPlayState.BlockContainer or #newPlayState.BlockContainer[rowBelow] == 0 ) then
        rowBelow  = rowBelow - 1;
        lastRow   = true;
     end
    
     if( #newPlayState.BlockContainer[rowBelow] ~= 0 and #newPlayState.BlockContainer[rowBelow] ~= 9 or lastRow ) then
       
       for j, block in pairs( newPlayState.BlockContainer[i] ) do
         
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
               table.remove( newPlayState.BlockContainer[i], j );           
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
  
  



  function newPlayState:HandleKeyboardInput( key )
    
    print( "In Playtate:HandleKeyBoardInput( key ) -->" .. key );
    
    if( key == "b" ) then
       newPlayState.Board:SetWidth( 160 )
     end
     
     if( key == "s" ) then
       newPlayState.Board:SetWidth( 20 )
     end
     
     if( key == "n" ) then
       newPlayState.Board:SetWidth( 60 )
     end
    
    if( key == "d" ) then
       if( Toggle_Debug ) then
         Toggle_Debug = false;
         print( "Toggle_Debug = false" );
       else
         Toggle_Debug = true;
         print( "Toggle_Debug = true" );
       end
     end
     
    if( key == "p" ) then
      StateManager.ChangeState( "PauseState", "PlayState" );
    end
    
    if( key == "escape" ) then
      love.event.quit();
    end
    
  end

  
  
    
    
  function newPlayState:HandleStaticKeyInput()
    -- Check LEFT key
    if love.keyboard.isDown( "left" ) then
        newPlayState.Board:MoveLeft();
      -- Check RIGHT key  
      else if love.keyboard.isDown( "right" ) then
          newPlayState.Board:MoveRight(); 
      end
    end
  end



  
  

  -- Returns the new PlayState
  return newPlayState;
end



return PlayState;