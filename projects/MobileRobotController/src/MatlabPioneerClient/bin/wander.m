function  wander(velocity)

%  wander - This function  wander  the robot around an obstacle 
%  ========================================================================
%
%  wander(velocity)
%
%  Description:
%    This function uses some obstacle avoidance routines.
%
%  Input:
%    velocity:  The desired translational velocity (mm/sec) of the
%               robot, which is constant here.
%
%  Example:
%    wander(10): sets the constant velocity to 10 mm/sec
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
%  See also actionLimiterForwards , actionStopFront , actionsAvoidFront .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1,1,nargin));
ariainterface(16,velocity);