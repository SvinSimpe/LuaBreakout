
local BaseState     = require( "States/BaseState" );

-------------------------------------------------
----- IntroState
-------------------------------------------------
local IntroState = {
  
  fade_timer  = 0.0;
  fade_factor = 0.0;
  fade_color  = nil;
  isFadingIn  = false;
  isIdle      = false;
  isFadingOut = false;
  isFadingOutQuick = false;
  
  idle_time   = 0.0; -- Time from completely faded in and starting to fade out
  };


function IntroState:Init()
  
  newIntroState = BaseState:New();
  
  setmetatable( newIntroState, BaseState );
  
  
  -- Fields
  newIntroState.fade_speed       = 1.0; 
  newIntroState.fade_factor      = 0.0; -- Fade factor starts at 0 to generate black screen
  newIntroState.fade_color       = { R = 255, B = 255, G = 255 };
  newIntroState.isFadingIn       = true;
  newIntroState.isIdle           = false;
  newIntroState.isFadingOut      = false; 
  newIntroState.isFadingOutQuick = false;
  newIntroState.idle_time        = 3.0;
  
  
  -- Methods
  
  
  function newIntroState:Update( deltaTime )   
    
    if( newIntroState.isFadingOutQuick ) then
      newIntroState:FadeOutQuic( deltaTime );
    else
    
    
      if( newIntroState.isFadingIn ) then
        newIntroState:FadeIn( deltaTime );
        
      elseif( newIntroState.isIdle ) then
        newIntroState.idle_time = newIntroState.idle_time - deltaTime; -- Decrement idle timer
        if( newIntroState.idle_time <= 0.0 ) then
          newIntroState.idle_time   = 0.0;
          newIntroState.isIdle      = false;
          newIntroState.isFadingOut = true;
        end
        
      elseif( newIntroState.isFadingOut ) then
        newIntroState:FadeOut( deltaTime );
      end
    end
    
    
       
  end

  function newIntroState:Draw() 
    
    -- Set color depending on fade factor
    love.graphics.setColor( newIntroState.fade_color.R * newIntroState.fade_factor,
                            newIntroState.fade_color.G * newIntroState.fade_factor,
                            newIntroState.fade_color.B * newIntroState.fade_factor );
    
    -- Draw splash screen
    love.graphics.draw( self.AssetManager:RequestAsset( "Splash_Screen" ) );
  end


  
  function newIntroState:FadeIn( deltaTime )
    
    -- Increment fade factor
    newIntroState.fade_factor = newIntroState.fade_factor + deltaTime * newIntroState.fade_speed;
  
  
    if( newIntroState.fade_factor >= 1.0 ) then
      newIntroState.fade_factor = 1.0;
      newIntroState.isFadingIn = false;  
      newIntroState.isIdle     = true;
    end
  end
  
  function newIntroState:FadeOut( deltaTime )
    
    -- Increment fade factor
    newIntroState.fade_factor = newIntroState.fade_factor - deltaTime * newIntroState.fade_speed;
 
    if( newIntroState.fade_factor <= 0.0 ) then
      newIntroState.fade_factor = 0.0;
      newIntroState.isFadingOut = false;  
      
      -- test
      StateManager.ChangeState( "MenuState" );
      
    end
  end
  
  function newIntroState:FadeOutQuick( deltaTime )
    
    print( "Quick Fade Enabled" );
    
    -- Increment fade factor
    newIntroState.fade_factor = newIntroState.fade_factor - deltaTime * newIntroState.fade_speed;
 
    if( newIntroState.fade_factor <= 0.0 ) then
      newIntroState.fade_factor = 0.0;
      newIntroState.isFadingOut = false;  
      
      -- Change to Menu
      StateManager.ChangeState( "MenuState" );
      
      
    end
  end
  
  
  function newIntroState:HandleInput( key )
    
  end
  
  

  return newIntroState;
end


return IntroState;