

local BlockManager  = require( "BlockManager" );
local AssetManager  = require( "AssetManager" );
local DropManager   = require( "DropManager" );
local Vector2       = require( "Vector2" );

-------------------------------------------------
----- Debug
-------------------------------------------------
isSoundActivated = true;



-------------------------------------------------
----- Background
-------------------------------------------------
Background = {}
Background.image = love.graphics.newImage( "background2.png" );

Background.music = love.audio.newSource( "Sound/soundtrack.mp3" );
-------------------------------------------------



-------------------------------------------------
----- Ball
-------------------------------------------------
Ball = {}

 -- Fields
Ball.x          = 0;
Ball.y          = 0;
Ball.xDirection = 0;
Ball.yDirection = 0;
Ball.radius     = 0;
Ball.wall_bounce_sound = love.audio.newSource( "Sound/wall_sound.wav" );


-- Methods
Ball.GetX = function()
	return Ball.x
end

Ball.GetY = function()
	return Ball.y;
end

Ball.SetX = function( newX )
	Ball.x = newX;
end

Ball.SetY = function( newY )
	Ball.y = newY;
end
	
Ball.GetXDirection = function()
	return Ball.xDirection;
end
	
Ball.GetYDirection = function()
	return Ball.yDirection;
end
	
Ball.SetXDirection = function( newXDirection )
	Ball.xDirection = newXDirection;
end
	
Ball.SetYDirection = function( newYDirection )
	Ball.yDirection = newYDirection;
end
	
Ball.GetRadius = function()
  return Ball.radius;
end

Ball.SetRadius = function( newRadius )
  Ball.radius = newRadius;
end


Ball.Update = function( dt )
	Ball.x = Ball.x + Ball.xDirection * dt;
	Ball.y = Ball.y + Ball.yDirection * dt;
  
  Ball.CheckCollision();
end

Ball.CheckCollision = function()
  
  -- Check collision with Board
  
  if Ball.GetY() < Board.GetY() + Board.GetHeight()     and
     Ball.GetY() + Ball.GetRadius() > Board.GetY()  and
     Ball.GetX() < Board.GetX() + Board.GetWidth()      and
     Ball.GetX() + Ball.GetRadius() > Board.GetX() then
  
  
  
  
--  if Ball.y + Ball.radius > Board.GetY() and        -- Ball.y is larger than Board.y
--     Ball.x + Ball.radius > Board.GetX() and        -- Ball.x is larger than Board.x
--     Ball.x  < Board.GetX() + Board.GetWidth() then -- Ball.x is less than Board.x
        newYDirection = Ball.GetYDirection() * (-1);
        Ball.SetYDirection( newYDirection );
        if isSoundActivated then
          love.audio.play( Board.bounce_sound );
        end
        
end
      



	-- Check Bottom
	if Ball.GetY() > 600 then
   -- love.event.quit( )
		newYDirection = Ball.GetYDirection() * (-1);
    Ball.SetYDirection( newYDirection );
  
		-- Check  Top
		else if Ball.GetY() < 0 then
			newYDirection = Ball.GetYDirection() * (-1);
      Ball.SetYDirection( newYDirection );
      if isSoundActivated then
        love.audio.play( Ball.wall_bounce_sound );
      end
      
      
		end
		
	end
	
	-- Check Right
	if Ball.GetX() + Ball.GetRadius() > 960 then
    Ball.SetX( 960 - Ball.GetRadius() );
		newXDirection = Ball.GetXDirection() * (-1);
    Ball.SetXDirection( newXDirection );
    if isSoundActivated then
      love.audio.play( Ball.wall_bounce_sound );
    end
		
		-- Check Left
		else if Ball.GetX() * 2 < 0 then
			newXDirection = Ball.GetXDirection() * (-1);
      Ball.SetXDirection( newXDirection );
      if isSoundActivated then
        love.audio.play( Ball.wall_bounce_sound );
      end
		end
		
	end
	
end
-------------------------------------------------



-------------------------------------------------
----- Board
-------------------------------------------------
Board = {}

-- Fields
Board.x			  = 0;
Board.y			  = 0;
Board.width		= 0;	
Board.height	= 0;
Board.speed 	= 0;
Board.bounce_sound  = love.audio.newSource( "Sound/board_bounce_sound.wav" );
  
