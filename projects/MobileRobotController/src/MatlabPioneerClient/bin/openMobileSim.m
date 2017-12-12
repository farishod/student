%  openMobileSim - This function opens MobileSim from Matlab
%  ========================================================================
%
%  Sintaxis:
%   openMobileSim(simPath, mapPath)
%   openMobileSim(simPath)
%   openMobileSim
%
%  Description:
%    With this function you can execute MobileSim from Matlab by setting your
%    path of MobileSim and the path of your desired map. If no map file is
%    given MobileSim will open with an empty map, if no filepath arguments
%    are given default mobileSim installation path will be used.
%  
%  Arguments:
%    simPath:  your defined path of MobileSim.exe
%    mapPath:  the path of the map file(.map) you desire to open
%
%  Example:
%    simPath = 'C:\Program Files\MobileRobots\MobileSim\MobileSim.exe';
%    mapPath = 'C:\Program Files\MobileRobots\MobileSim\AMROffice.map';
%    openMobileSim(simPath ,mapPath)
%
%  References:
%    Aria Reference HTML
%
%  See also closeMobileSim , simSetPos , simMoveOrigPos
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de 
%========================================================================

%  Known Bugs:
%     known bugs should be recorded here
%
%  Author: Luis Felipe Posada 
%  Created: 02.07.2008
%
%  History:
%  <DATE>       <AUTHOR>		<DESCRIPTION>
%  01.12.2008   Stritzke      Better function documentation with RST Coding Rules
%  11.03.2009   Posada        ShortPath validation, default call without arguments added.
%  12.03.2009   Posada        Function rewritten. opens mobileSim with command line invisible 
%% ========================================================================

function openMobileSim(simPath, mapPath)
% Arguments parsing
error(nargchk(0, 2, nargin))

% locate the openMobilSim directory
str = which('openMobileSim');
% separate the path in parts
[pathstr, name, ext, versn] = fileparts(str);
% create the batch file openSim.bat in write mode
% locate the openMobilSim directory
str = which('openMobileSim');
% separate the path in parts
[pathstr, name, ext, versn] = fileparts(str);
% create the batch file openSim.bat in write mode
fid = fopen([pathstr,'\tempOpenSim.bat'],'w');

if nargin == 0 % use default installation path
    defaultPath = 'C:\Program Files\MobileRobots\MobileSim\MobileSim.exe';  
    % use DOS short Path name
    simPathShort = shortPathName(defaultPath);    
    if ~isempty(simPathShort)% check if the path is valid 
        % Create the batch command to open MobilSim
        command = [simPathShort,' --nomap'];
    else
        error('MobileSim.exe could not be located at default installation C:\Program Files\MobileRobots\MobileSim\MobileSim.exe')
    end 
elseif  nargin ==1 % open mobileSim without map    
    % use DOS short Path name
    simPathShort = shortPathName(simPath);
        % create a Batch File to open MobilSim
    if ~isempty(simPathShort) % check if the path is valid 
        command = [simPathShort,' --nomap'];
    else
        error('MobileSim.exe path not valid')
    end
    
elseif nargin == 2 % open MobileSim and a map    
    % use DOS short Path name
    simPathShort = shortPathName(simPath);
    mapPathShort = shortPathName(mapPath);
    if ~isempty(simPathShort) % check if the path is valid        
        if  ~isempty(mapPathShort) % check if the path is valid
            % Create the batch command to open MobilSim
            command = [simPathShort,' -m ', mapPathShort];
        else
            error('Map filepath not valid ')
        end        
    else
        error('MobileSim.exe filepath not valid ')        
    end
end

