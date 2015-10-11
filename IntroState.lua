
local BaseState = require( "BaseState" );

-------------------------------------------------
----- IntroState
-------------------------------------------------
local IntroState = {
  
  
  
  };


function IntroState:Init()
  
  newIntroState = BaseState:New();
  
  setmetatable( newIntroState, BaseState );
  
  newIntroState.image = newIntroState.AssetManager:RequestAsset( "Splash_Screen" );   
  
  
  
  
  -- Methods
  
  function newIntroState:Update( deltaTime )   
    
  end

  function newIntroState:Draw() 
    love.graphics.draw( self.image );
  end


  


  return newIntroState;
  
end







return IntroState;

