% getRotVelMax - Sets the rotational velocity of the robot in (deg/sec)
%   SYNTAX:
%       getRotVelMax;        
%    
%   DESCRIPTION:
%       
%
%   EXAMPLES:
%        
%       
%          
%   REMARKS:
%       
%       
%
%   See also getVel , getRotVel , setVel 

    
% Author: Luis Felipe Posada, Kolja 
% Created: 25.11.2008
% 
% Institute of Electrical Control Systems Engineering 
% Univerity of Dortmund
% 
% Changelog:
% <DATE>    <AUTHOR>        <DESCRIPTION>    
    
function rotvelmax = getRotVelMax()
error(nargchk(0, 0, nargin))
rotvelmax = ariainterface(72);