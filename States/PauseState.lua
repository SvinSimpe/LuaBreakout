


local BaseState = require( "States/BaseState" );


local PauseState = {
  
  -- Fields for fading effect
  fade_timer  = 0.0;
  fade_factor = 0.0;
  fade_color  = nil;
  isFadingIn  = false;
  isIdle      = false;
  isFadingOut = false;
  
};

function PauseState:Init()
  
  -- Create new instance
  newPauseState = BaseState:New();
  
  -- Set 'BaseState' as base class
  setmetatable( newPauseState, BaseState );
  
  -- Fields
  newPauseState.fade_speed  = 8.0; -- Fade duration
  newPauseState.fade_factor = 0.0; -- Fade factor starts at 0 to generate black screen
  newPauseState.fade_color  = { R = 255, B = 255, G = 255 };
  newPauseState.isFadingIn  = true;
  newPauseState.isIdle      = false;
  newPauseState.isFadingOut = false; 
  
  
  
  -- Methods
  function newPauseState:Update( deltaTime )
    
    if( newPauseState.isFadingIn ) then
      newPauseState:FadeIn( deltaTime );
    
    elseif( newPauseState.isFadingOut ) then
      newPauseState:FadeOut( deltaTime );
    end
    
  end
  
  function newPauseState:Draw()
    
    love.graphics.setColor( newPauseState.fade_color.R * newPauseState.fade_factor,
                            newPauseState.fade_color.G * newPauseState.fade_factor,
                            newPauseState.fade_color.B * newPauseState.fade_factor );

    love.graphics.draw( self.AssetManager:RequestAsset( "Pause_Screen" ) );
  end
  
  function newPauseState:FadeIn( deltaTime )
    -- Increment fade factor
    newPauseState.fade_factor = newPauseState.fade_factor + deltaTime * newPauseState.fade_speed;
  
    -- If fading is complete
    if( newPauseState.fade_factor >= 1.0 ) then
      newPauseState.fade_factor = 1.0;
      newPauseState.isFadingIn = false;  
      newPauseState.isFadingOut  = true;
    end
  end

  function newPauseState:FadeOut( deltaTime )
  
  end
  
  
  return newPauseState;
  
end


return PauseState;