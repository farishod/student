function [sensorArray] = sonarSensorRange()

%  sonarSensorRange - Returns the current sonar sensor values
%  ========================================================================
%
%  [sensorArray] = sonarSensorRange()
%
%  Description:
%       This function returns  a 16 x 1 matrix with the current sonar
%       sensor values.                       
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
%  Known Bugs:
%    known bugs should be recorded here
%
%  References:
%    Aria Reference HTML
%
%  Authors:
%    Luis Felipe Posada , Kolja Stritzke 
%
%  See also sonarSensorPositions , sonarSensorAngles , laserRange , position , positionAndTime , truePosition , resetPosition , getOdometerDistance .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
sensorArray = ariainterface(3);