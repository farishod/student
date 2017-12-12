function [odometerdistance] = getOdometerDistance()

%  getOdometerDistance - Returns the distance the robot has covered (mm).
%  ========================================================================
%
%  [odometerdistance] = getOdometerDistance()
%
%  Description:
%    The returned value is the counter of the Odometer of the robot. This
%    floating point value depends on the Parameter ticks/MM which is set in
%    the ARCOS (tool for editing the parameters and flashing the memory of the robot). 
%
%  Output:
%    odometerdistance:  The current counter-value of the Odometer of the
%                       robot 
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
%  See also position , positionAndTime , resetOdometer , move.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================    

error(nargchk(0, 0, nargin))
odometerdistance = ariainterface(71);