-- Methods 
Board.GetX = function()
		return Board.x;
	end
	
Board.GetY = function()
    return Board.y;
	end
	
Board.SetX = function( newX )
		Board.x = newX;
	end
	
Board.SetY = function( newY )
		Board.y = newY;
	end
	
Board.GetWidth = function()
		return Board.width;
	end
	
Board.GetHeight = function()
    return Board.height;
  end
  
Board.SetWidth = function( newWidth )
		Board.width = newWidth
	end
  
Board.SetHeight = function( newHeight )
      Board.height = newHeight;
  end
  
	
Board.GetSpeed = function()
		return Board.speed;
	end
	
Board.SetSpeed = function( newSpeed )
		Board.speed = newSpeed;
	end
	


Board.MoveLeft = function()
  Board.x = Board.x - Board.speed;
end
Board.MoveRight = function()
  Board.x = Board.x + Board.speed;
end


Board.Update = function( dt )
  Board.CheckCollision();
end


Board.CheckCollision = function()
  
  -- Check RIGHT bounds
  if Board.x + Board.width > 960 then
    Board.x = 960 - Board.width;
  end
  
  if Board.x < 0 then
    Board.x = 0;
  end
  
end


--------------------------


-------------------------------------------------
----- Block
-------------------------------------------------
Block = {
  
  x       = 0,
  y       = 0,
  width   = 0,
  height  = 0,
  state  = { "dead", "broken", "damaged" },
  current_state = nil;
  color = color_FULL;
  
  damaged_sound = love.audio.newSource( "Sound/block_damaged_sound.wav" ),
  broken_sound = love.audio.newSource( "Sound/block_broken_sound.wav" ),
  dead_sound = love.audio.newSource( "Sound/block_dead_sound.wav" ),
  
}
  
  function Block:GetX()
    return self.x
  end
  
  function Block:GetY()
    return self.y;
  end
  
  function Block:SetX( newX )
    self.x = newX;
  end
  
  function Block:SetY( newY )
    self.y = newY;
  end
  
  function Block:GetWidth()
    return self.width;
  end 
  
  function Block:GetHeight()
    return self.height;
  end
  
  function Block:SetWidth( newWidth )
    self.width = newWidth;
  end
  
  function Block:SetHeight( newHeight )
    self.height = newHeight;
  end
  
  function Block:ChangeState()
  
    if self.current_state == nil then  
      self.current_state = Block.state[3]; -- Damaged
      self.color = color_DAMAGED;
      if( isSoundActivated ) then
        love.audio.play( Block.damaged_sound );
      end   
        else if self.current_state == Block.state[3] then  
          self.current_state = Block.state[2]; -- Broken
          self.color = color_BROKEN;
          if( isSoundActivated ) then
            love.audio.play( Block.broken_sound );
          end
             
          else if self.current_state == Block.state[2] then
            self.current_state = Block.state[1]; -- Dead
            self.color = color_DEAD;
            if( isSoundActivated ) then
              love.audio.play( Block.dead_sound );
            end
          end
        end    
    end
  end
  
  function Block:CheckDead() 
    if self.current_state == Block.state[1] then
      return true;
    end  
       
  end
   
  function Block:New()
    
      newBlock = {};
      
      for k, v in pairs( Block ) do
        newBlock[k] = v;
      end
      
      return newBlock;
  end
  
  
  function CheckBlock1Collision()
  
    
    for i = 1, num_blocks do
      
      if AllBlocks[i] == nil then return end -- Check if Block exists
      
        if Ball.y < AllBlocks[i]:GetY() + AllBlocks[i]:GetHeight() and              -- Ball.y is larger than Board.y
           Ball.x > AllBlocks[i]:GetX() and                                         -- Ball.x is larger than Board.x
           Ball.x + Ball.radius < AllBlocks[i]:GetX() + AllBlocks[i]:GetWidth() then -- Ball.x is less than Board.x
       
       
          AllBlocks[i]:ChangeState();
          AllBlocks[i]:CheckDead();
          newYDirection = Ball.GetYDirection() * (-1);
          Ball.SetYDirection( newYDirection );       
      end      
    end 
  end
  

