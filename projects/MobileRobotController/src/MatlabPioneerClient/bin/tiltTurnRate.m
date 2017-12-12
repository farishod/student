function tiltTurnRate(tiltRate)

%  tiltTurnRate - Sets the turnrate that the unit tilt at. 
%  ========================================================================
%
%  tiltTurnRate(tiltRate)
%
%  Description:
%    This function sets the desired tilt-turnrate of the
%    PTZ-camera.
%
%  Input:
%    tiltRate:  The desired tilt turnrate of the PTZ-camera (deg/sec)
%
%  Example:
%    tiltTurnRate(15):  sets the turnrate [tilt(up and down)] to 15 (deg/sec)
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
%  See also getTilt, getPanTurnRate , getPanTiltZoom , getFocus , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1,1,nargin));
ariainterface(56,tiltRate);