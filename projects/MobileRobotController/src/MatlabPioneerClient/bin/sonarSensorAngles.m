%  sonarSensorAngles - Returns the sonar sensor angle 
%  ========================================================================
%
%  Syntaxis:
%     [sensorArray] = sonarSensorAngles()
%
%  Description:
%    This function returns  a 16 x 1 matrix with the 16 sonar sensor 
%    angels (theta) with respect to the sensor positions.
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
%  References:
%    Aria Reference HTML
%
%  See also sonarSensorPosition , sonarSensorRange , laserRange , position , positionAndTime , truePosition , resetPosition , getOdometerDistance , resetOdometer .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de 
%% ========================================================================

%  Known Bugs:
%     known bugs should be recorded here
%
%  Author: Luis Felipe Posada 
%     Created: 02.07.2008
%
%  History:
%  <DATE>       <AUTHOR>		<DESCRIPTION>
%  01.12.2008   Stritzke       Better function documentation with RST Coding Rules
%  11.03.2008   Posada         Minor changes  in notation
%% ========================================================================

function [sensorArray] = sonarSensorAngles()
error(nargchk(0, 0, nargin))
sensorArray = ariainterface(26);