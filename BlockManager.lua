

full_pattern = { 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1,
                 1, 1, 1, 1, 1, 1, 1, 1, 1 };


local GlassBlock = require( "GlassBlock" );
local Vector2     = require( "Vector2" );

-------------------------------------------------
----- BlockManager
-------------------------------------------------
local BlockManager = {};


function BlockManager:GenerateBlocks( block_pattern )

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

      
      if block_pattern[counter] == 0 then -- No Block
        -- Do nothing


      else if block_pattern[counter] == 1 then        
          newBlock = GlassBlock:New( pos, 100, 20 );     -- Create new GlassBlock
      end
      end
      
          
      BlockContainer[counter] = newBlock; -- Add new Block to table
      counter = counter + 1;              -- Increment counter
    end
  end
   
  return BlockContainer; -- Return block table
  
end

return BlockManager;