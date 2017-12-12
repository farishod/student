function actionSetHeading(priority, heading)

%  actionSetHeading - This action simply sets a desired heading.
%  ========================================================================
%
%  actionSetHeading(priority, heading)
%
%  Description:
%    In this action you can set the heading of the robot.
%
%  Input:
%    heading:  The desired heading of the robot (degree)
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%
%  Example:
%    priority = 60; 
%    heading = 20;       (deg)
%    actionSetHeading(priority ,heading);
%
%  REMARKS:
%    This action deactivates ACTIONSETROTVEL.
%    Take into consideration that if the function resetPosition is called
%    SetHeading will adjust the heading again with respect to the new
%    reference.
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
%  See also actionSetVel , actionSetRotVel , disableActions , actionStopFront .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(2, 2, nargin))
ariainterface(41,priority,heading)