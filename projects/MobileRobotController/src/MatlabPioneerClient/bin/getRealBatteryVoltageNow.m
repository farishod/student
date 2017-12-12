function batteryvoltagenow = getRealBatteryVoltageNow()

%  getRealBatteryVoltageNow - Gets the instaneous battery voltage.  
%  ========================================================================
%
%  [batteryvoltagenow] = getRealBatteryVoltageNow()
%
%  Description:
%    This value is averaged over a number of readings, you can get this 
%    by calling getRealBatteryVoltageAverageOfNum and set this with 
%    setRealBatteryVoltageAverageOfNum... you can call getRealBatteryVoltageNow 
%    to get the reading from the last packet.
%    The functions (getRealBatteryVoltageAverageOfNum,setRealBatteryVoltageAverageOfNum)
%    are not yet implemented.
%    If the robot is connected it doesn't send the real battery voltage it
%    will just use the normal battery voltage (normalized to 12 volt
%    scale).
%
%  Output:
%    batteryvoltagenow:  The instaneous battery voltage
%
%  Known Bugs:
%    known bugs should be recorded here
%
%  References:
%    For more information read : 
%    (C:\Program Files\MobileRobots\Aria\docs\index.html   ->  ArRobot  -> ArRobot ->
%    Class References -> down to getRealBatteryVoltageNow - Discription
%
%  Authors:
%    Luis Felipe Posada , Kolja Stritzke 
%
%  See also getBatteryVoltageNow.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================
    
error(nargchk(0, 0, nargin))
batteryvoltagenow = ariainterface(70);
