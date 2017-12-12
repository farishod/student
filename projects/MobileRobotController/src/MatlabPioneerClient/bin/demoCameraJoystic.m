% demoCameraJoystic - function for testing the PTZ-camera with the
% Pioneer3D Robot
%   SYNTAX:
%       demoCameraJoystic()
%
%   DISCRIPTION:
%       This script tests some commands for the robots and the PTZ-camera :
%       - activates the robot
%       - activates the joystick
%       - initialize the PTZ-camera and the preview 
%       - rotates the robot
%       - displays the robot position
%       - displays the 16 sonar readings 
%       - pans the camera 
%       - tilts the camera 
%       - exits the preview and shuts down the robot 
%
%   REMARKS:
%       Before running this example code connect properly the 
%       Pan-Tilt-Zoom Camera, the Usb Joystic and the Pioneer3D robot via 
%       serial cable.       


% Author: Luis Felipe Posada
% Created: 02.07.2008
% 
% Institute of Electrical Control Systems Engineering 
% Univerity of Dortmund
% 
% Changelog:
% <DATE>    <AUTHOR>        <DESCRIPTION>


function demoCameraJoystic() 
%robot Initialization
robotInit()
% activate joystick
actionJoydrive(100)

%Camera initialization

% Make sure the camera is properly connected
disp('Press any key to initialize the camera and preview ')
pause
cameraInit()
vid = videoinput('winvideo',1,'UYVY_352x240');
prev = preview(vid)


disp('Press any key to rotate the robot')
pause
setRotVel(5)
pause(5)
setRotVel(0)


disp('Press any key to display the robot position')
pause
pos = position()


disp('Press any key to display the 16 sonar readings')
pause
sonarReadings = sonarSensorRange()


disp('Press any key to pan the camera 45° Degrees')
pause
panTiltZoom(45,0,0)


disp('Press any key to tilt the camera 30° Degrees')
pause
panTiltZoom(45,30,0)

disp('Press any key to exit')
pause
closepreview(vid)
shutdown()