% Add double backslah (\\)for correct fprintf
indx = findstr('\', command);
% Insert double \\
insertrows(command',['\']',indx-1)';
% write the batch file
fprintf(fid,'%s',command);
fclose(fid);
% now run the batch file with the command line invisible
command = [shortPathName(pathstr),'\openSimInv.bat'];
winopen(command)
        

 



%% Auxiliary functions
function [C,RA,RB] = insertrows(A,B,ind)
% INSERTROWS - Insert rows into a matrix at specific locations
%   C = INSERTROWS(A,B,IND) inserts the rows of matrix B into the matrix A at
%   the positions IND. Row k of matrix B will be inserted after position IND(k)
%   in the matrix A. If A is a N-by-X matrix and B is a M-by-X matrix, C will
%   be a (N+M)-by-X matrix. IND can contain non-integers.
%
%   If B is a 1-by-N matrix, B will be inserted for each insertion position
%   specified by IND. If IND is a single value, the whole matrix B will be
%   inserted at that position. If B is a single value, B is expanded to a row
%   vector. In all other cases, the number of elements in IND should be equal to
%   the number of rows in B, and the number of columns, planes etc should be the
%   same for both matrices A and B. 
%
%   Values of IND smaller than one will cause the corresponding rows to be
%   inserted in front of A. C = INSERTROWS(A,B) will simply append B to A.
%
%   If any of the inputs are empty, C will return A. If A is sparse, C will
%   be sparse as well. 
%
%   [C, RA, RB] = INSERTROWS(...) will return the row indices RA and RB for
%   which C corresponds to the rows of either A and B.
%
%   Examples:
%     % the size of A,B, and IND all match
%        C = insertrows(rand(5,2),zeros(2,2),[1.5 3]) 
%     % the row vector B is inserted twice
%        C = insertrows(ones(4,3),1:3,[1 Inf]) 
%     % matrix B is expanded to a row vector and inserted twice (as in 2)
%        C = insertrows(ones(5,3),999,[2 4])
%     % the whole matrix B is inserted once
%        C = insertrows(ones(5,3),zeros(2,3),2)
%     % additional output arguments
%        [c,ra,rb] = insertrows([1:4].',99,[0 3]) 
%        c.'     % -> [99 1 2 3 99 4] 
%        c(ra).' % -> [1 2 3 4] 
%        c(rb).' % -> [99 99] 
%
%   Using permute (or transpose) INSERTROWS can easily function to insert
%   columns, planes, etc:
%
%     % inserting columns, by using the transpose operator:
%        A = zeros(2,3) ; B = ones(2,4) ;
%        c = insertrows(A.', B.',[0 2 3 3]).'  % insert columns
%     % inserting other dimensions, by using permute:
%        A = ones(4,3,3) ; B = zeros(4,3,1) ; 
%        % set the dimension on which to operate in front
%        C = insertrows(permute(A,[3 1 2]), permute(B,[3 1 2]),1) ;
%        C = ipermute(C,[3 1 2]) 
%
%  See also HORZCAT, RESHAPE, CAT

% for Matlab R13
% version 2.0 (may 2008)
% (c) Jos van der Geest
% email: jos@jasen.nl

% History:
% 1.0, feb 2006 - created
% 2.0, may 2008 - incorporated some improvements after being selected as
% "Pick of the Week" by Jiro Doke, and reviews by Tim Davis & Brett:
%  - horizontal concatenation when two arguments are provided
%  - added example of how to insert columns
%  - mention behavior of sparse inputs
%  - changed "if nargout" to "if nargout>1" so that additional outputs are
%    only calculated when requested for

error(nargchk(2,3,nargin)) ;

if nargin==2,
    % just horizontal concatenation, suggested by Tim Davis
    ind = size(A,1) ;
end

% shortcut when any of the inputs are empty
if isempty(B) || isempty(ind),    
    C = A ;     
    if nargout > 1,
        RA = 1:size(A,1) ;
        RB = [] ;
    end
    return
end

sa = size(A) ;

% match the sizes of A, B
if numel(B)==1,
    % B has a single argument, expand to match A
    sb = [1 sa(2:end)] ;
    B = repmat(B,sb) ;
else
    % otherwise check for dimension errors
    if ndims(A) ~= ndims(B),
        error('insertrows:DimensionMismatch', ...
            'Both input matrices should have the same number of dimensions.') ;
    end
    sb = size(B) ;
    if ~all(sa(2:end) == sb(2:end)),
        error('insertrows:DimensionMismatch', ...
            'Both input matrices should have the same number of columns (and planes, etc).') ;
    end
end

ind = ind(:) ; % make as row vector
ni = length(ind) ;

% match the sizes of B and IND
if ni ~= sb(1),
    if ni==1 && sb(1) > 1,
        % expand IND
        ind = repmat(ind,sb(1),1) ;
    elseif (ni > 1) && (sb(1)==1),
        % expand B
        B = repmat(B,ni,1) ;
    else
        error('insertrows:InputMismatch',...
            'The number of rows to insert should equal the number of insertion positions.') ;
    end
end

sb = size(B) ;

% the actual work
% 1. concatenate matrices
C = [A ; B] ;
% 2. sort the respective indices, the first output of sort is ignored (by
% giving it the same name as the second output, one avoids an extra 
% large variable in memory)
[abi,abi] = sort([[1:sa(1)].' ; ind(:)]) ;
% 3. reshuffle the large matrix
C = C(abi,:) ;
% 4. reshape as A for nd matrices (nd>2)
if ndims(A) > 2,
    sc = sa ;
    sc(1) = sc(1)+sb(1) ;
    C = reshape(C,sc) ;
end

if nargout > 1,
    % additional outputs required
    R = [zeros(sa(1),1) ; ones(sb(1),1)] ;
    R = R(abi) ;
    RA = find(R==0) ;
    RB = find(R==1) ;
end

%%=========================================================================
function [sname] = shortPathName(lname)
%
% Under Windows, gets the short name (8.3) of file or folder lname. Creates a command script
% with lname as parameter and uses the modifier %~s1 to get the short name of lname.
%
%  Example : >> shortPathName('C:\Documents and Settings\lulu\Bureau\Inno Setup Compiler.lnk')
%
%         returns 'C:\DOCUME~1\lulu\Bureau\INNOSE~1.LNK'
%
%  Luc Masset (2008)

%initialisation
sname=[];

%file or folder exists ?
iexist=exist(lname);
if ~ismember(iexist,[2 7]),
 return
end

%creating command scipt
sfile=[tempname '.cmd'];
ofile=[tempname '.txt'];
fid=fopen(sfile,'w');
if fid < 0,
 return
end
fprintf(fid,'@echo off\r\n');
fprintf(fid,'echo %%~s1> "%s"\r\n',ofile);
fclose(fid);

%run script
st=sprintf('"%s" "%s"',sfile,lname);
ie=dos(st);
delete1(sfile);
if ie,
 delete1(ofile);
 return
end

%output file
fid=fopen(ofile,'r');
if fid < 0,
 delete1(ofile);
 return
end
st=fgetl(fid);
fclose(fid);
delete1(ofile);

%result
st=deblank(st);
if isempty(st),
 return
end
if exist(st) ~= iexist,
 return
end
sname=st;

return

%------------------------------------------------------------------------------
function [] = delete1(file)
%
% Delete file if file exists.
%

if exist(file) ~= 2,
 return
end
st=sprintf('del /F/Q "%s"',file);
status=dos(st);

return

