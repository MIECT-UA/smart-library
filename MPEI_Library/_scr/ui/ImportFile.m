function varargout = ImportFile(varargin)
% IMPORTFILE MATLAB code for ImportFile.fig
%      IMPORTFILE, by itself, creates a new IMPORTFILE or raises the existing
%      singleton*.
%
%      H = IMPORTFILE returns the handle to a new IMPORTFILE or the handle to
%      the existing singleton*.
%
%      IMPORTFILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORTFILE.M with the given input arguments.
%
%      IMPORTFILE('Property','Value',...) creates a new IMPORTFILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImportFile_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImportFile_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImportFile

% Last Modified by GUIDE v2.5 02-Dec-2017 19:35:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImportFile_OpeningFcn, ...
                   'gui_OutputFcn',  @ImportFile_OutputFcn, ...
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

global option; % option to choose (0 library stats, 1 import)

% --- Executes just before ImportFile is made visible.
function ImportFile_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImportFile (see VARARGIN)

% Choose default command line output for ImportFile
handles.output = hObject;

%% Update handles structure with library data 
h = findobj('Tag', 'Main');
    if ~isempty(h)
        data = guidata(h);
        data = data.data;
    end
handles.data = data;
guidata(hObject, handles);

% UIWAIT makes ImportFile wait for user response (see UIRESUME)
% uiwait(handles.ImportFile);

% --- Outputs from this function are returned to the command line.
function varargout = ImportFile_OutputFcn(hObject, eventdata, handles) 
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

%% --- Executes on button press in
% pushbuttonNext.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pushbuttonNext_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fprintf('\nNext\n')
handles.data; % debug
%fprintf('Path to the book is %s', handles.data.path);
[language, subject] = add_new_book(handles.data.path, 50, handles.data.lib_bf, handles.data.ref_count_bf, handles.data.library); 
handles.data.language = language;
handles.data.subject = subject;
handles.data.recommendedFile = most_similar_books_within_language(handles.data.path, 1, 50, language, handles.data.library);
guidata(hObject, handles);
set(handles.output,'visible','off');
FileInfo;

%%
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
path = get(hObject,'String');

% Save the new path value and update the handles struct
handles.data.path = path;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
