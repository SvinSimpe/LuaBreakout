local Vector2 = require( "Vector2" );

-------------------------------------------------
----- BaseDrop
-------------------------------------------------
local BaseDrop = {
  
  position    = Vector2:New( 0, 0 );  -- Position (x,y) of the ItemDrop
  width       = 0;    -- Width of the item
  height      = 0;    -- Heigth of the item
  drop_image  = nil;  -- Image of the ItemDrop
  drop_type   = nil;  -- Item drop type, must be one of ItemDrops enum(!)
 
  -- Item drop enumerations
  ItemDrops         = { NoDrop = 0, BallSpeedInc = 1, BallSpeedDec = 2, BoardSizeInc = 3, BoardSizeDec = 4 };
  DropChancePerItem = { 10, 10, 5, 5 }
};

function BaseDrop:New()
    newDrop = {};
    
    setmetatable( newDrop, self );  
    self.__index = self;
    
    return newDrop;
end



function BaseDrop:GetPosition()
  return self.position; -- Returns a Vector2 with position
end

function BaseDrop:SetPosition( newPosition )
  self.position.SetX( newPosition.GetX() ); -- Set new X coordinate
  self.position.SetY( newPosition.GetY() ); -- Set new Y coordinate
end

function BaseDrop:GetWidth()
  return self.width;
end

function BaseDrop:GetHeigth()
  return self.height;
end

function BaseDrop:GetImage()
  return self.drop_image;
end

function BaseDrop:GetDropType()
  return self.drop_type;
end

function BaseDrop:GenerateDropType()
  return love.math.RandomGenerator.random( 5 ) - 1;  -- Return drop type
end


function BaseDrop:GenerateDrop( probabilityFactor )
    return love.math.RandomGenerator.random( 100 ) <= probabilityFactor;
end

function BaseDrop:SetDrop()
  
  random_drop_type = self:GenerateDropType();
  
  if GenerateDrop( self.DropChancePerItem[random_drop_type] ) then -- If a drop has been generated
    
    for v, k in pairs( ItemDrops ) do
    
      if k == random_drop_type then
        self.dropType = k;
      end
    end
  end
end




-------------------------------------------------
----- BallSpeedInc : public BaseDrop
-------------------------------------------------
local BallSpeedInc = BaseDrop:New();

function BallSpeedInc:New( x, y, width, height )
  
  newBallSpeedInc = {}; -- Create new BallSpeedInc instance
  
  setmetatable( newBallSpeedInc, BaseDrop );  -- Set BaseDrop as metatable
  
  
  -- BallSpeedInc Methods
  
  
  
  
  
  
  
  
  return newBallSpeedInc;
  
end


local BallSpeedDec = {
  
  drop_type = type(self);
  
};

local BoardSizeInc = {
  
  drop_type = type(self);
  
};

local BoardSizeDec = {
  
  drop_type = type(self);
  
};
