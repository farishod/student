function [focus] = autoFocus()

%  autoFocus - If the driver can set the focus on the camera, or not.
%  ========================================================================
%
%  [focus] = autoFocus()
%
%  Description:
%    This function returns bools if the current PTZ-camera allows to set
%    focus.
%
%  Output:
%    focus:  returns boolean 1 (camera can set Focus) or returns 0 if not supported.
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
%  See also getFocus , canSetFocus.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0,0,nargin));
focus = ariainterface(38);