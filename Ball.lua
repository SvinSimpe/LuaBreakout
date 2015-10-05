
local Vector2 = require( "Vector2" );


-------------------------------------------------
----- Ball
-------------------------------------------------
Ball = {
  
  -- Fields
  position   = nil;
  direction  = nil;
  speed      = 0;
  radius     = 0;
 
};


function Ball:Init( newPosition, newDirection, newSpeed, newRadius )   
  self.position   = newPosition;
  self.direction  = newDirection;
  self.speed      = newSpeed;
  self.radius     = newRadius;
  print( "Ball initialize complete!" );
  print( "---------------------------------------------------------------" );
end


-- Methods
function Ball:GetX()
	return self.position:GetX();
end

function Ball:GetY()
	return self.position:GetY();
end

function Ball:SetX( newX )
	self.position:SetX( newX );
end

function Ball:SetY( newY )  
	self.position:SetY( newY );
end

function Ball:GetXDirection()
	return self.direction:GetX();
end
	
function Ball:GetYDirection()
	return self.direction:GetY();
end
	
function Ball:SetXDirection( newXDirection )
  self.direction:SetX( newXDirection );
end

	
function Ball:SetYDirection( newYDirection )
  self.direction:SetY( newYDirection );
end

function Ball:SetDirection( newDirection )
  self.direction:SetX( newDirection:GetX() );
  self.direction:SetY( newDirection:GetY() );
end



function Ball:GetRadius()
  return self.radius;
end


function Ball:SetRadius( newRadius )
  self.radius = newRadius;
end


function Ball:Update( deltaTime )
	self.position:SetX( self.position:GetX() + self.direction:GetX() * self.speed * deltaTime ); -- Update X-coordinate
	self.position:SetY( self.position:GetY() + self.direction:GetY() * self.speed * deltaTime ); -- Update X-coordinate
end

-------------------------------------------------

return Ball;