
local Entry     = require( "States/Entry" );
local BaseState = require( "States/BaseState" );
local Vector2   = require( "Vector2" );




local mousePoint = { x = 0, y = 0 };


-------------------------------------------------
----- MenuState
-------------------------------------------------
local MenuState = {
  
  -- Fields for fading effect
  fade_timer  = 0.0;
  fade_factor = 0.0;
  fade_color  = nil;
  isFadingIn  = false;
  isIdle      = false;
  isFadingOut = false;
  
  
  -- Entries
  EntryTypes = nil;
  Entries = nil;
  
  next_state = "";
  
  
  };

function MenuState:Init()
  
  -- Create new instance 
  newMenuState = BaseState:New();
  setmetatable( newMenuState, BaseState );
  
  -- Fields
  newMenuState.fade_timer  = 2.0; -- Fade duration
  newMenuState.fade_factor = 0.0; -- Fade factor starts at 0 to generate black screen
  newMenuState.fade_color  = { R = 255, B = 255, G = 255 };
  newMenuState.isFadingIn  = true;
  newMenuState.isIdle      = false;
  newMenuState.isFadingOut = false; 
  
  newMenuState.EntryTypes = { "StartGame", "Options", "Quit" };
  newMenuState.Entries    = {};
  
  -- Create Entries
  newMenuState.Entries[1] = Entry:New( Vector2:New( 330, 100 ), 300, 53, "PlayState",      "Entry_Start" );
  newMenuState.Entries[2] = Entry:New( Vector2:New( 330, 250 ), 300, 53, "OptionState",    "Entry_Options" );
  newMenuState.Entries[3] = Entry:New( Vector2:New( 330, 400 ), 300, 53, "HighscoreState", "Entry_Highscore" );
  newMenuState.Entries[4] = Entry:New( Vector2:New( 500, 500 ),  60, 60, "QuitGame",       "Entry_Quit" );

  -- Methods

  function newMenuState:Update( deltaTime )
    
    if( newMenuState.isFadingIn ) then
      newMenuState:FadeIn( deltaTime );
    
    elseif( newMenuState.isFadingOut ) then
      newMenuState:FadeOut( deltaTime );
    end
    
    
  
  end

  function newMenuState:Draw()

    newMenuState:CalculateFadeColor();

    -- Set color depending on fade factor
    love.graphics.setColor( newMenuState.fade_color );
  
    love.graphics.draw( self.AssetManager:RequestAsset( "Background_MenuScreen" ) );
    
    
    -- Draw Entries
    for _, entry in pairs( self.Entries ) do
      entry:Draw( newMenuState.fade_color );
    end
    
    -- Trace mouse pointer
    love.graphics.circle( "fill", mousePoint.x, mousePoint.y, 5, 100 );
    
  end
  
  function newMenuState:FadeIn( deltaTime )
    
    -- Increment fade factor
    newMenuState.fade_factor = newMenuState.fade_factor + deltaTime;
  
    -- If fading is complete
    if( newMenuState.fade_factor >= 1.0 ) then
      newMenuState.fade_factor = 1.0;
      newMenuState.isFadingIn  = false;  
      newMenuState.isIdle      = true;
    end
  end
  
  
  function newMenuState:FadeOut( deltaTime )
    
    -- Increment fade factor
    newMenuState.fade_factor = newMenuState.fade_factor - deltaTime;
 
    -- If fading is complete
    if( newMenuState.fade_factor <= 0.0 ) then
      newMenuState.fade_factor = 0.0;
      newMenuState.isFadingOut = false;  
      
      -- Change state
      if( newMenuState.next_state == "PlayState" ) then
        StateManager.ChangeState( "PlayState" );
      end
      
      
      
    end
  end


  function newMenuState:CalculateFadeColor()
                    
    newMenuState.fade_color[1] = Color.White.R * newMenuState.fade_factor;
    newMenuState.fade_color[2] = Color.White.G * newMenuState.fade_factor;
    newMenuState.fade_color[3] = Color.White.B * newMenuState.fade_factor;
  
  end


  function newMenuState:CheckCollision( mouseX, mouseY )
  
    for _, entry in pairs( newMenuState.Entries ) do 
      
      if(  mouseX > entry:GetX() and mouseX < entry:GetX() + entry:GetWidth()  and
           mouseY > entry:GetY() and mouseY < entry:GetY() + entry:GetHeight() ) then
        
        if( entry:GetLabel() == "QuitGame" ) then
          love.event.quit();
        else
          -- Hit
          print( "HIT on label: " .. entry:GetLabel() );
          
          newMenuState.next_state  = entry:GetLabel();
          newMenuState.isFadingOut = true;
        end
      end
    end
  end
  
  function newMenuState:HandleKeyboardInput( key )
    print( "In MenuState:HandleKeyBoardInput( key ) -->" .. key );
  end
  
  function newMenuState:HandleMouseInput( mouseX, mouseY, mouseButton )
    newMenuState:CheckCollision( mouseX, mouseY );
  end
  
  
  
  
  
  

  return newMenuState;

end






return MenuState;