function makeMatlabAriaInterface
%Description: This function compiles the Matlab-Aria Interfacace mex file

%Autors:	Luis Felipe Posada
%e-mail:	felipe.posada@tu-dortmund.de
%Date:	27.04.2009
%
%Copyright (c) 2009 RST, Technische Universität Dortmund, Germany
%www-rst.e-technik.uni-dortmund.de

%%========================== EDIT YOUR PATH ===============================
% Aria Files (Adjust your specific Path)
% Include Files
inc{1} = 'C:\Program Files\MobileRobots\Aria\include';
%Library Files
lib{1} = 'C:\Program Files\MobileRobots\Aria\lib\ARIA.lib';
% Compiler Files (Adjust your path to locate winmm.lib, Wsock32.lib)
lib{2} = 'C:\Program Files\Microsoft Visual Studio .NET 2003\Vc7\PlatformSDK\Lib\WinMM.Lib';
lib{3} = 'C:\Program Files\Microsoft Visual Studio .NET 2003\Vc7\PlatformSDK\Lib\WSock32.Lib'; 
%============================STOP EDITING =================================


%% Convert Long Path to DOS short Path 
%Ex: C:\ProgramFiles\Windows\ -> C:\PROGRA~1\WINDOWS\
for k = 1:size(inc,2)
    incShort{k} = shortPathName(inc{k});
end

for k = 1:size(lib,2)
    libShort{k} = shortPathName(lib{k});
end


%% Check if path is valid
% include files
for k = 1:size(inc,2)
    if isempty(incShort{k})
        error('%s ->path does not exist',inc{k})
    end
end
% library files
for k = 1:size(lib,2)
    if isempty(libShort{k})
        error('%s ->path does not exist',lib{k})
    end
end

%% Building arguments
% Include files
incFiles = [];
for k = 1:size(incShort,2)
    incFiles = [incFiles ' -I',incShort{k}];
end

% library files
libFiles = [];
for k = 1:size(lib,2)
    libFiles = [libFiles, ' ', libShort{k}];
end



%% Compilation
cmd{1} = ['mex src\ariainterface.cpp src\ActionAvoidFront.cpp src\ActionSetHeading.cpp src\ActionSetRotVel.cpp src\ActionSetVel.cpp src\ActionStopFront.cpp -outdir bin -O ',incFiles, libFiles];        

for k = 1:size(cmd,2)
   fprintf('Compiling file %d\n',k)
   eval(cmd{k})
end
pause(0.1)


%% Auxiliary functions
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

