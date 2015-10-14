
StateManager  = require( "StateManager" );

--local BlockManager  = require( "BlockManager" );
local AssetManager  = require( "AssetManager" );
local SoundManager  = require( "SoundManager" );
local DropManager   = require( "DropManager" );
local Vector2       = require( "Vector2" );






-------------------------------------------------
----- Love2D
-------------------------------------------------
function love.load( arg )

if arg[#arg] == "-debug" then require("mobdebug").start() end


  AssetManager:LoadAssets();

  StateManager.Init();

  
  -- Init SoundManager
  SoundManager.LoadSounds();



end


function love.update( deltaTime )
  
  SoundManager.Update( deltaTime );
  
  StateManager.Update( deltaTime );
  
end

function love.draw()
  
  StateManager.Draw();
  
end

function love.keypressed( key )
     
  StateManager.HandleInput( key );
     
     
  if( key == "m" ) then
     SoundManager.ToggleSound();
  end
  
   -- TEMPORARY
--  if( key == "escape" ) then
--      love.event.quit( )
--  end
     
end

