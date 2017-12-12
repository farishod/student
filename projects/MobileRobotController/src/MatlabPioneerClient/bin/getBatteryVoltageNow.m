function [batteryvoltagenow] = getBatteryVoltageNow()

%  getBatteryVoltageNow - Gets the instaneous battery voltage.
%  ========================================================================
%
%  [batteryvoltagenow] = getBatteryVoltageNow()
%
%  Description:
%    This is a value normalized to 12 volts, if you want to know what the actual
%    voltage of the robot is use getRealBatteryVoltage.
%
%  Output:
%    batteryvoltagenow:  The instaneous battery voltage
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
%  See also getRealBatteryVoltageNow.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================
    
error(nargchk(0, 0, nargin))
batteryvoltagenow = ariainterface(68);
