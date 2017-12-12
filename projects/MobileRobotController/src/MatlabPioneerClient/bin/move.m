function move(distance)

%  move - Move the given distance forward/backwards.
%  ========================================================================
%
%   move(distance)
%
%  Description:
%    The robot moves the entered distance by accelerating to a maximum velocity of 1000 mm/sec
%    and decelerating before finishing the whole distance. 
%
%  Input:
%    distance : The desired distance for the robot to move forward/backwards (mm)
%
%  Example:
%    move(5000) : robot moves 5000 mm or 5 m forward with a not constant velocity 
%    move(-5000) : robot moves 5000 mm or 5 m backwards with a not constant velocity 
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
%  See also postion , positionAndTime , setPosition , resetPosition , resetOdometer , stop , stopRunning.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
%
%% ========================================================================

% NOTE!!!! unwarrented behavior !!!
error(nargchk(1, 1, nargin))
ariainterface(9,distance);
