
local Vector2 = require( "Vector2" );


-------------------------------------------------
----- Board
-------------------------------------------------
local Board = {
  
  -- Fields
  position  = nil;
  width		  = 0;	
  height	  = 0;   
  speed 	  = 0;
  
};

-- Methods 
function Board:Init( newPosition, newWidth, newHeight, newSpeed )
  self.position = newPosition;
  self.width    = newWidth;
  self.height   = newHeight;
  self.speed    = newSpeed;
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
		return self.width;
end
	
function Board:GetHeight() 
    return self.height;
end
  
function Board:SetWidth( newWidth )
		self.width = newWidth
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
  self.position:SetX( self.position:GetX() - self.speed );
end


function Board:MoveRight()
  self.position:SetX( self.position:GetX() + self.speed );
end


function Board:Update( dt )
  self:CheckCollision();
end


function Board:CheckCollision()
  
  -- Check RIGHT bounds
  if self.position:GetX() + self.width > love.graphics.getWidth() then
    self.position:SetX( love.graphics.getWidth() - self.width );
  end
  
  -- Check LEFT bounds
  if self.position:GetX() < 0 then
    self.position:SetX( 0 );
  end
  
end

return Board;