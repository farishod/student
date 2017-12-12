function disableActions()

%  disableActions - deactivates actions
%  ========================================================================
%
%  disableActions()
%
%  Description:
%    This function deactivates all actions and clears for the motion commands. 
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
%  See also clearDirectMotion , demoAction , stopRunning , shutdown , robotInit .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(44)
