
StateManager  = require( "StateManager" );

--local BlockManager  = require( "BlockManager" );
local AssetManager  = require( "AssetManager" );
local SoundManager  = require( "SoundManager" );
local DropManager   = require( "DropManager" );
local Vector2       = require( "Vector2" );


local Toggle_Debug = false;



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


function love.update( dt )
  
  SoundManager.Update( dt );
  
  StateManager.Update( dt );
  
end

function love.draw()
  
  StateManager.Draw();
  
end

   function love.keypressed( key )
     
     --StateManager.HandleInput( key );
     
     
     
     
     
     
     
     
     if( key == "m" ) then
        SoundManager.ToggleSound();
     end
     
     if( key == "b" ) then
       newPlayState.Board:SetWidth( 160 )
     end
     
     if( key == "s" ) then
       newPlayState.Board:SetWidth( 20 )
     end
     
     if( key == "n" ) then
       newPlayState.Board:SetWidth( 60 )
     end
     
     if( key == "d" ) then
       if( Toggle_Debug ) then
         Toggle_Debug = false;
         print( "Toggle_Debug = false" );
       else
         Toggle_Debug = true;
         print( "Toggle_Debug = true" );
       end
     end
   end

