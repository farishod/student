function Move_Robot_with_Joystick()

%  Move_Robot_with_Joystick - Script to move the robot with Joystick
%  ========================================================================
%
%  Move_Robot_with_Joystick()
%
%  Description:
%    This script connects and initialise the robot and makes it possible to 
%    control the robot with the joystick until the yes-button is pressed.
%
%  REMARKS:
%    This script runs the action command "actionJoydrive(priority)" 
%
%  Known Bugs:
%    known bugs should be recorded here
%
%  References:
%    basic code or method providers, papers, books...
%
%  Authors:
%    Luis Felipe Posada , Kolja Stritzke 
%
%  See also Deactivate_Joystick .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

robotInit()
actionJoydrive(100)

disp('Joystick activated')
Deactivate_Joystick

