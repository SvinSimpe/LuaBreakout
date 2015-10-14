
local Vector2       = require( "Vector2" );
local SoundManager  = require( "SoundManager" );

-------------------------------------------------
----- Board
-------------------------------------------------
local Board = {
  
  -- Fields
  position    = nil;
  width		    = 0;	
  height	    = 0;   
  speed 	    = 0;
  delta       = 0.0;
  
  
  morph_speed   = 0.0;  
  old_width     = 0;
  current_width = 0.0;
  isMorphing    = false;
  
};

-- Methods 
function Board:Init( newPosition, newWidth, newHeight, newSpeed )
  self.position = newPosition;
  self.width    = newWidth;
  self.height   = newHeight;
  self.speed    = newSpeed;
  
  self.morph_speed   = 300.0;
  self.old_width     = 0;
  self.current_width = self.width;
end

  
function Board:GetX()
  return self.position:GetX();
end
	
function Board:GetY()
  return self.position:GetY();
end
	
function Board:SetX( newX )
		self.x = newX;
end
	
function Board:SetY( newY )
		self.y = newY;
end
	
function Board:GetWidth()
		return self.current_width;
end
	
function Board:GetHeight() 
    return self.height;
end
  
function Board:SetWidth( newWidth )
    
    if( newWidth > self.width ) then
      SoundManager.PlaySound( "Board_Size_Increase" );
    elseif( newWidth < self.width ) then
      SoundManager.PlaySound( "Board_Size_Decrease" );
    end
    
  
    self.old_width  = self.width;
		self.width      = newWidth
    self.isMorphing = true;
end
  
function Board:SetHeight( newHeight )
      self.height = newHeight;
end
  
	
function Board:GetSpeed()
		return self.speed;
end
	
function Board:SetSpeed( newSpeed )
		self.speed = newSpeed;
end
	


function Board:MoveLeft()
  self.position:SetX( self.position:GetX() - self.speed * self.delta );
end


function Board:MoveRight()
  self.position:SetX( self.position:GetX() + self.speed * self.delta );
end


function Board:Update( deltaTime )
  self.delta = deltaTime;
  
  if( self.isMorphing ) then
    self:MorphBoard( deltaTime );
  end
  
  self:CheckCollision();
end

function Board:MorphBoard( deltaTime )
  
  -- If Board is getting bigger
  if( self.width > self.old_width ) then
    
    -- Move x pos to left
    local newX = self.position:GetX();
    newX = newX - self.morph_speed * deltaTime;
    self.position:SetX( newX );
    
    
    -- Move width to right
    local newWidth     = self.current_width;
    newWidth           = newWidth + ( self.morph_speed * deltaTime ) * 2;
    self.current_width = newWidth;
    
    if( self.current_width >= self.width ) then
      self.isMorphing = false;
      self.current_width = self.width;
    end
  
  
  
  -- If Board is getting smaller
  elseif( self.width < self.old_width ) then
    
    -- Move x pos to right
    local newX = self.position:GetX();
    newX = newX + self.morph_speed * deltaTime;
    self.position:SetX( newX );
    
    
    -- Move width to left
    local newWidth     = self.current_width;
    newWidth           = newWidth - ( self.morph_speed * deltaTime ) * 2;
    self.current_width = newWidth;
    
    if( self.current_width <= self.width ) then
      self.isMorphing = false;
      self.current_width = self.width;
    end
    
    
  end

end



function Board:CheckCollision()
  
  -- Check RIGHT bounds
  if self.position:GetX() + self.current_width > love.graphics.getWidth() then
    self.position:SetX( love.graphics.getWidth() - self.current_width );
  end
  
  -- Check LEFT bounds
  if self.position:GetX() < 0 then
    self.position:SetX( 0 );
  end
  
end

return Board;