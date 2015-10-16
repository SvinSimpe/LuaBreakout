
local Vector2 = require( "Vector2" );
local AssetManager = require( "AssetManager" );


local Entry = {
  
  position = nil; -- The position of the entry as a Vector2
  width    = 0;
  heigth   = 0;
  label    = "";  -- The label of the entry
  image    = nil; -- The image of the entry
  
  };

function Entry:New( newPosition, newWidth, newHeight, newLabel, newImage )
  
  newEntry = {};
  
  setmetatable( newEntry, self );
  
  newEntry.position = newPosition;
  newEntry.width    = newWidth;
  newEntry.height   = newHeight;
  newEntry.label    = newLabel;
  newEntry.image    = newImage;
  
  
  
  function newEntry:GetX()
  return self.position:GetX();
  end

  function newEntry:GetY()
    return self.position:GetY();
  end

  function newEntry:SetX( newX )
    self.position:SetX( newX )
  end

  function newEntry:SetY( newY )
    self.position:SetY( newY )
  end

  function newEntry:GetLabel()
    return self.label;
  end

  function newEntry:SetLabel( newLabel )
    self.label = newLabel;
  end
  
  function newEntry:Draw( color )
  
    love.graphics.setColor( color );
    love.graphics.draw( AssetManager:RequestAsset( self.image ), self.position:GetX(), self.position:GetY() );
  
  end

  function newEntry:GetWidth()
    return self.width;
  end
  
  function newEntry:GetHeight()
    return self.height;
  end
  
  
  return newEntry;
  
end






return Entry;
