function [bool] = canGetFOV()

%  canGetFOV - Whether we can get the FOV (field of view) or not.
%  ========================================================================
%
%  [bool] = canGetFOV()
%
%  Description:
%    This function bools if the current PTZ-camera is able to return a
%    field of view.
%
%  Output:
%    bool:  returns boolean 1 (camera returns FOV) or returns 0 if not supported.
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
bool = ariainterface(34);