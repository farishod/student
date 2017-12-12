% long2shortPath - This function is used change paths with spaces to DOS paths. 
% DOS somethimes does not recognize names with spaces. for example:
% cd\program files 
% and:
% cd\progra~1
% will produce in DOS the same results. This function performs this
% path change.
%
%   SYNTAX:
%       shortPath = long2shortPath(longPath)        
%    
%   DESCRIPTION:
%       longPath - 
%       shortPath - 
%
%   EXAMPLES:
%       longPath = 'C:\Program Files\MobileRobots\MobileSim' 
%       shortPath = long2shortPath(longPath)
%       the output will be -> shortPath = 'C:\Progra~1\Files\MobileRobots\MobileSim'
%
%
%   REMARKS:
%
%   See also 


% Author: Luis Felipe Posada
% Created: 05.03.2008
% 
% Institute of Electrical Control Systems Engineering 
% Univerity of Dortmund
% 
% Changelog:
% <DATE>    <AUTHOR>        <DESCRIPTION>


function[shortPath] = long2shortPath(pathname)

if pathname(1,end)~='\'
    pathname = [pathname,'\n'];
end
BSindx = strfind(pathname, '\'); %BackSlash index
nrBS = size(BSindx,2);

shortPath =pathname(1:2); % typically "C:"
for k=2:nrBS
    subPath = pathname(BSindx(k-1)+1:BSindx(k)-1);
    SPIndx = strfind(subPath,' ');
    nrSP = size(SPIndx,2); % Space Index
    if(nrSP>0)
        subPath(SPIndx)=[]; 
        if (size(subPath,2)>=6);
            subPath= subPath(1:6);
        end
        subPath = [upper(subPath), '~1'];
    end
    shortPath = [shortPath '\' subPath];
end
shortPath = [shortPath];