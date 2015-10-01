

local BlockManager  = require( "BlockManager" );
local AssetManager  = require( "AssetManager" );
local SoundManager  = require( "SoundManager" );
local DropManager   = require( "DropManager" );
local Vector2       = require( "Vector2" );
local Board         = require( "Board" );
local Ball          = require( "Ball" );


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
             Vector2:New( math.cos( math.rad( 0 ) ), math.sin( math.rad( -90 ) ) ), 100, 5 );
  
  -- Init Blocks
  AllBlocks = {};
  AllBlocks = BlockManager:GenerateBlocks( full_pattern );
  
  -- Init SoundManager
  SoundManager.LoadSounds();





   --- Proving Grounds ---





  -----------------------  

  
end


function love.update( dt )
  
  HandleInput();
  
  SoundManager.Update( dt );
  
	Ball:Update( dt );
  Board:Update( dt );
  
  CheckCollision();
  
  
  print( "Position --> ", Ball:GetX(), Ball:GetY() );
  print( "Direction --> ", Ball:GetXDirection(), Ball:GetYDirection() );
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
  
  
  for i = 1, #AllBlocks do
    
    if( AllBlocks[i] ~= nil ) then
      -- Randomize color
      R = love.math.random( 255 );
      G = love.math.random( 255 );
      B = love.math.random( 255 );
      --love.graphics.setColor( R, G, B );
      love.graphics.setColor( 255, 255, 255 );
        
      -- Place on screen as a 2D matrix 
      love.graphics.draw( AllBlocks[i]:GetImage(), AllBlocks[i]:GetX(), AllBlocks[i]:GetY() );
    end     
  end
  
end
-------------------------------------------------
----- Other
-------------------------------------------------


function CheckCollision()
   
  -- Iterate AllBlocks and check intersect with Ball
  for i, block in pairs( AllBlocks ) do
    
    if( AllBlocks[i] ~= nil ) then
    
      if Ball:GetY() < block:GetY() + block:GetHeight() and
         Ball:GetY() + Ball:GetRadius() * 4 > block:GetY() and
         Ball:GetX() < block:GetX() + block:GetWidth() and
         Ball:GetX() + Ball:GetRadius() * 4 > block:GetX() then
         
         -- We have a hit!
         --block:ChangeState();
         block:Impact( 1 );
         
         Ball:SetDirection( Vector2:New( Ball:GetXDirection(), Ball:GetYDirection() ):Reflect( Vector2:New( 0, -1 ) ) );
          
          
         -- Remove if Block is dead
--         if block:CheckDead() then     
--           table.remove( AllBlocks, i );
--         end
          
--         newYDirection = Ball.GetYDirection() * (-1);
--         Ball.SetYDirection( newYDirection );
      end      
    end
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

end