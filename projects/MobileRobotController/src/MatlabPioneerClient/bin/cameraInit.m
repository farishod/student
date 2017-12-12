function cameraInit()

%  cameraInit - Initializes the pan-tilt Canon VCC4 Camera
%  ========================================================================
%
%  cameraInit()
%
%  Description:
%    This function initializes the pan-tilt Canon VCC4 Camera.
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
%  See also robotInit , laserInit , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(1);