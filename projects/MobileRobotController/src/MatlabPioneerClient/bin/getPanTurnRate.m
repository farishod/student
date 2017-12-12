function [panRate] = getPanTurnRate()

%  getPanTurnRate - Gets the current pan turn rate
%  ========================================================================
%
%  [panRate] = getPanTurnRate()
%
%  Description:
%    This function returns the current pan (left or right) turn rate of the
%    PTZ-camera.
%
%  Output:
%    panRate:  gets the current pan turn rate of the PTZ-camera (deg/sec)
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
%  See also getTilt, getTiltTurnRate , getPanTiltZoom , getFocus , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0,0,nargin));
panRate = ariainterface(57);