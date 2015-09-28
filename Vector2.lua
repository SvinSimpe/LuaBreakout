local Vector2 = {
  
  x = 0;
  y = 0;
  
};

function Vector2:New( newX, newY )
    
    local newVector = {}; -- Create new vector object
    
    for i, field in pairs( Vector2 ) do -- Copy fields from Vector2
        newVector[i] = field;
    end
    
    newVector.x = newX; -- Set x coordinate
    newVector.y = newY; -- Set y coordinate
    
    return newVector; -- Return new Vector2 object
end


function Vector2:Length()
    return math.sqrt( ( self.x * self.x ) + ( self.y * self.y ) );
end



function Vector2:ToString()
    print( "X: " .. self.x, "Y: " .. self.y );
end

function Vector2:GetX()
  return self.x;
end

function Vector2:GetY()
  return self.y;
end


return Vector2;