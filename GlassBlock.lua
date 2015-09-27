local Block = require("Block")


GlassBlock = {};

function GlassBlock:GlassPrint()
  
  Block:ToString();
  print( "In GlassBlock" );
  
end

return GlassBlock;