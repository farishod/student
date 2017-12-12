function actionLimiterForwards(priority,stopDistance,slowDistance,slowSpeed,widthRatio)

%  actionLimiterForwards - Limits the forwards motion of the robot based on range sensor readings.
%  ============================================================================================
%
%  actionLimiterForwards(priority,stopDistance,slowDistance,slowSpeed,widthRatio)
%
%  Description:
%    This action limits the robot movement if there is an object in front 
%    of the robot between -45 to 45º.
%    When the robot reaches slowDistance, the robots navigate at slowSpeed and
%    stops at stopDistance.
%    Notice that this action is not suitable for passing a door  because this action
%    stops the robot if any object is at front, therefore is more suitable for
%    limiting at front walls. 
%    For door passing is more recomendable ACTIONLIMITERFOWARDS.
%
%  Input:
%    priority:  Actions are evaluated in descending order of 
%               priority (highest priority first, lowest priority last).
%    stopDistance:  at this distance the robot stops
%    slowDistance:  at this distance the robot navigate at slowSpeed
%    slowSpeed: is set when the robot reaches slowDistance 
%
%  Example:
%       priority = 90; 
%       stopDistance = 500;     (mm)
%       slowDistance = 1000;    (mm)
%       slowSpeed = 100;        (mm/sec)
%       widthRatio = 1;
%       actionLimiterForwards(priority,stopDistance,slowDistance,slowSpeed,widthRatio)
%
%  REMARKS:
%    This action is more recomendable for door passing than
%    ACTIONSTOPFRONT.
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
%  See also actionStopFront , disableActions , actionsAvoidFront .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(5, 5, nargin))
ariainterface(47,priority,stopDistance,slowDistance,slowSpeed,widthRatio)