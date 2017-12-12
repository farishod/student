%  sonarSensorPositions - Returns the sonar sensor positions on the robot
%  ========================================================================
%  
%  Sintaxis:
%     [sensorPositions] = sonarSensorPositions()
%
%  Description:
%    This function returns  a 16 x 3 matrix with the 16 sonar sensor 
%    positions (x,y,theta) with respect to the robot's center.
%
%               front
%           3    4 5   6
%            \   | |   /
%         2 \ \  |#|  / / 7
%            \ ####### /
%      1 ---[]#### ####[]--- 8
%     16 ---[]###   ###[]--- 9
%            / ####### \
%        15 / /  | |  \ \ 10
%            /   | |   \
%          14   13 12   11
%                back
%
%  Remarks:
%    Be carefull, this function doesn't return the sonar range.
%    This function only returns the physical position of the
%    sonar with respect to the robot's center.
%
%  References:
%    Aria Reference HTML
%
%  See also sonarSensorRange , sonarSensorPosition , laserRange , position , positionAndTime , truePosition , resetPosition , getOdometerDistance , resetOdometer .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de 
%% ========================================================================

%  Known Bugs:
%     known bugs should be recorded here
%
%  Author: Luis Felipe Posada 
%  Created: 02.07.2008
%
%  History:
%  <DATE>       <AUTHOR>		<DESCRIPTION>
%  01.12.2008   Stritzke       Better function documentation with RST Coding Rules
%  11.03.2008   Posada         Minor changes  in notation
%% ========================================================================

function [sensorPositions] = sonarSensorPositions()

error(nargchk(0, 0, nargin))
sensorPositions = ariainterface(32);