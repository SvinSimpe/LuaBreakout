local AssetManagerRef = require( "AssetManager" );
local SoundManagerRef = require( "SoundManager" );
local Entry           = require( "Entry" );

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


return BaseState;