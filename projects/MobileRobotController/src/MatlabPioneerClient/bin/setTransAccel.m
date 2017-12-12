function setTransAccel(transAccel)

%  setTransAccel - Sets the robot's translational acceleration.
%  ========================================================================
%
%  setTransAccel(transAccel)
%
%  Description:
%   This function sets the translational acceleration with the value
%   transAccel.
%
%  Input:
%    transAccel: The desired translational acceleration  (mm/sec²) 
%
%  Example:
%    setTransAccel(5): sets the translational acceleration 5 mm/sec² 
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
%  See also setTransDecel , setRotDecel , setRotAccel , setVel , setVel2 , setRotVel .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(64,transAccel);