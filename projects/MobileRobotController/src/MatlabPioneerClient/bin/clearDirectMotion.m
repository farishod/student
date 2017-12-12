function clearDirectMotion()

%  clearDirectMotion - Clears what direct motion commands have been given, so actions work.
%  ====================================================================================
%
%  clearDirectMotion()
%
%  Description:
%    This clears the direct motion commands so that actions will be 
%    allowed to control the robot again.
%
%  Known Bugs:
%    known bugs should be recorded here
%
%  References:
%    Aria Reference HTML :
%    list of action commands which are expected:
%           actionAvoidFront
%           actionGoto
%           actionJoydrive
%           actionKeydrive
%           actionLimiterForwards
%           actionSetHeading
%           actionSetRotVel
%           actionSetVel
%           actionStopFront
%
%  Authors:
%    Luis Felipe Posada , Kolja Stritzke
%
%  See also disableActions.
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(27)



