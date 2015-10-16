
StateManager  = require( "StateManager" );

--local BlockManager  = require( "BlockManager" );
local AssetManager  = require( "AssetManager" );
local SoundManager  = require( "SoundManager" );
local DropManager   = require( "DropManager" );
local Vector2       = require( "Vector2" );



Color = {
  
  White = { R = 255, G = 255, B = 255 };
  
  };


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
     
     
  if( key == "m" ) then
     SoundManager.ToggleSound();
  end
     
  StateManager.HandleKeyboardInput( key );
     

end

     
     
     
  function love.mousepressed( x, y, mouseButton )
    
    StateManager.HandleMouseInput( x, y, mouseButton );
    
  end
