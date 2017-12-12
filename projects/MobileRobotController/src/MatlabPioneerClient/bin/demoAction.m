function demoAction()

%  demoAction - Example for action control (stops in front of obstacle)
%  ========================================================================
%
%  demoAction()
%
%  Description:
%    This example sets an limiter action with a priority of 100% that reduced 
%    the robot speed to slowSpeed when the robot is at a slowDistance and stop 
%    the robot when arrive to stopDistance.
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
%  See also disableActions , Move_Robot_with_Joystick , clearDirectMotion .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

% robot initialization
robotInit()

% limiter Forwards parameters
priority = 100;
stopDistance = 200;
slowDistance = 500;
slowSpeed = 100;
widthRatio = 1;

% limiter Forward action
actionLimiterForwards(priority ,stopDistance, slowDistance, slowSpeed, widthRatio)

% SetVel action parameters
priority2 = 60;
vel = 200;

% SetVel action
actionSetVel(priority2,vel)

% run for 10 seconds
pause(10)

% then stop and shutdown
stop()
shutdown()

