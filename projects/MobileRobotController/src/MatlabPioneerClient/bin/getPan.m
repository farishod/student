function [pan] = getPan()

%  getPan - Returns the pan angle of the camera
%  ========================================================================
%
%  [pan] = getPan()
%
%  Description:
%    This function returns the current pan (left or right) angel of the
%    PTZ-camera.
%
%  Output:
%    pan:  gets the current pan angle of the PTZ-camera (deg)
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
%  See also getTilt, getPanTurnRate , getPanTiltZoom , getFocus , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0,0,nargin));
pan = ariainterface(11);