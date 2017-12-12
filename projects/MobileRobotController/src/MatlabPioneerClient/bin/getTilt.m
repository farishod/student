function [tilt] = getTilt()

%  getTilt - Returns the tilt angle of the camera
%  ========================================================================
%
%  [tilt] = getTilt()
%
%  Description:
%    This function returns the current tilt (up or down) angel of the
%    PTZ-camera.
%
%  Output:
%    tilt:  gets the current tilt angle of the PTZ-camera (deg)
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
%  See also getPan , getPanTurnRate , getPanTiltZoom , getFocus , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0,0,nargin));
tilt = ariainterface(13);