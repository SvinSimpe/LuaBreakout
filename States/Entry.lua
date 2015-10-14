
local Vector2 = require( "Vector2" );


local Entry = {
  
  position = nil; -- The position of the entry as a Vector2
  width    = 0;
  heigth   = 0;
  label    = "";  -- The label of the entry
  image    = nil; -- The image of the entry
  
  };

function Entry:New( newPosition, newWidth, newHeight, newLabel, newImage )
  
  self.position = newPosition;
  self.label    = newLabel;
  self.image    = newImage;
  
end


function Entry:GetX()
  return self.position:GetX();
end

function Entry:GetY()
  return self.position:GetY();
end

function Entry:SetX( newX )
  self.position:SetX( newX )
end

function Entry:SetY( newY )
  self.position:SetY( newY )
end

function Entry:GetLabel()
  return self.label;
end

function Entry:SetLabel( newLabel )
  self.label = newLabel;
end



return Entry;
