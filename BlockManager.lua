local GlassBlock = require( "Blocks/GlassBlock" );
local BrickBlock = require( "Blocks/BrickBlock" );
local Vector2    = require( "Vector2" );


-------------------------------------------------
----- BlockManager
-------------------------------------------------
local BlockManager = { NUM_BLOCKS_RESTRICTION = 72 };

-- Methods
--[[ Generate and returns a table of blocks according to the requested block pattern,
     returns false if 'block_pattern' is 'nil' OR if 'block_pattern' is of incorrect size ]]
function BlockManager:GenerateBlocks( block_pattern )

  -- Incorrect request
  if( block_pattern == nil ) then
    print( "Error: Requested block_pattern not allowed to be 'nil' when calling BlockManager:GenerateBlocks( block_pattern )" );
    return false;
  end
  
  
  -- Incorrect request
  if( #block_pattern ~= self.NUM_BLOCKS_RESTRICTION ) then
    print( "Error: Requested block_pattern size must be " .. self.NUM_BLOCKS_RESTRICTION .. " when calling BlockManager:GenerateBlocks( block_pattern )" );
    return false;
  end
  
  
  print( "In BlockManager -> Filling BlockContainer..." );
  local  BlockContainer = {};


  local xStart = 6;   -- X start position on screen
  local yStart = 10;  -- Y start position on screen
  
  local xOffset = 106;
  local yOffset = 25;
  
  local xCoord = 0; 
  local yCoord = 0;
  
  local row       = 1;
  local counter   = 1;
  local newBlock  = {};
  
  
  --------------------------------------------------------------------
  for i = 1, 8 do
    BlockContainer[i] = {};
    for j = 1, 9 do
      
      -- No Block
      if block_pattern[counter] ~= 0 then 
        
        -- Calculate new block coordinates
        xCoord = xStart + xOffset * (j-1);   -- X coordinate
        yCoord = yStart + yOffset * (i-1);  --Y coordinate
        
        
        -- Create new GlassBlock
        if block_pattern[counter] == 1 then        
          newBlock = GlassBlock:New( Vector2:New( xCoord, yCoord ), 100, 20, 3, 3 );     
          table.insert( BlockContainer[i], newBlock ); -- Add new Block to table       
        
        -- Create new GlassBlock
        elseif block_pattern[counter] == 2 then        
          newBlock = BrickBlock:New( Vector2:New( xCoord, yCoord ), 100, 20, 9, 3 );     
          table.insert( BlockContainer[i], newBlock ); -- Add new Block to table       
        end
        
        
        
        -- Add other block types here!
        
     else
      -- No block will created
      BlockContainer[counter] = nil;
     end  
     
     counter = counter + 1;
      
    end
  end
  
  ------------------------------------------------------------------------

  

  print( "In BlockManager -> BlockContainer filled with: " .. #BlockContainer .. " blocks" );
  return BlockContainer; -- Return block table
  
end

return BlockManager;