%  simSetPos - Move robot to global pose in simulator
%  ========================================================================
%
%  Syntaxis
%     simSetPos(x,y,th)
%
%  Description:
%    This function moves the robot to a global pose (X,Y,Theta) in the 
%    simulator, but it does not change the odometry. The parameters are 
%    4-byte integers for X, Y and Theta.
%
%  Input:
%    x :  x-axis coordinate
%    y :  y-axis coordinate
%    theta :  angel of the robot (deg) with respect to the local coordinate 
%             system of the robot
%
%  Example:
%    x = 10 (mm)
%    y = 50 (mm)
%    th = 46 (deg)
%    simSetPos(10,50,46)
%
%  Remarks:
%    Function is only used for simulator MobileSim. Before using this
%    function you should connect to Aria with robotInit.
%
%  References:
%    Aria Reference HTML, MobileSim HTML
%
%  See also simMoveOrigPos
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de 
%========================================================================

%  Known Bugs:
%    Before using this function you should connect to Aria
%
%  Author: Luis Felipe Posada 
%  Created: 02.07.2008
%
%Changelog:
%<DATE>       <AUTHOR>			<DESCRIPTION>
% 01.12.2008  Kolja Stritzke     Better function documentation with RST Coding Rules
% 11.03.2009  Posada             function name changed simClose to closeMobileSim
%=========================================================================
function  simSetPos(x,y,th)

error(nargchk(3, 3, nargin))
ariainterface(50,x,y,th);