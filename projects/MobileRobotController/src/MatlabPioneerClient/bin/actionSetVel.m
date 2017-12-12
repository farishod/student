function actionSetVel(priority, speed)

%  actionSetVel - This action simply sets a constant translational velocity.
%  ========================================================================
%
%  actionSetVel(priority, speed)
%
%  Description:
%    In this action you can set the translational velocity for the robot movement.
%
%  Input:
%    speed:  The desired translational velocity (mm/sec)
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%
%  Example:
%    priority = 60; 
%    speed = 150;       (mm/sec)
%    actionSetVel(priority ,speed);
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
%  See also actionSetRotVel , actionSetHeading , disableActions , actionStopFront .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(2, 2, nargin))
ariainterface(42,priority,speed)