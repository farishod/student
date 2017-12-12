function setRotVelMax(maxRotVel)

%  setRotVelMax - Sets the maximum rotational velocity.
%  ========================================================================
%
%  setRotVelMax(maxRotVel)
%
%  Description:
%   This function sets a maximum for the rotational velocity with the value
%   maxRotVel.
%
%  Input:
%    maxRotVel: The desired maximum rotational velocity (mm/sec)
%
%  Example:
%    setRotVelMax(5): sets the maximum of 5 mm/sec for (positive and negative) rotational velocity                      
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
%  See also setVelMax , setTransDecel , setRotDecel , setRotAccel , setVel , setVel2 , setRotVel .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(1, 1, nargin))
ariainterface(59,maxRotVel);