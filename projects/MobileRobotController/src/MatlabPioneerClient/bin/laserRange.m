function [sensorArray] = laserRange()

%  sonarSensorRange - Returns the current laser values of a plane
%  ========================================================================
%
%  [sensorArray] = laserRange()
%
%  Description:
%     The laser measures the distance in a plane in front of the robot. This 
%     function returns a 360 x 1 matrix with the current distance
%     sensor values of a plane.
%
%  Output:
%    sensorArray: 360 x 1 matrix with distance values of a plane view
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
%  See also sonarSensorRange , laserInit , disableLaser.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
sensorArray = ariainterface(63);