function varargout = AboutForm(varargin)
% -------------------------------------------------------------------------
% Univerzitet u Sarajevu
% Elektrotehnicki fakultet
% Sarajevo
%
% Naziv forme: AboutForm
% Opis forme: Forma koja daje osnovne informacije o aplikaciji. Poziva se
% iz PioneerClient forme. Forma je dio alikacija radjenih za potrebe master
% rada autora ove aplikacije.
% -------------------------------------------------------------------------
% 19.08.2010, Sarajevo                         Autor: Faris Hodzic
%                                              Contact: fh14588@etf.unsa.ba
% -------------------------------------------------------------------------

    % Pocetak inicijalizacionog koda - NE MIJENJATI
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @AboutForm_OpeningFcn, ...
                       'gui_OutputFcn',  @AboutForm_OutputFcn, ...
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
    % Kraj inicijalizacionog koda - NE MIJENJATI


% --- Izvrsava se prije nego sto forma postane vidljiva
function AboutForm_OpeningFcn(hObject, eventdata, handles, varargin)
    % Odabir izlazne komandne linije za ovu formu
    handles.output = hObject;
    % Osvjezavanje strukture
    guidata(hObject, handles);

% --- Izlazi ove funkcije se vracaju u komandni prozor.
function varargout = AboutForm_OutputFcn(hObject, eventdata, handles) 
    % Dobijanje komandne linije
    varargout{1} = handles.output;

% --- Izvrsava se nakon sto korisnik zahtjeva zatvaranje forme.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
    % Brise se forma
    delete(hObject);


% --- Izvrsava se nakon sto je objekat kreiran
function picture2_CreateFcn(hObject, eventdata, handles)
    axes(hObject);
    % Loaduje se logo proizvodjaca
    imshow('logo.jpg');


% --- Executes during object creation, after setting all properties.
function robotpicture_CreateFcn(hObject, eventdata, handles)
    axes(hObject);
    % Loaduje se slika roobota
    imshow('pioneerpic.jpg');

% --- Executes during object creation, after setting all properties.
function picture1_CreateFcn(hObject, eventdata, handles)
    axes(hObject);
    % Loaduje se slika roobota
    imshow('pclogo.gif');


% --- Executes during object creation, after setting all properties.
function etf_CreateFcn(hObject, eventdata, handles)
    axes(hObject);
    % Loaduje se slika roobota
    imshow('etflogo.gif');


