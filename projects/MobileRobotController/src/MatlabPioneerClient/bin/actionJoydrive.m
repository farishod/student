function actionJoydrive(priority)

%  actionJoydrive - This function creates an action to drive the robot with the joystic
%  ==================================================================================
%
%  actionJoydrive(priority)
%
%  Description:
%    This action initialises the Joystick to get control over the robot movement 
%    by using the Joystick. 
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
%  See also actionKeydrive , Deactivate_Joystick , Move_Robot_with_Joaystick , demoAction , disableActions .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(30,priority)

