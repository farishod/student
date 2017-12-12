%  setRotVel - Sets the rotational velocity 
%  ========================================================================
%
%  Syntax:
%     setRotVel(rotVelocity)
%
%  Description:
%     This function sets the current rotational velocity  in deg/sec
%
%  Input:
%       rotVelocity: The desired rotational velocity of the robot (deg/sec)
%
%  Example:
%    setRotVel(10):  sets the current rotational velocity to 10 deg/sec (turns left)
%    setRotVel(-10): sets the current rotational velocity to 10 deg/sec (turns right) 
%
%  References:
%    Aria Reference HTML
%
%  See also setRotVelMax , setVelMax , setTransDecel , setRotDecel , setRotAccel , setVel , setVel2 .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
%% ========================================================================

%  Known Bugs:
%     known bugs should be recorded here
%
%  Author: Luis Felipe Posada 
%     Created: 02.07.2008
%
%  History:
%  <DATE>       <AUTHOR>		<DESCRIPTION>
%  01.12.2008   Stritzke       Better function documentation with RST Coding Rules
%  11.03.2009   Posada         Minor changes  in notation

function setRotVel(rotVelocity)
error(nargchk(1, 1, nargin))
ariainterface(6,rotVelocity);
