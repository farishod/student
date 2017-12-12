%  setPosition - This function set the current stored robot position
%  ========================================================================
%  Syntaxis
%     setPosition(x,y,th)
%     setPosition(pos)
%
%  Description:
%     This function sets the current stored absolute position coordinates(x,y) and
%     the robot angle(theta). This  function simply changes the stored pose value, it
%     DOES NOT cause the robot to drive.
%     Note: the given angle theta will be normalized to (-180,180)
%  
%  Input:
%     x:  Coordinate which you can set as current position on x-axis for the robot (mm)
%     y:  Coordinate which you can set as current position on y-axis for the robot (mm)
%     th: Angle which you can set as current angle for the robot (deg)
%     pos: 3x1 or 1x3 vector with [x,y,th] values
%
%  Example:
%   setPosition(5,10,90): sets the current Position to x=5 (mm) , y=10 (mm)
%                         and the current angel of the robot theta= 90 (deg)
%
%  References:
%    Aria Reference HTML
%
%  See also position , resetPosition , truePosition , positionAndTime , move , getOdometerDistance , resetOdometer , setDeltaheading , setHeading.
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
%% ========================================================================

function setPosition(arg1,arg2,arg3)

if nargin == 1
   if (length(arg1)==3)
      x = arg1(1); y = arg1(2); th = arg1(3);
   else
      error('wrong size of input vector. should be 3x1 or 1x3 [x y th] or [x;y;z]')
   end
elseif nargin == 3
   if (length(arg1)>1 || length(arg2)>1  || length(arg3)>1)
      error('wrong size of input arguments')
   else
      x = arg1; y = arg2; th = arg3;         
   end
end

if th > 180 || th <= -180
   warning('Input angle will be normalized to (-180,180)')
end
ariainterface(45,x,y,th)