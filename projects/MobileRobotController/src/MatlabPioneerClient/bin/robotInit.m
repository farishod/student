%  robotInit - This function initializes the Robot
%  ========================================================================
%
%  Syntaxis: 
%    robotInit()
%
%  Description:
%    This function initializes the robot either in Simulation when
%    MobileSim is open or in real(Pioneer 3DX).
%
%  References:
%    Aria Reference HTML
%
%  See also shutdown , laserInit , cameraInit , cameraInitSim .
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

function robotInit(port)
error(nargchk(1, 1, nargin))
ariainterface(0, port);