
local IntroStateRef = require( "IntroState" );
local MenuStateRef  = require( "MenuState" );
local PlayStateRef  = require( "PlayState" );
--local PauseStateRef = require( "PauseState" );

-------------------------------------------------
----- 
-------------------------------------------------
local StateManager = {
  
  States      = { IntroState = nil, MenuState = nil,
                  PlayState = nil, PauseState = nil };
  StateTypes  = { "IntroState", "MenuState", "PlayState", "PauseState"  };
  
  previous_state = nil;
  current_state  = nil;
  
};

function StateManager.Init()
  
  StateManager.States.IntroState = IntroStateRef:Init();
  StateManager.States.MenuState  = MenuStateRef:Init();
  StateManager.States.PlayState  = PlayStateRef:Init();
  
  StateManager.current_state = StateManager.States.IntroState;
  
end



function StateManager.ChangeState( requestedState )
  
  -- Iterate through states
  for _, state in pairs( StateManager.States ) do
    
    -- If state is requested state
    if( state == requestedState ) then
      StateManager.previous_state = StateManager.current_state;
      StateManager.current_state = state;
      return true;
    end 
  end
  
  return false;
end


function StateManager.Update( deltaTime )
  
  StateManager.current_state:Update( deltaTime );
  
end

function StateManager.Draw()
  
  StateManager.current_state:Draw();
  
end




return StateManager;