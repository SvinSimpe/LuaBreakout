local AssetManagerRef = require( "AssetManager" );
local SoundManagerRef = require( "SoundManager" );
local Entry           = require( "States/Entry" );

-------------------------------------------------
----- BaseState
-------------------------------------------------
local BaseState = {

  AssetManager = AssetManagerRef; --Reference to AssetManager
  SoundManager = SoundManagerRef; --Reference to SoundManager

};

function BaseState:New()

  newState = {};

  setmetatable( newState, self );
  self.__index = self;

  return newState;

end

function BaseState:HandleKeyboardInput( key )
end

function BaseState:HandleMouseInput( mouseX, mouseY, mouseButton )  
end




return BaseState;