Block = {
  
  x               = 0;  -- X coordinate 
  y               = 1;  -- Y coordinate
  width           = 0;  -- Width of the block
  height          = 0;  -- Height of the block
  score_per_hit   = 0;  -- Amount of score per hit
  
  drop_chance = 0;  -- Chance of drop in percentage
  num_hits    = 0;  -- The maximum # of hits a block can take
  
  };

function Block:ToString()
  print( "X:", self.x, "Y:", self.y, "score_per_hit:", self.score_per_hit, "drop_chance", self.drop_chance, "num_hits", self.num_hits );
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





setmetatable( Block, Block );



return Block;