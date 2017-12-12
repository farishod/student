function actionGoto(priority ,goal, closeDist, speed,speedToTurnAt, turnAmount)

%  actionGoto - This function drives the robot straight towards a given goal
%  ==================================================================================
%
%  actionGoto(priority ,goal, closeDist, speed,speedToTurnAt, turnAmount)
%
%  Description:
%       This action naively drives straight towards a given goal. The action stops when it gets to 
%       be a certain distance (closeDist) from the goal pose. It travels at the given speed (mm/sec).
%
%  Input:
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%    goal:       complains the coordinates (x,y) and the angle (theta)
%    closeDist:  close distance to the obstacle (mm)
%    speed:      desired translational speed to move to goal (mm/sec)
%    speedToTurnAt:  desired rotational speed at the turning point (mm/sec)
%    turnAmount:     Degrees to turn relative to current heading while avoiding obstacle (deg)
%
%   Example:
%       priority = 100; 
%       goal = [200,0,0];       ([x,y,theta])
%       closeDist = 10;         (mm)
%       speed = 150;            (mm/sec)
%       speedToTurnAt = 50;     (deg/sec)
%       turnAmount = 1;
%       actionGoto(robotName,priority ,goal,closeDist,speed,speedToTurnAt,turnAmount);
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
%  See also actionLimiterForwards , actionKeydrive , Deactivate_Joystick , Move_Robot_with_Joaystick , demoAction , disableActions .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(6, 6, nargin))
ariainterface(18,priority,goal,closeDist, speed,speedToTurnAt, turnAmount)