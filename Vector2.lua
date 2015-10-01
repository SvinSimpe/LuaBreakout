



-------------------------------------------------
----- Vector2
-------------------------------------------------
local Vector2 = {
  
  -- Fields
  x = 0;
  y = 0;
  
};


-- Methods
function Vector2:New( newX, newY )
    
    local newVector = {}; -- Create new vector object
    
    setmetatable( newVector, self );
    self.__index = self;
    
    -- Add operator overload
    self.__add = function( vec1, vec2 )
      return Vector2:New( vec1.x + vec2.x, vec1.y + vec2.y ); 
    end
    
    -- Sub operator overload
    self.__sub = function( vec1, vec2 )
      return Vector2:New( vec1.x - vec2.x, vec1.y - vec2.y ); 
    end
    
    -- Mul operator overload
    self.__mul = function( vec1, vec2 )
      return Vector2:New( vec1.x * vec2.x, vec1.y * vec2.y ); 
    end
    
    self.__eq = function( vec1, vec2 )
      return ( vec1.x == vec2.x ) and ( vec1.y == vec2.y );
    end
    
    
    
    newVector.x = newX; -- Set x coordinate
    newVector.y = newY; -- Set y coordinate
    
    
    return newVector; -- Return new Vector2 object
end


function Vector2:tostring()
  print( "Vector2(" .. self:GetX() .. "," .. self:GetY() .. ")" );
end


--[[ Returns the length of a Vector2 instance ]] 
function Vector2:Length()
    return math.sqrt( ( self.x * self.x ) + ( self.y * self.y ) );
end

--[[ Normalize the Vector2 ]] 
function Vector2:Normalize()
  local length = self:Length(); -- Get vector length
  self:SetX( self:GetX() / length );
  self:SetY( self:GetY() / length );
end


--[[ Returns the dot product of vec1 and vec2 ]] 
function Vector2:Dot( vec1, vec2 )
  return ( ( vec1:GetX() * vec2:GetX() ) + ( vec1:GetY() * vec2:GetY() ) );
end


--[[ Returns the product of vec and num ]] 
function Vector2:MulVecNum( vec, num )
  return Vector2:New( vec:GetX() * num, vec:GetY() * num );
end



--[[ Returns the X-coordinate of a Vector2 instance ]] 
function Vector2:GetX()
  return self.x;
end


--[[ Returns the Y-coordinate of a Vector2 instance ]] 
function Vector2:GetY()
  return self.y;
end


--[[ Sets the X-coordinate of a Vector2 instance ]] 
function Vector2:SetX( newX )
  self.x = newX;
end


--[[ Sets the Y-coordinate of a Vector2 instance ]] 
function Vector2:SetY( newY )
  self.y = newY;
end


--[[ Returns a reflected Vector2 ]] 
function Vector2:Reflect( surfaceNormalVector )

  local reflectedVector = Vector2:New( 0, 0 );
  
  Vector2:Normalize( surfaceNormalVector ); -- Normalize surface normal
  
  reflectedVector =  self - Vector2:MulVecNum( ( self * surfaceNormalVector ) , 2 ) * surfaceNormalVector;
  
  print( "HIT!  Direction Vector" );
  
  return reflectedVector;
end



return Vector2;