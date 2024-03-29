



-------------------------------------------------
----- SoundManager
-------------------------------------------------
local SoundManager = {
  
  -- Fields
  SoundTypes        = { "Background_music",
                        "GlassBlock_Damaged", "GlassBlock_Broken", "GlassBlock_Destroyed",
                        "BrickBlock_Damaged", "BrickBlock_Broken", "BrickBlock_Destroyed",
                        "Board_Size_Increase", "Board_Size_Decrease" };
  Sounds            = {};
  isSoundActivated  = false;
    
};

--[[ Loads sounds into 'SoundManager.Sounds' ]]
function SoundManager.LoadSounds()
  
    SoundManager.isSoundActivated = true;
  
    local soundIndex = 1;
    
  
    -- Load Background sounds
    print( "---------------------------------------------------------------" )
    print( "In SoundManager -> Loading Background sounds..." );
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Background Sounds/soundtrack.mp3" ); soundIndex = soundIndex + 1;
    print( "In SoundManager -> Loading Background sounds complete!" );
    --print( "---------------------------------------------------------------" )
  
    -- Load GlassBlock sounds
    print( "---------------------------------------------------------------" )
    print( "In SoundManager -> Loading GlassBlock sounds..." );
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Block Sounds/GlassBlock Sounds/GlassBlockDamaged.wav" ); soundIndex = soundIndex + 1;
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Block Sounds/GlassBlock Sounds/GlassBlockBroken.wav" ); soundIndex = soundIndex + 1;
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Block Sounds/GlassBlock Sounds/GlassBlockDestroyed.wav" ); soundIndex = soundIndex + 1;
    print( "In SoundManager -> Loading GlassBlock sounds complete!" );
    print( "---------------------------------------------------------------" )
    
    -- Load BrickBlock sounds
    print( "---------------------------------------------------------------" )
    print( "In SoundManager -> Loading BrickBlock sounds..." );
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Block Sounds/BrickBlock Sounds/BrickBlockDamaged.wav" ); soundIndex = soundIndex + 1;
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Block Sounds/BrickBlock Sounds/BrickBlockBroken.wav" ); soundIndex = soundIndex + 1;
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Block Sounds/BrickBlock Sounds/BrickBlockDestroyed.wav" ); soundIndex = soundIndex + 1;
    print( "In SoundManager -> Loading BrickBlock sounds complete!" );
    print( "---------------------------------------------------------------" )
    
    -- Load Board sounds
    print( "---------------------------------------------------------------" )
    print( "In SoundManager -> Loading Board sounds..." );
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Board Sounds/maximize_board_sound.wav" ); soundIndex = soundIndex + 1;
    SoundManager.Sounds[soundIndex] = love.audio.newSource( "Sound/Board Sounds/minimize_board_sound.wav" ); soundIndex = soundIndex + 1;
    print( "In SoundManager -> Loading Board sounds complete!" ); 
    print( "---------------------------------------------------------------" )
    
end

--[[ Plays the requested sound, returns false if request is 'nil' or sound cannot be found ]]
function SoundManager.PlaySound( sound ) 
    
    -- Incorrect request
    if( sound == nil ) then
      print( "sound == nil" );
      return false;
    end
    
    -- Find sound in SoundTypes
    for i = 1, #SoundManager.SoundTypes + 1 do
      
      if( SoundManager.SoundTypes[i] == sound ) then
        love.audio.play( SoundManager.Sounds[i] );
        return true;
      end 
    end
    
    -- No sound found
    return false;
    
end

--[[ Pauses the requested sound, returns false if request is 'nil' or sound cannot be found ]]
function SoundManager.PauseSound( sound )
    
    -- Incorrect request
    if( sound == nil ) then
      return false;
    end
  
    -- Find sound in SoundTypes
    for i = 1, #SoundTypes + 1 do
      
      if( SoundTypes[i] == sound ) then
        love.audio.pause( Sounds[i] );
        return true;
      end 
    end
    
    -- No sound found
    return false;
end

--[[ Stops the requested sound, returns false if request is 'nil' or sound cannot be found ]]
function SoundManager.StopSound( sound )
    
    -- Incorrect request
    if( sound == nil ) then
      return false;
    end
  
    -- Find sound in SoundTypes
    for i = 1, #SoundTypes + 1 do
      
      if( SoundTypes[i] == sound ) then
        love.audio.stop( Sounds[i] );
        return true;
      end 
    end
    
    -- No sound found
    return false;
end

--[[ Toggle all sounds, returns 'true' if sound is ON, 'false' if sound is OFF ]]
function SoundManager.ToggleSound()
  
  -- If sound is ON
  if( SoundManager.isSoundActivated ) then
    SoundManager.isSoundActivated = false;
    SoundManager.StopAll();
    print( "Sound OFF" );
    
  
  -- Else Sound is OFF
  else
    SoundManager.isSoundActivated = true;
    print( "Sound ON" );
  end
  
  return SoundManager.isSoundActivated;
  
end

function SoundManager.Update( deltaTime )

  -- If sound is OFF
  if( not SoundManager.isSoundActivated ) then
    return;
  end
  
  -- Play BackGround sound
  SoundManager.PlaySound( "Background_music" );
  
end



function SoundManager.StopAll()
  
  for i, sound in pairs( SoundManager.Sounds ) do
    love.audio.stop( sound )
  end
end


return SoundManager;