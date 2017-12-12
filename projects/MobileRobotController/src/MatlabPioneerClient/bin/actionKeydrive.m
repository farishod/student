function actionKeydrive(priority)

%  actionKeydrive - This function creates an action to drive the robot with the keys
%  ================================================================================
%
%  actionKeydrive(priority)
%
%  Description:
%    This action makes it possible to control the robot with the keys 
%    (left-/right-/up-/down-arrow).
%
%  Input:
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%
%   Example:
%    priority = 100;
%    actionJoydrive(priority)
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
%  See also Deactivate_Joystick , Move_Robot_with_Joaystick , demoAction , disableActions .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(31,priority)

