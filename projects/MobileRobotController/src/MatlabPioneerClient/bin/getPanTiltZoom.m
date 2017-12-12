function [ptz] = getPanTiltZoom()

%  getPanTiltZoom - Returns the current parameters pan, tilt, zoom
%  ========================================================================
%
%  [ptz] = getPanTiltZoom()
%
%  Description:
%    This function returns the current values of the camera  in 
%    a 1 x 3 vector = [pan ; tilt ; zoom].
%
%  Input:
%    pan:  gets the current pan(left or right) angel of the PTZ-camera (deg)
%    tilt:  gets the current tilt(up or down) angel of the PTZ-camera (deg)
%    zoom:  gets the current zoom state of the objective of the PTZ-camera 
%
%  Example:
%    output:   ans =
%                     pan  
%                     tilt
%                     zoom
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
%  See also panTiltZoom , getTilt , getPan , getFocus , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0,0,nargin));
ptz = ariainterface(15);