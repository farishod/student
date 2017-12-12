%  simMoveOrigPos - Move robot to original pose (0,0,0) in simulator
%  ========================================================================
%
%  Syntaxis:
%     simMoveOrigPos()
%
%  Description:
%     This function moves the robot to the original pose (x=0,y=0,theta=0) in the 
%     simulator, but it does not change the odometry. 
%
%  Remarks:
%     Function is only used for simulator MobileSim.
%
%  References:
%     Aria Reference HTML
%
%  See also simSetPos, position , resetPosition
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
%% ========================================================================

%  Known Bugs:
%    Before using this function you should connect to Aria
%
%  Author: Luis Felipe Posada 
%  Created: 02.07.2008
%
%Changelog:
%<DATE>       <AUTHOR>			<DESCRIPTION>
% 12.2008     Kolja Stritzke  Better function documentation with RST Coding Rules
% 24.04.2009  Posada          Minor changes  in notation
%=========================================================================

function  simMoveOrigPos()
error(nargchk(0, 0, nargin))
ariainterface(49);