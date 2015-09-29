

local SoundManager = {
  
  SoundTypes  =  { "GlassBlock_Untouched", "GlassBlock_Damaged", "GlassBlock_Broken" };
  Sounds      = {};
  
  
};


function SoundManager:LoadSounds()
  
   -- Load GlassBlock sounds
    print( "---------------------------------------------------------------" )
    print( "In SoundManager -> Loading GlassBlock sounds..." );
    self.Assets[1] = love.graphics.newImage( "Sound/Blocks/GlassBlock/GlassBlockUntouched.png" );
    self.Assets[2] = love.graphics.newImage( "Sound/Blocks/GlassBlock/GlassBlockDamaged.png" );
    self.Assets[3] = love.graphics.newImage( "Sound/Blocks/GlassBlock/GlassBlockBroken.png" );
    print( "In SoundManager -> Loading GlassBlock sounds complete!" );
    print( "---------------------------------------------------------------" )
  
end


function SoundManager:PlaySound( sound )
    
    -- Incorrect request
    if( sound == nil ) then
      return false;
    end
    
    -- Find sound in SoundTypes
    for i = 1, #self.SoundTypes + 1 do
      
      if( SoundTypes[i] == sound ) then
        love.audio.play( Sounds[i] );
        return true;
      end 
    end
    
    -- No sound found
    return false;
    
end

function SoundManager:PauseSound( sound )
    love.audio.pause( sound );
end


return SoundManager;