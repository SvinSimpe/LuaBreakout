
local Entry     = require( "Entry" );
local BaseState = require( "BaseState" );

-------------------------------------------------
----- MenuState
-------------------------------------------------
local MenuState = {
  
  Entries = {};
  EntryTypes = { "StartGame", "Options", "Quit" };
  
  };

function MenuState:Init()
  
  newMenuState = BaseState:New();
  
  setmetatable( newMenuState, BaseState );
  

  -- Methods

  function MenuState:Update( deltaTime )
  end

  function MenuState:Draw()
  end


end






return MenuState;