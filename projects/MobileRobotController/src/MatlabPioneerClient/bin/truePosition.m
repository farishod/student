function [truepos] = truePosition()

%  truePosition - returns the true (current) postion of the robot
%  ========================================================================
%
%  [truepos] = truePosition()
%
%  Description:
%    This function returns a 3 x 1 matrix with the true (current) position
%    [x ; y ; theta] of the robot in the simulator MobilSim.     
%    The difference with the function POSITION, is that POSITION reports the     
%    values read by the encoders, which are different to the TRUE position of
%    the robot due to odometry errors.     
% 
%  Output:
%    x :  x-axis coordinate
%    y :  y-axis coordinate
%    theta :  angel of the robot (deg) with respect to the local coordinate 
%             system of the robot
%
%  Example:
%    output: ans=
%                 x
%                 y
%                 theta
%
%  Remarks:
%    This function only works in the simulatior MobileSim.
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
%  See also positionAndTime , position , resetPosition , move , getOdometerDistance , resetOdometer , setHeading .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
truepos = ariainterface(46);