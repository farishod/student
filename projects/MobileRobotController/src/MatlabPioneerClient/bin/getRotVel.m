function [rotVel] = getRotVel()

%  getRotVel - Gets the rotational velocity of the robot.
%  ========================================================================
%
%  [rotVel] = getRotVel()
%
%  Description:
%    This function returns an integer value of the current rotational
%    velocity of the robot.
%
%  Output:
%    rotVel : The current rotational velocity of the robot (deg/sec)
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
%  See also getVel , setRotVel , setVel.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================
   
error(nargchk(0, 0, nargin))
rotVel = ariainterface(54);
