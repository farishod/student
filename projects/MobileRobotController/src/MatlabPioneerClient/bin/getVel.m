function [vel] = getVel()

%  getVel - Gets the translational velocity of the robot.
%  ========================================================================
%
%  [vel] = getVel()
%
%  Description:
%    This function returns an integer value of the current translational
%    velicty of the robot.
%
%  Output:
%    vel : The current translational velocity of the robot (mm/sec)
%
%  Example:
%    ans =  70   % the robot moves forward and it's current velocity is 70 mm/sec
%    ans =  -70  % the robot moves backwards and it's current velocity is 70 mm/sec
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
%  See also getRotVel , setRotVel , setVel.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
vel = ariainterface(53);
