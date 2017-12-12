function setDeltaHeading(deltaAngle)

%  setDeltaHeading - Sets delta heading of the robot in (deg)
%  ========================================================================
%
%  setDeltaHeading(deltaAngle)
%
%  Description:
%    This function sets the current heading of the robot with respect to the 
%    local coordinate system of the robot, which is defined parallel to the
%    gloabl coordination system.
%   
%  Input:
%    deltaAngle: The desired heading of the robot (deg)with respect to the 
%                local coordinate system of the robot
%
%  Example:
%    setHeading(15): 15 deg heading to the left with respect to the 
%                    local coordinate system of the robot
%    setHeading(-15): 15 deg heading to the right with respect to the 
%                     local coordinate system of the robot
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
%  See also position , resetPosition , truePosition , positionAndTime , move , getOdometerDistance , resetOdometer , setHeading.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(61,deltaAngle);
