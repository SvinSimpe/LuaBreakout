local DropManager = {
   
  -- Item drop enumerations
  DropTypes         = { "NoDrop", "BallSpeedInc", "BallSpeedDec", "BoardSizeInc", "BoardSizeDec" };
  DropChancePerType = { BallSpeedInc = 10, BallSpeedDec = 10, BoardSizeInc = 5, BoardSizeDec = 5 }
  
  
};

function DropManager:GenerateDrop() -- Returns a drop type 
  
  dropType = love.math.RandomGenerator.random( #DropTypes ); -- Randomize drop type
  
  if dropType == 0 then
    return 0;
  end
  
  --            rand() % 100                         probabililty
  if love.math.RandomGenerator.random( 100 ) < DropChancePerType[dropType] then  
    return DropTypes[dropType]; 
  end
  
  return 0;
end

return DropManager;