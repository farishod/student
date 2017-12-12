function actionMove(priority,DistanceToMove)

%  actionAvoidFront - This action does obstacle avoidance, controlling both trans and rot.
%  ============================================================================================
%
%  actionAvoidFront(priority,obstacleDist,avoidSpeed,turnAmount)
%
%  Description:
%    This action limits the robot movement if there is an object in front 
%    of the robot between -45 to 45º. It is usefull to avoid obstacles.
%
%  Input:
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%    obstacleDist:  begin at this distance to the front obstacle avoidance
%    avoidSpeed:    perform the obstacle avoidance at this speed (mm/sec)
%    obstacleDist:  begin at this distance to the front obstacle avoidance
%    turnAmount:    Degrees to turn relative to current heading while avoiding obstacle (deg)
%
%  Example:
%       priority = 90; 
%       obstacleDist = 500;     (mm)
%       avoidSpeed = 150;       (mm/sec)
%       turnAmount = 15;        (deg)
%       actionAvoidFront(priority,obstacleDist,avoidSpeed,turnAmount);
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
%  See also actionStopFront , disableActions , actionLimiterForwards .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(2, 2, nargin))
ariainterface(24,priority,DistanceToMove)