function actionSetRotVel(priority, rotspeed) 

%  actionSetRotVel - This action simply sets the rotational velocity
%  ========================================================================
%
%  actionSetRotVel(priority, rotspeed)
%
%  Description:
%    In this action you can set the rotational velocity for the robot movement.
%
%  Input:
%    rotspeed:  The desired rotational velocity (deg/sec)
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%
%  Example:
%    priority = 60; 
%    rotspeed = 20;       (deg/sec)
%    actionSetRotVel(priority ,rotspeed);
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
%  See also actionSetVel , actionSetHeading , disableActions , actionStopFront .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(2, 2, nargin))
ariainterface(43,priority,rotspeed)
