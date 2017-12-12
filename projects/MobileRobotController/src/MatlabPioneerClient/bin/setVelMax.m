function setVelMax(maxVel)

%  setVelMax - Sets the maximum translational velocity.
%  ========================================================================
%
%  setVelMax(maxVel)
%
%  Description:
%    This function sets a maximum for the translational velocity with the value
%    maxVel.
%
%  Input:
%    maxVel: The desired maximum translational velocity (mm/sec)
%   
%  Example:
%    setVelMax(5): sets the maximum of 5 mm/sec for (positive and negative) translational velocity                       
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
%  See also setRotVelMax , setTransDecel , setRotDecel , setRotAccel , setVel , setVel2 , setRotVel .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(60,maxVel);