



-------------------------------------------------
----- AssetManager
-------------------------------------------------
local AssetManager = {
  -- Fields
  AssetTypes = { "Background_DesertNight", "GlassBlock_Untouched", "GlassBlock_Damaged", "GlassBlock_Broken", "Splash_Screen" };
  Assets     = {};
  
};

-- Methods
function AssetManager:LoadAssets()
    
    -- Load Background assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Background assets..." );
    self.Assets[1] = love.graphics.newImage( "Art/Backgrounds/DesertNight.png" );
    print( "In AssetManager -> Loading Background assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    
    -- Load GlassBlock assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading GlassBlock assets..." );
    self.Assets[2] = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockUntouched5.png" );
    self.Assets[3] = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockDamaged.png" );
    self.Assets[4] = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockBroken.png" );
    print( "In AssetManager -> Loading GlassBlock assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    
    -- Load Splash Screen asset
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Splash Screen assets..." );
    self.Assets[5] = love.graphics.newImage( "Art/Backgrounds/SplashScreen.png" );
    print( "In AssetManager -> Loading Splash Screen assets complete!" );
    print( "---------------------------------------------------------------" )
end

function AssetManager:RequestAsset( asset ) -- Returns requested asset, returns false if failed
    
    -- Incorrect request
    if( asset == nil ) then
      return false;
    end
    
    -- Find asset in AssetTypes
    for i = 1, #self.AssetTypes + 1 do
      
      -- Requested asset is found
      if( self.AssetTypes[i] == asset ) then
        return self.Assets[i];
      end  
    end
    
    -- No asset found 
    return false; 
end

return AssetManager;
