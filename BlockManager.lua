


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
        print( "block_pattern[" .. counter .."]" .. " is: ", block_pattern[counter] );
        -- Do nothing
        BlockContainer[counter] = nil;


      else if block_pattern[counter] == 1 then        
          newBlock = GlassBlock:New( pos, 100, 20 );     -- Create new GlassBlock
          print( "block_pattern[" .. counter .."]" .. " is: ", block_pattern[counter], "and performing assignment" );  
          table.insert( BlockContainer, newBlock ); -- Add new Block to table
          
          print( "In BlockManager -> #BlockContainer is: " .. #BlockContainer );
      end
      end
      
      counter = counter + 1;              -- Increment counter
      
    end
  end
   
   print( "In BlockManager -> BlockContainer filled with: " .. #BlockContainer .. " blocks" );
  return BlockContainer; -- Return block table
  
end

return BlockManager;