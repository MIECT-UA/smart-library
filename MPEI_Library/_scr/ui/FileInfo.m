function varargout = FileInfo(varargin)
% FILEINFO MATLAB code for FileInfo.fig
%      FILEINFO, by itself, creates a new FILEINFO or raises the existing
%      singleton*.
%
%      H = FILEINFO returns the handle to a new FILEINFO or the handle to
%      the existing singleton*.
%
%      FILEINFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILEINFO.M with the given input arguments.
%
%      FILEINFO('Property','Value',...) creates a new FILEINFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FileInfo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FileInfo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FileInfo

% Last Modified by GUIDE v2.5 02-Dec-2017 19:34:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FileInfo_OpeningFcn, ...
                   'gui_OutputFcn',  @FileInfo_OutputFcn, ...
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

% --- Executes just before FileInfo is made visible.
function FileInfo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FileInfo (see VARARGIN)

% Choose default command line output for FileInfo
handles.output = hObject;

%% Update handles structure with library data 
h = findobj('Tag', 'ImportFile');
    if ~isempty(h)
        data = guidata(h);
        data = data.data;
    end
handles.data = data;
guidata(hObject, handles);
set(handles.textEstimatedLanguage, 'string', handles.data.language);
set(handles.textEstimatedSubject, 'string', handles.data.subject);
set(handles.textRecommendedFile, 'string', handles.data.recommendedFile);
% UIWAIT makes FileInfo wait for user response (see UIRESUME)
% uiwait(handles.FileInfo);

% --- Outputs from this function are returned to the command line.
function varargout = FileInfo_OutputFcn(hObject, eventdata, handles) 
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
set(handles.output,'visible','off');
Main;
%fprintf('\nBack\n');
