function panTurnRate(panRate)

%  panTurnRate -  Sets the rate that the unit pan at. 
%  ========================================================================
%
%  panTurnRate(panRate)
%
%  Description:
%    This function sets the desired pan-turnrate of the
%    PTZ-camera.
%
%  Input:
%    panRate: The desired pan rate of the PTZ-camera (deg/sec)
%
%  Example:
%    panTurnRate(15): sets the pan turn rate to 15 (deg/sec)
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
%  See also getFocus , tiltTurnRate , panTiltZoom , canSetFocus , autoFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1,1,nargin));
ariainterface(55,panRate);