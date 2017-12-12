%  setVel2 - Sets the velocity of each wheel of the robot independently
%  ========================================================================
%
%  Syntaxis:
%  setVel2(leftVelocity,rightVelocity)
%
%  Description:
%    Sets the velocity of each wheel of the robot independently.
%
%  Input:
%    leftVelocity:  The desired velocity of the left wheel of the robot (mm/sec)
%    rightVelocity: The desired velocity of the right wheel of the robot (mm/sec)
%
%  Example:
%    setVel(10,20):  sets the current velocity of the left wheel to 10 mm/sec ( forward ) 
%                    and the current velocity of the right wheel to 20 mm/sec ( forward ) 
%    setVel(-10,40): sets the current velocity of the left wheel to 10 mm/sec ( backwards ) 
%                    and the current velocity of the right wheel to 40 mm/sec ( forward )
%
%  References:
%    Aria Reference HTML
%
%
%  See also getVel , getRotVel , setRotVelMax , setVelMax , setTransDecel , setRotDecel , setRotAccel , setRotVel , setVel .
%
%% ========================================================================

%  Known Bugs:
%     known bugs should be recorded here
%
%  Author: Luis Felipe Posada 
%     Created: 02.07.2008
%
%  History:
%  <DATE>       <AUTHOR>		<DESCRIPTION>
%  01.12.2008   Stritzke       Better function documentation with RST Coding Rules
%  11.03.2008   Posada         Minor changes  in notation
%% ========================================================================

function setVel2(leftVelocity,rightVelocity)

error(nargchk(2, 2, nargin))
ariainterface(8,leftVelocity,rightVelocity);
