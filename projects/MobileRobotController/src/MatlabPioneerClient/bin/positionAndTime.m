%  positionAndTime - Returns the current position and current runtime of the robot 
%  ==============================================================================
%
%  Syntaxis:
%     [position] = positionAndTime()
%
%  Description:
%    This function returns a 4 x 1 matrix with the position values (x,y ,theta) 
%    and the odometer time.
%
%  Output:
%    x :  x-axis coordinate in mm
%    y :  y-axis coordinate in mm
%    theta :  angel of the robot (deg) with respect to the local coordinate 
%             system of the robot
%    odometerTime :  shows the passed time since the robot got connected
%
%  References:
%    Aria Reference HTML
%
%  See also position , truePosition , resetPosition, move , getOdometerDistance , resetOdometer , setHeading.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
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
%  11.03.2008   Posada         Minor changes  in notation
%
%% ========================================================================

function [position] = positionAndTime()
error(nargchk(0, 0, nargin))
position = ariainterface(12);