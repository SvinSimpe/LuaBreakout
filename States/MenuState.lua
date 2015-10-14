
local Entry     = require( "States/Entry" );
local BaseState = require( "States/BaseState" );


-------------------------------------------------
----- MenuState
-------------------------------------------------
local MenuState = {
  
  -- Fields for fading effect
  fade_timer  = 0.0;
  fade_factor = 0.0;
  fade_color  = nil;
  isFadingIn  = false;
  isIdle      = false;
  isFadingOut = false;
  
  
  -- Entries
  Entries = {};
  EntryTypes = { "StartGame", "Options", "Quit" };
  
  };

function MenuState:Init()
  
  newMenuState = BaseState:New();
  
  setmetatable( newMenuState, BaseState );
  
  -- Fields
  newMenuState.fade_timer  = 2.0; -- Fade duration
  newMenuState.fade_factor = 0.0; -- Fade factor starts at 0 to generate black screen
  newMenuState.fade_color  = { R = 255, B = 255, G = 255 };
  newMenuState.isFadingIn  = true;
  newMenuState.isIdle      = false;
  newMenuState.isFadingOut = false; 



  -- Methods

  function newMenuState:Update( deltaTime )
    
    if( newMenuState.isFadingIn ) then
      newMenuState:FadeIn( deltaTime );
    
    elseif( newMenuState.isFadingOut ) then
      newMenuState:FadeOut( deltaTime );
    end
    
  end

  function newMenuState:Draw()

    -- Set color depending on fade factor
    love.graphics.setColor( newMenuState.fade_color.R * newMenuState.fade_factor,
                            newMenuState.fade_color.G * newMenuState.fade_factor,
                            newMenuState.fade_color.B * newMenuState.fade_factor );
                          
    love.graphics.draw( self.AssetManager:RequestAsset( "Background_MenuScreen" ) );
    
  end
  
  function newMenuState:FadeIn( deltaTime )
    
    -- Increment fade factor
    newMenuState.fade_factor = newMenuState.fade_factor + deltaTime;
  
    -- If fading is complete
    if( newMenuState.fade_factor >= 1.0 ) then
      newMenuState.fade_factor = 1.0;
      newMenuState.isFadingIn = false;  
      newMenuState.isFadingOut     = true;
    end
  end
  
  
  function newMenuState:FadeOut( deltaTime )
    
    -- Increment fade factor
    newMenuState.fade_factor = newMenuState.fade_factor - deltaTime;
 
    -- If fading is complete
    if( newMenuState.fade_factor <= 0.0 ) then
      newMenuState.fade_factor = 0.0;
      newMenuState.isFadingOut = false;  
      
      -- test
      StateManager.ChangeState( "PlayState" );
      
      
    end
  end


  return newMenuState;

end






return MenuState;