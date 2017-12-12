
%  Deactivate_Joystick - This is a gui script to deactivate the joystick
%  ========================================================================
%
%  Deactivate_Joystick()
%
%  Description:
%    This GUI is only used in the script Move_Robot_with_Joystick.
%    It is just a button to deactivate the control by the Joystick for the user. 
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
%  See also Move_Robot_with_Joystick , actionJoydrive , clearDirectMotion , disableActions , demoAction .
%
%  Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
%                     www-rst.e-technik.tu-dortmund.de
% 
%% ========================================================================


function varargout = Deactivate_Joystick(varargin)
% Deactivate_Joystick M-file for Deactivate_Joystick.fig
%      Deactivate_Joystick by itself, creates a new Deactivate_Joystick or raises the
%      existing singleton*.
%
%      H = Deactivate_Joystick returns the handle to a new Deactivate_Joystick or the handle to
%      the existing singleton*.
%
%      Deactivate_Joystick('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Deactivate_Joystick.M with the given input arguments.
%
%      Deactivate_Joystick('Property','Value',...) creates a new Deactivate_Joystick or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Deactivate_Joystick_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Deactivate_Joystick_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Deactivate_Joystick

% Last Modified by GUIDE v2.5 19-Sep-2008 11:54:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Deactivate_Joystick_OpeningFcn, ...
                   'gui_OutputFcn',  @Deactivate_Joystick_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before Deactivate_Joystick is made visible.
function Deactivate_Joystick_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Deactivate_Joystick (see VARARGIN)

% Choose default command line output for Deactivate_Joystick
handles.output = 'Yes';

% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end


% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes Deactivate_Joystick wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Deactivate_Joystick_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in yesbutton.
function yesbutton_Callback(hObject, eventdata, handles)
% hObject    handle to yesbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Joystick deactivated')
shutdown()
handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete becDeactivate_Joysticke the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);




% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    disp('Joystick deactivated')
    shutdown()
   
    handles.output = 'Yes';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    disp('Joystick deactivated')
    shutdown()
    
    uiresume(handles.figure1);
end    
