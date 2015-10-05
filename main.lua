

local BlockManager  = require( "BlockManager" );
local AssetManager  = require( "AssetManager" );
local SoundManager  = require( "SoundManager" );
local DropManager   = require( "DropManager" );
local Vector2       = require( "Vector2" );
local Board         = require( "Board" );
local Ball          = require( "Ball" );


local Toggle_Debug = false;

-------------------------------------------------
----- Love2D
-------------------------------------------------
function love.load( arg )

  if arg[#arg] == "-debug" then require("mobdebug").start() end

  full_pattern = { 1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1 };
  
  diagonal_pattern = { 1, 1, 1, 1, 1, 1, 1, 0, 1,
                       1, 1, 1, 1, 1, 1, 0, 1, 1,
                       1, 1, 1, 1, 1, 0, 1, 1, 1,
                       1, 1, 1, 1, 0, 1, 1, 1, 1,
                       1, 1, 1, 0, 1, 1, 1, 1, 1,
                       1, 1, 0, 1, 1, 1, 1, 1, 1,
                       1, 0, 1, 1, 1, 1, 1, 1, 1,
                       0, 1, 1, 1, 1, 1, 1, 1, 0 };
  
  
	-- Init Board
  Board:Init( Vector2:New( 430, 550 ), 60, 10, 10 )
  
  -- Init Ball
  Ball:Init( Vector2:New( Board:GetX() + Board:GetWidth() * 0.5, Board:GetY() ),
             Vector2:New( math.cos( math.rad( 0 ) ), math.sin( math.rad( -90 ) ) ), 400, 5 );
  
  -- Init Blocks
  AllBlocks = {};
  AllBlocks = BlockManager:GenerateBlocks( full_pattern );
  
  -- Init SoundManager
  SoundManager.LoadSounds();


end


function love.update( dt )
  
  HandleInput();
  
  SoundManager.Update( dt );
  
	Ball:Update( dt );
  Board:Update( dt );
  
  CheckCollision();
end

function love.draw()
	
  -- Draw Background
  love.graphics.setColor( 255, 255, 255 );
  love.graphics.draw( AssetManager:RequestAsset( "Background_DesertNight" ) );
  
  -- Draw Ball
	love.graphics.setColor( 51, 204, 255 );
    love.graphics.circle( "fill", Ball:GetX(), Ball:GetY(), Ball:GetRadius(), 100 ); -- Draw light blue circle with 100 segments.
	
  -- Draw Board
  love.graphics.setColor( 255, 255, 102 );
  love.graphics.rectangle( "fill", Board:GetX(), Board:GetY(), Board:GetWidth(), Board:GetHeight() );
  

  
  
  for _, row in pairs( AllBlocks ) do
    for _, block in pairs( row ) do
      love.graphics.setColor( block:GetColor() );
      love.graphics.draw( block:GetImage(), block:GetX(), block:GetY() ); 
    end 
  end
  
  
  -- Print FPS
  love.graphics.setColor( 255, 255, 255 );
  love.graphics.print( "FPS:" .. love.timer.getFPS(), love.graphics.getWidth() * 0.5 - 20, love.graphics.getHeight() * 0.5, 0, 1.5, 1.5  );
  
end
-------------------------------------------------
----- Other
-------------------------------------------------


function CheckCollision()
   
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

function HandleInput()
  
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


function love.keypressed( key )
   if( key == "m" ) then
      SoundManager.ToggleSound();
   end
   
   if( key == "b" ) then
     Board:SetWidth( 160 )
   end
   
   if( key == "s" ) then
     Board:SetWidth( 20 )
   end
   
   if( key == "n" ) then
     Board:SetWidth( 60 )
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
   
   

end