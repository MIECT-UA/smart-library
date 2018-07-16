function varargout = ShowLibraryStats(varargin)
% SHOWLIBRARYSTATS MATLAB code for ShowLibraryStats.fig
%      SHOWLIBRARYSTATS, by itself, creates a new SHOWLIBRARYSTATS or raises the existing
%      singleton*.
%
%      H = SHOWLIBRARYSTATS returns the handle to a new SHOWLIBRARYSTATS or the handle to
%      the existing singleton*.
%
%      SHOWLIBRARYSTATS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOWLIBRARYSTATS.M with the given input arguments.
%
%      SHOWLIBRARYSTATS('Property','Value',...) creates a new SHOWLIBRARYSTATS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShowLibraryStats_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShowLibraryStats_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ShowLibraryStats

% Last Modified by GUIDE v2.5 02-Dec-2017 19:35:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ShowLibraryStats_OpeningFcn, ...
                   'gui_OutputFcn',  @ShowLibraryStats_OutputFcn, ...
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

% --- Executes just before ShowLibraryStats is made visible.
function ShowLibraryStats_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShowLibraryStats (see VARARGIN)

% Choose default command line output for ShowLibraryStats
handles.output = hObject;

%% Update handles structure with library data 
h = findobj('Tag', 'Main');
if ~isempty(h)
    data = guidata(h);
    data = data.data;
end
handles.data = data;
guidata(hObject, handles);

% UIWAIT makes ShowLibraryStats wait for user response (see UIRESUME)
% uiwait(handles.ShowLibraryStats);

%% Update texts with the library_stats
%function [library_size, biggest_lang, top_subject, top_words] = library_stats(library, ref_count_bf)

[library_size, biggest_lang, top_subject, top_words] = library_stats(handles.data.library, handles.data.ref_count_bf);
set(handles.text_library_size, 'string', library_size);
set(handles.text_biggest_lang, 'string', biggest_lang);

set(handles.text_top_words_EN, 'string', top_words(1));
set(handles.text_top_words_FR, 'string', top_words(2));
set(handles.text_top_words_DE, 'string', top_words(3));
set(handles.text_top_words_PT, 'string', top_words(4));

set(handles.text_top_subject_EN, 'string', top_subject(1));
set(handles.text_top_subject_FR, 'string', top_subject(2));
set(handles.text_top_subject_DE, 'string', top_subject(3));
set(handles.text_top_subject_PT, 'string', top_subject(4));

% --- Outputs from this function are returned to the command line.
function varargout = ShowLibraryStats_OutputFcn(hObject, eventdata, handles) 
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
%fprintf('\nNext\n');
