%  resetPosition - Resets the current position of the robot to [0;0;0]
%  ========================================================================
%
%  Syntaxis:
%     resetPosition()
%
%  Description:
%     This function resets the current values of the position [x;y;th] of the
%     robot to [0;0;0].
%
%  References:
%     Aria Reference HTML
%
%  See also position , positionAndTime , truePosition , move , getOdometerDistance , resetOdometer , setHeading .
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


function resetPosition()
error(nargchk(0, 0, nargin))
ariainterface(22)
