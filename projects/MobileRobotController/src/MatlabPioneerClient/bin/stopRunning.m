function stopRunning()

%  stopRunning - Stops the robot from doing any more processing.
%  ========================================================================
%
%  stopRunning()
%
%  Description:
%    This stops the actual processing cycle of the robot. If it is running in a
%    background thread, it will cause that thread to exit.  
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
%  See also stop , shutdown , robotInit .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================

error(nargchk(0, 0, nargin))
ariainterface(17)


