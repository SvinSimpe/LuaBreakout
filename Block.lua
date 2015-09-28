
Block = {
  
  x               = 0;  -- X coordinate 
  y               = 0;  -- Y coordinate
  width           = 0;  -- Width of the block
  height          = 0;  -- Height of the block
  score_per_hit   = 0;  -- Amount of score per hit
  
  
  ItemDrops   = { BallSpeedInc = 1, BallSpeedDec = 2, BoardSizeInc = 3, BoardSizeDec = 4 };
  drop_item   = 0;  -- 
  drop_chance = 0;  -- Chance of drop in percentage
  num_hits    = 0;  -- The maximum # of hits a block can take
  
  
  BlockTypes  = { GlassBlock = "GlassBlock" };  -- Enumerations of Block types
  block_type  = nil;                            -- The type of Block, must be one of BlockTypes(!)

};

-- Constructor
function Block:New()
  newBlock = {};
    
    setmetatable( newBlock, self );
    self.__index = self;
    
    return newBlock;
end


function Block:ToString()
  print( "X: " .. self.x, "Y: " .. self.y, "score_per_hit: " .. self.score_per_hit, "drop_chance: " .. self.drop_chance, "num_hits: " .. self.num_hits );
end

function Block:PrintDrops()
    for i, drop in pairs( self.ItemDrops ) do
      print( drop );
    end
    
end


function Block:Release() -- TEST
  self = nil;
end

function Block:GetX()
  return self.x;
end

function Block:GetY()
  return self.y;
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

function Block:GetDropChance()
  return self.drop_chance;
end

function Block:GetNumHits()
  return self.num_hits;
end



return Block;