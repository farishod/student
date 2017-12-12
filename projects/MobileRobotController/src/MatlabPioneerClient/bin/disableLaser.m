function  disableLaser()

%  disableLaser - This function disables the Laser
%  ========================================================================
%
%  disableLaser()
%
%  Description:
%    This function disconnects the laser from the robot.
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
%  See also  robotInit , cameraInit , laserRange.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(74);