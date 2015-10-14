local AssetManagerRef  = require( "AssetManager" );
local SoundManagerRef  = require( "SoundManager" );
local Vector2          = require( "Vector2" );
--AssetManagerRef:LoadAssets();

-------------------------------------------------
----- Block
-------------------------------------------------
Block = {
  
  position        = nil;  -- Vector2 position
  width           = 0;    -- Width of the block
  height          = 0;    -- Height of the block
  score_per_hit   = 0;    -- Amount of score per hit
  current_image   = nil;  -- Current image used
  
  
  item_drop             = nil;  -- Item drop type, nil if no item will drop
  max_health              = 0;  -- The maximum # of hits a block can take
  current_health          = 0;  -- The current health of a block 
  num_states              = 0;  -- The # of states of a block 
  change_factor           = 0;  -- The # of hits a block can take per state
  
  
  BlockTypes  = { "GlassBlock" };  -- Enumerations of Block types
  block_type  = nil;               -- The type of Block, must be one of BlockTypes(!)

  BlockStates = { Untouched = "Untouched", Damaged = "Damaged", Broken = "Broken", Destroyed = "Destroyed"  }; -- Enumeration of Block states
  current_state = nil;

  AssetManager  = AssetManagerRef;  -- Reference to AssetManager
  SoundManager  = SoundManagerRef;  -- Reference to SoundManager
  
  
  -- TEST FOR DEBUG
  color = nil;
};

-- Constructor
function Block:New()
  
  newBlock = {};
    
  setmetatable( newBlock, self );
  self.__index = self;
    
  return newBlock;

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

function Block:GetImage() -- Returns the current image
    return self.current_image;
end

function Block:SetPosition( newPosition ) 
  self.position:SetX( newPosition:GetX() );
  self.position:SetY( newPosition:GetY() );
end

function Block:SetWidth( newWidth )
  self.width = newWidth;
end

function Block:SetHeight( newHeight )
  self.height = newHeight;
end

function Block:CheckDestroyed()
  --print( self.current_state );
  return self.current_state == Block.BlockStates["Destroyed"];
end


function Block:GetColor()
  return self.color;
end


function Block:SetColor( newColor )
  self.color = newColor;
end


return Block;