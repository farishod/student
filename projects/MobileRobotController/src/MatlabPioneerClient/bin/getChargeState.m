function [chargestate] = getChargeState()

%  getChargeState - Gets the charge state of the robot
%  ========================================================================
%
%  [chargestate] = getChargeState()
%
%  Description:
%    Returns the current state of chargeing as a value.
%
%  Output:
%    chargestate:  The current state of charge of the robot
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
%  See also getBatteryVoltageNow , getRealBatteryVoltageNow.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
chargestate = ariainterface(69);
