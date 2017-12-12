function panTiltZoom(pan, tilt, zoom)

%  panTiltZoom - This function pans, tilts and zooms the PTZ camera 
%  ========================================================================
%
%  panTiltZoom(pan, tilt, zoom)
%
%  Description:
%    With this function you can set a new direction and zoom (pan,tilt,zoom) to the
%    PTZ-camera.
%
%  Input:
%    pan:   turns the PTZ-camera to the left or right (deg)
%    tilt:  turns the PTZ-camera up or down (deg)
%    zoom:  zooms with the objective of the PTZ-camera in or out
%
%  Example:
%    panTiltZoom(15,20,40): sets pan to 15 , tilt to 20 and zoom to 40 
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
%  See also getPanTiltZoom , getFocus , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(3, 3, nargin))
ariainterface(5,pan,tilt,zoom);