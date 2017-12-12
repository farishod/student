function shutdown()

%  shutdown - Shuts down the robot
%  ========================================================================
%
%  Syntaxis:
%     shutdown()
%
%  Description:
%    This function shuts down the robot and disconnects from the robot either in Simulation when
%    MobileSim is open or in real.
%
%  Known Bugs:
%    known bugs should be recorded here
%
%  References:
%    Aria Reference HTML
%
%  See also robotInit , laserInit , cameraInit , cameraInitSim .
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
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(2);