
local Vector2 = require( "Vector2" );

-------------------------------------------------
----- Block
-------------------------------------------------
Block = {
  
  position        = nil;  -- Vector2 position
  width           = 0;    -- Width of the block
  height          = 0;    -- Height of the block
  score_per_hit   = 0;    -- Amount of score per hit
  
  
  item_drop   = nil;  -- Item drop type, nil if no item will drop
  num_hits    = 0;    -- The maximum # of hits a block can take
  
  
  BlockTypes  = { "GlassBlock" };  -- Enumerations of Block types
  block_type  = nil;               -- The type of Block, must be one of BlockTypes(!)

};

-- Constructor
function Block:New()
  
  newBlock = {};
    
  setmetatable( newBlock, self );
  self.__index = self;
    
  return newBlock;
end


function Block:ToString()
  print( "X: " .. self.position:GetX(), "Y: " .. self.position:GetY(), "score_per_hit: " .. self.score_per_hit, "drop_chance: " .. self.drop_chance, "num_hits: " .. self.num_hits );
end


function Block:Release() -- TEST
  self = nil;
end

function Block:GetX() 
  return self.position:GetX();
end

function Block:GetY()
  return self.position:GetY();
end

function Block:GetWidth()
  return self.width;
end

function Block:GetHeight()
  return self.height;
end

function Block:GetScorePerHit()
  return self.score_per_hit;
end

function Block:GetNumHits()
  return self.num_hits;
end

function Block:SetPosition( newPosition )
  
  print( "In Block:SetPosition( newPosition ): " .. newPosition:GetX(), newPosition:GetY() )
  
  --self.position = newPosition;
  
  self.position:SetX( newPosition:GetX() );
  self.position:SetY( newPosition:GetY() );
end

function Block:SetWidth( newWidth )
  print( "In Block:SetWidth:", "newWidth:" .. newWidth );
  self.width = newWidth;
end

function Block:SetHeight( newHeight )
  self.height = newHeight;
end


return Block;