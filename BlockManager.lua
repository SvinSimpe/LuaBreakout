local GlassBlock = require( "GlassBlock" );
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
  
  local counter = 1;
  for i = 1, 8 do
    for j = 1, 9 do     
      
      local xCoord = xStart + 106 * (j-1); -- Set X coordinate
      local yCoord = yStart + 25 * (i-1);  -- Set Y coordinate
      local pos = Vector2:New( xCoord, yCoord );
      local newBlock = {};
    
      -- No Block
      if block_pattern[counter] == 0 then 
        -- No block will created
        BlockContainer[counter] = nil;


      -- Create new GlassBlock
      else if block_pattern[counter] == 1 then        
        newBlock = GlassBlock:New( pos, 100, 20, 9, 3 );     
        table.insert( BlockContainer, newBlock ); -- Add new Block to table
          
      end
      end
      
      counter = counter + 1;
      
    end
  end
   
   print( "In BlockManager -> BlockContainer filled with: " .. #BlockContainer .. " blocks" );
  return BlockContainer; -- Return block table
  
end

return BlockManager;