local Vector2 = {
  
  x = 0;
  y = 0;
  
};

function Vector2:New( newX, newY )
    
    local newVector = {}; -- Create new vector object
    
    setmetatable( newVector, self );
    self.__index = self;
    
    
    newVector.x = newX; -- Set x coordinate
    newVector.y = newY; -- Set y coordinate
    
    
    return newVector; -- Return new Vector2 object
end


function Vector2:Length()
    return math.sqrt( ( self.x * self.x ) + ( self.y * self.y ) );
end



function Vector2:GetX()
  return self.x;
end



function Vector2:GetY()
  return self.y;
end



function Vector2:SetX( newX )
  self.x = newX;
end



function Vector2:SetY( newY )
  self.y = newY;
end



return Vector2;