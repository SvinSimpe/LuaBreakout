
local IntroStateRef = require( "States/IntroState" );
local MenuStateRef  = require( "States/MenuState" );
local PlayStateRef  = require( "States/PlayState" );
local PauseStateRef = require( "States/PauseState" );

-------------------------------------------------
----- 
-------------------------------------------------
local StateManager = {
  
  States      = nil;
  StateTypes  = nil;
  
  previous_state = nil;
  current_state  = nil;
  
  previous_state_type = "";
  current_state_type  = "";
};

function StateManager.Init()
  
  StateManager.StateTypes = { "IntroState", "MenuState", "PlayState", "PauseState"  };
  
  -- Initialize all states
  StateManager.States    = {};
  StateManager.States[1] = IntroStateRef:Init();
  StateManager.States[2] = MenuStateRef:Init();
  StateManager.States[3] = PlayStateRef:Init();
  StateManager.States[4] = PauseStateRef:Init();
  
  -- Set 'IntroState' as current state
  StateManager.current_state = StateManager.States[1];
  current_state_type = "IntroState";
  
end



function StateManager.ChangeState( requestedState, prevState )
  
  -- Iterate through states
  for i, state in pairs( StateManager.StateTypes ) do
    
    -- If state is requested state
    if( state == requestedState ) then
      StateManager.previous_state = StateManager.current_state;
      StateManager.current_state = StateManager.States[i];
      
      StateManager.previous_state_type = prevState;
      StateManager.current_state_type = state;
      return true;
    end 
  end
  
  return false;
end


function StateManager.Update( deltaTime )
  
  StateManager.current_state:Update( deltaTime );
  
end

function StateManager.Draw()
  
  if( StateManager.previous_state_type == "PlayState" ) then
    StateManager.previous_state:Draw();
  end
  
  StateManager.current_state:Draw();
  
end




return StateManager;