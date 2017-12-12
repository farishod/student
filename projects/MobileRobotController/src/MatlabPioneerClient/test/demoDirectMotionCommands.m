%  demoDirectMotionCommands - demo for the Simulator MobileSim
%  ========================================================================
%
%  demoDirectMotionCommands()
%
%  Description:
%    This demo shows the movement of the robot in the Simulator
%    MobileSim. It is possible to read the position and the range of the Sonarsensors
%    of the robot.
%    Before you can run this demo you must open the Simulator
%    MobileSim.
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
%  See also demoDirectMotionCommands2.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

function demoDirectMotionCommands()

fprintf('Before running this example open the simulaton program mobilSim\n')

disp('Press any key to continue  to initialize and run the robot')
pause
% Once the simulator is open, initialize the robot
robotInit()



disp('Press any key to setVel(80) ')
pause
% Set the robot velocity to 80mm/sec
setVel(80)



disp('Press any key to setRotVel(5) ')
pause
% Set the robot rotational velocity to 5 degree/sec
setRotVel(5)



disp('Press any key to setVel(0) ')
pause
% Set the robot velocity to 80mm/sec
setVel(0)


disp('Press any key to setRotVel(15)')
pause
% Increase robot rotational velocity to 15 degree/sec
setRotVel(15)



disp('Press any key to setRotVel(0)')
pause
% Set the Rotational velocity to 0
setRotVel(0)



disp('Press any key to  read the robot position')
pause
% Read the position [x;y;theta]
pos = position()



disp('Press any key to  read the sonar  range readings')
pause
% Read the 16 sonar range value
sonarRange = sonarSensorRange()



disp('Press any key to setVel2(-15,15)')
pause
% Set left wheel vel to -15 and rigth wheel vel to 15
setVel2(-15,15)


disp('Press any key to stop and shutdown the robot')
pause
% Stop the robot
stop()
% shut down
shutdown()







