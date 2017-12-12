function setTransDecel(transDecel)

%  setTransDecel - Sets the robot's translational deceleration.
%  ========================================================================
%
%  setTransDecel(transDecel)
%
%  Description:
%   This function sets the translational deceleration with the value
%   transDecel.
%
%  Input:
%    transDecel: The desired translational deceleration  (mm/sec�) 
%
%  Example:
%    setTransDecel(5): sets the translational deceleration 5 mm/sec� 
%
%  Known Bugs:
%    known bugs should be recorded here
%
%  References:
%    Aria Reference HTML
%
%  Authors:
%    Luis Felipe Posada , Kolja Stritzke 
%
%  See also setTransAccel , setRotDecel , setRotAccel , setVel , setVel2 , setRotVel .
%
%  Copyright (c) 2008 RST, Technische Universit�t Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(65,transDecel);