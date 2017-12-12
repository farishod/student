%  closeMobileSim - Exits the simulator and disconnect from the robot
%  ========================================================================
%
%  Sintaxis:
%     closeMobileSim()
%
%  Description:
%    This function close the simulator MobileSim and disconnects from the
%    robot.
% 
%   Remarks:
%    Function is only used for simulator MobileSim and the robot has to be
%    connected otherwise this function will not work.
%
%  See also  openMobileSim, simSetPos , simMoveOrigPos
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
% ========================================================================

%  Known Bugs:
%    Before using this function you should connect to Aria
%
%
%  References: Matlab
%
%  Author: Luis Felipe Posada 
%  Created: 02.07.2008
%
%Changelog:
%<DATE>       <AUTHOR>			<DESCRIPTION>
% 12.2008     Kolja Stritzke     Better function documentation with RST Coding Rules
% 11.03.2008  Posada             function name changed simClose to closeMobileSim

function  closeMobileSim()

error(nargchk(0, 0, nargin))
ariainterface(51);