-------------------------------------------------
----- Love2D
-------------------------------------------------
function love.load( arg )
  
  if arg[#arg] == "-debug" then require("mobdebug").start() end

  full_pattern = { 0, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   1, 0, 1, 1, 1, 1, 0, 1, 1,
                   1, 1, 1, 1, 1, 1, 1, 1, 1,
                   0, 1, 0, 1, 1, 1, 1, 1, 0,
                   0, 0, 1, 1, 1, 1, 1, 0, 0,
                   1, 0, 0, 0, 0, 0, 0, 0, 0 };
  
  full_pattern = { 1, 1, 1, 1, 1, 1, 1, 0, 1,
                   1, 1, 1, 1, 1, 1, 0, 1, 1,
                   1, 1, 1, 1, 1, 0, 1, 1, 1,
                   1, 1, 1, 1, 0, 1, 1, 1, 1,
                   1, 1, 1, 0, 1, 1, 1, 1, 1,
                   1, 1, 0, 1, 1, 1, 1, 1, 1,
                   1, 0, 1, 1, 1, 1, 1, 1, 1,
                   0, 1, 1, 1, 1, 1, 1, 1, 0 };
  
  AllBlocksUpdated = BlockManager:GenerateBlocks( full_pattern );

  
	-- Init Board
	Board.SetX( 430 );
	Board.SetY( 550 );
	Board.SetWidth( 60 );   --Default 60  
	Board.SetHeight( 10 );  --Default 10
	Board.SetSpeed( 10 );
  
  -- Init Ball
	Ball.SetX( Board.GetX() + Board.GetWidth() * 0.5 );
	Ball.SetY( Board.GetY() );
	Ball.SetXDirection( 250 );
	Ball.SetYDirection( -250 );
  Ball.SetRadius( 5 );
  
  -- Init Blocks
  AllBlocks = {}

    
  if isSoundActivated then
    love.audio.play( Background.music );
  end
  
  
  AllBlocks = nil;
  AllBlocks = AllBlocksUpdated; 
  
end


function love.update( dt )
  
	Ball.Update( dt );
  Board.Update( dt );
  HandleInput();
  --CheckBlockCollision(); 
  
end

function love.draw()
	
  -- Draw Background
  love.graphics.setColor( 255, 255, 255 );
  love.graphics.draw( Background.image );
  
  -- Draw Ball
	love.graphics.setColor( 51, 204, 255 );
    love.graphics.circle( "fill", Ball.GetX(), Ball.GetY(), Ball.GetRadius(), 100 ); -- Draw light blue circle with 100 segments.
	
  -- Draw Board
  love.graphics.setColor( 255, 255, 102 );
  love.graphics.rectangle( "fill", Board.GetX(), Board.GetY(), Board.GetWidth(), Board.GetHeight() );
  
  xPos = 10;
  yPos = 10;
  
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
      --love.graphics.rectangle( "fill", AllBlocks[i]:GetX(), AllBlocks[i]:GetY(), AllBlocks[i]:GetWidth(), AllBlocks[i]:GetHeight() );
    end     
  end
  
end
-------------------------------------------------
----- Other
-------------------------------------------------


function CheckBlockCollision()
  
  print( "In main -> CheckBlockCollision:", "#AllBlocks:" .. #AllBlocks );
  
  -- Iterate AllBlocks and check intersect with Ball
  for i, block in pairs( AllBlocks ) do
    
    if( AllBlocks[i] ~= nil ) then
    
      if Ball.GetY() < block:GetY() + block:GetHeight() and
         Ball.GetY() + Ball.GetRadius() * 4 > block:GetY() and
         Ball.GetX() < block:GetX() + block:GetWidth() and
         Ball.GetX() + Ball.GetRadius() * 4 > block:GetX() then
         
         -- We have a hit!
         block:ChangeState();
          
         -- Remove if Block is dead
         if block:CheckDead() then     
           table.remove( AllBlocks, i );
         end
          
         newYDirection = Ball.GetYDirection() * (-1);
         Ball.SetYDirection( newYDirection );
      end      
    end
  end
    
end

function HandleInput()
  
  -- Check LEFT key
  if love.keyboard.isDown( "left" ) then
      Board.MoveLeft();
    -- Check RIGHT key  
    else if love.keyboard.isDown( "right" ) then
        Board.MoveRight(); 
    end
  end
  
  -- Check ESC
  if love.keyboard.isDown( "escape" ) then
    love.event.quit( )
  end

end