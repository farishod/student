function setRotAccel(rotAccel)

%  setRotAccel - Sets the robot's rotational acceleration.
%  ========================================================================
%
%  setRotAccel(rotAccel)
%
%  Description:
%   This function sets the current rotational acceleration with the value
%   rotAccel.
%
%  Input:
%    rotAccel: The desired rotational acceleration of the robot (deg/sec²)
%
%  Example:
%    setRotAccel(10): sets the current rotational acceleration to 10 deg/sec² 
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
%  See also setRotDecel , setRotVelMax , setRotVel , setVelMax , setTransDecel , setVel , setVel2 .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(66,rotAccel);