function laserInit()

%  laserInit - This function initializes the Laser
%  ========================================================================
%
%  laserInit()
%
%  Description:
%    This function initializes the laser.
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
%  See also   disableLaser , laserRange , robotInit , cameraInit , shutdown , cameraInitSim.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================


error(nargchk(0, 0, nargin))
ariainterface(62);
