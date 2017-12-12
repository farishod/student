function [tiltRate] = getTiltTurnRate()

%  getTiltTurnRate - Gets the current tilt rate
%  ========================================================================
%
%  [tiltRate] = getTiltTurnRate()
%
%  Description:
%    This function returns the current tilt (up or down) turn rate of the
%    PTZ-camera.
%
%  Output:
%    tiltRate:  gets the current turnrate (up and down) of the PTZ-camera (deg/sec)
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
%  See also getPanTurnRate , getPanTiltZoom , getFocus , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0,0,nargin));
tiltRate = ariainterface(58);