function setHeading(heading)

%  setHeading - Sets heading of the robot in (deg)
%  ========================================================================
%
%  setHeading(heading)
%
%  Description:
%    This function sets the current heading of the robot with respect to the 
%    global coordinate system, which is defined when the robot is connected
%    first.
%   
%  Input:
%    heading: The desired heading of the robot (deg)with respect to the 
%             global coordinate system
%
%  Example:
%    setHeading(15): 15 deg heading to the left with respect to the 
%                    global coordinate system
%    setHeading(-15): 15 deg heading to the right with respect to the 
%                     global coordinate system
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
%  See also position , resetPosition , truePosition , positionAndTime , move , getOdometerDistance , resetOdometer, setDeltaheading.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(23,heading);