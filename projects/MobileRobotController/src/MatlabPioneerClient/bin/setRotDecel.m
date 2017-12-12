function setRotDecel(rotDecel)

%  setRotDecel - Sets the robot's rotational deceleration.
%  ========================================================================
%
%  setRotDecel(rotDecel)
%
%  Description:
%   This function sets the current rotational deceleration with the value
%   rotDecel.
%
%  Input:
%    rotDecel: The desired rotational deceleration of the robot (deg/sec²)
%
%  Example:
%    setRotDecel(10):  sets the current rotational deceleration to 10 deg/sec² 
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
%  See also setRotVelMax , setRotVel , setVelMax , setTransDecel , setRotAccel , setVel , setVel2 .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(67,rotDecel);