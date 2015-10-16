



-------------------------------------------------
----- AssetManager
-------------------------------------------------
local AssetManager = {
  -- Fields
  AssetTypes = { "Background_DesertNight", "Background_MenuScreen",
                 "GlassBlock_Untouched", "GlassBlock_Damaged", "GlassBlock_Broken",
                 "BrickBlock_Untouched", "BrickBlock_Damaged", "BrickBlock_Broken",
                 "Splash_Screen",
                 "Pause_Screen",
                 "Entry_Start", "Entry_Options", "Entry_Highscore", "Entry_Quit"
                  };
  Assets     = {};
  
};

-- Methods
function AssetManager:LoadAssets()
    
    local assetIndex = 1;
    
    -- Load Background assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Background assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/DesertNight.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading Background assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    -- Load Menu assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Menu assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/Blizzard.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading Menu assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    
    -- Load GlassBlock assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading GlassBlock assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockUntouched.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockDamaged.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Blocks/GlassBlock/Image/GlassBlockBroken.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading GlassBlock assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    -- Load BrickBlock assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading BrickBlock assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Blocks/BrickBlock/Image/BrickBlockUntouched.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Blocks/BrickBlock/Image/BrickBlockDamaged.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Blocks/BrickBlock/Image/BrickBlockBroken.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading BrickBlock assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    -- Load Splash Screen asset
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Splash Screen assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/SplashScreen.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading Splash Screen assets complete!" );
    print( "---------------------------------------------------------------" )
    
    

    -- Load Pause Screen asset
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Pause Screen assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/PauseScreen.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading Pause Screen assets complete!" );
    print( "---------------------------------------------------------------" )
    
    
    
    -- Load Entry assets
    print( "---------------------------------------------------------------" )
    print( "In AssetManager -> Loading Entry assets..." );
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/Entry_Start.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/Entry_Options.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/Entry_HighScore.png" ); assetIndex = assetIndex + 1;
    self.Assets[assetIndex] = love.graphics.newImage( "Art/Backgrounds/Entry_Quit.png" ); assetIndex = assetIndex + 1;
    print( "In AssetManager -> Loading Entry assets complete!" );
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
