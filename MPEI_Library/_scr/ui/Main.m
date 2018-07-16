function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 02-Dec-2017 19:34:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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

 % option to choose (0 library stats, 1 import)

% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

%% Library Setup
% number of independent hash functions used in various points of the
% application
hashes_num = 50;
 
% create a map for all files in the library
library = init_library(0);
 
% initialize hashmap with existing shingles, if not already initialized
shinglemap = init_shinglemap(library, 0);
 
% create reference bloom filter for quicker subject estimation
ref_count_bf = init_ref_count_bf(library, hashes_num, 0);
 
% create the library's bloom filter
lib_bf = init_bf(library, 0);
 
%% Run application

%% Update handles structure with library data 

if (~isfield(handles,'data'))
    handles.data.option = 1;
    handles.data.hashes_num = hashes_num;
    handles.data.library = library;
    handles.data.shinglemap = shinglemap;
    handles.data.ref_count_bf = ref_count_bf;
    handles.data.lib_bf = lib_bf;
end
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.Main);

% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbuttonExit.
function pushbuttonExit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fprintf('Exit\n');
delete (handles.output);

% --- Executes on button press in pushbuttonNext.
function pushbuttonNext_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fprintf('option %f', handles.data.option);
if handles.data.option == 1
    %delete (handles.output);
    set(handles.output,'visible','off');
    ImportFile;
else
    %delete (handles.output);
    set(handles.output,'visible','off');
    ShowLibraryStats;
end
%fprintf('\nNext\n');


% --- Executes when selected object is changed in RadioButtonsGroup.
function RadioButtonsGroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in RadioButtonsGroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.import)             % Import
    option = 1;
else
    option = 0;
end

% Save the new option value
handles.data.option = option;
guidata(hObject,handles);
