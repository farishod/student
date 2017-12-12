%  position - Returns the current position of the robot
%  ========================================================================
%  syntaxis:
%  [x,y,theta] = position();
%  [pos] = position();
%
%  Description:
%    returns the current robot position x,y,theta.
% 
%  Output:
%    x :  x-axis coordinate in mm
%    y :  y-axis coordinate in mm
%    theta :  angle of the robot (deg) with respect to the local coordinate 
%             system of the robot
%    pos : 3x1 vector  with [x;y;theta] values
%
%  References:
%    Aria Reference HTML
%
%  See also positionAndTime , truePosition , resetPosition , move , getOdometerDistance , resetOdometer , setHeading .
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
%  24.04.2009   Posada         Minor changes  in notation
%
%% ========================================================================
function [out1,out2,out3] = position()
posit = ariainterface(4);
if nargout > 1
   out1 = posit(1);
   out2 = posit(2);
   out3 = posit(3);
else
   out1 = posit;
end
