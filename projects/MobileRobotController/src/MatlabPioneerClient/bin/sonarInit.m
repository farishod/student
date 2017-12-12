function sonarInit()

%  sonarInit - This function initializes the sonar
%  ========================================================================
%
%  sonarInit()
%
%  Description:
%    This function initializes the sonar either in Simulation when
%    MobileSim is open or in real(Pioneer 3DX).
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
%  See also shutdown , laserInit , cameraInit , cameraInitSim , robotInit.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(21);