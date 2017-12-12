function setVel(velocity)

%  setVel - Sets the desired translational velocity 
%  ========================================================================
%  Syntax:
%     setVel(velocity)
%
%  Description:
%     This function sets the current translational velocity
%
%  Input:
%     velocity:  The desired translational velocity of the robot in (mm/sec)
%
%  Example:
%    setVel(10):  sets the current translational velocity to 10 mm/sec ( forward )
%    setVel(-10): sets the current translational velocity to 10 mm/sec ( backwards ) 
%
%  References:
%    Aria Reference HTML
%
%
%  See also getVel , getRotVel , setRotVelMax , setVelMax , setTransDecel , setRotDecel , setRotAccel , setRotVel , setVel2 .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

%  Known Bugs:
%     known bugs should be recorded here
%
%  Author: Luis Felipe Posada 
%  Created: 02.07.2008
%
%  History:
%  <DATE>       <AUTHOR>		<DESCRIPTION>
%  01.12.2008   Stritzke       Better function documentation with RST Coding Rules
%  11.03.2008   Posada         Minor changes  in notation
%
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(7,velocity);