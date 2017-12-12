function [focus] = getFocus(focus)

%  getFocus - Gets the focus the camera is set to. Returns 0 if not supported
%  ========================================================================
%
%  [focus] = getFocus(focus)
%
%  Description:
%    With this function you can set the focus of the PTZ-camera. If it is
%    not supported it will return 0.
%
%  Input:
%    focus:  sets the current focus to the PTZ-camera 
%
%  Output:
%    focus:  gets the focus the camera is set to. Returns 0 if not supported.
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
%  See also panTiltZoom , getPanTurnRate , getPanTiltZoom , tiltTurnRate , panTurnRate , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1,1,nargin));
focus = ariainterface(37,focus);