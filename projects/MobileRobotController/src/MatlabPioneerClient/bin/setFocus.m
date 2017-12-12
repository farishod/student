function [boolFocus] = setFocus(focus)

%  setFocus - Set focus on camera
%  ========================================================================
%
%  [boolFocus] = setFocus(focus)
%
%  Description:
%    The maximum range of the focus should be between 1 - 100.
%    This function returns false if out of range or if you can't set the
%    focus on the camera.
%
%  Input:
%    focus:  The desired range of the focus on the camera
%
%  Output:
%    boolFocus:  gets out 1 or 0 if set or not )
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
%  See also getFocus , panTiltZoom , panTurnRate , canSetFocus , tiltTurnRate , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1,2,nargin));
if (focus > 100 ||  focus < 1)
    error('focus range should be between 1-100')
end

boolFocus = ariainterface(35,focus);