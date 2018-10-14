function varargout = OCR_Translation_app(varargin)
% OCR_TRANSLATION_APP MATLAB code for OCR_Translation_app.fig
%      OCR_TRANSLATION_APP, by itself, creates a new OCR_TRANSLATION_APP or raises the existing
%      singleton*.
%
%      H = OCR_TRANSLATION_APP returns the handle to a new OCR_TRANSLATION_APP or the handle to
%      the existing singleton*.
%
%      OCR_TRANSLATION_APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OCR_TRANSLATION_APP.M with the given input arguments.
%
%      OCR_TRANSLATION_APP('Property','Value',...) creates a new OCR_TRANSLATION_APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OCR_Translation_app_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OCR_Translation_app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OCR_Translation_app

% Last Modified by GUIDE v2.5 14-Oct-2018 15:52:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OCR_Translation_app_OpeningFcn, ...
                   'gui_OutputFcn',  @OCR_Translation_app_OutputFcn, ...
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


% --- Executes just before OCR_Translation_app is made visible.
function OCR_Translation_app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OCR_Translation_app (see VARARGIN)

% Choose default command line output for OCR_Translation_app
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
src_lang=handles.src_lang_text.String;
dest_lang=handles.dest_lang_text.String;
url=strcat('http://',handles.ip_text.String,':',handles.port_text.String,'/shot.jpg');
handles.T=Translator(url,src_lang,dest_lang);
axes(handles.img_plot);
global stream;
stream=0;
guidata(hObject,handles);



% UIWAIT makes OCR_Translation_app wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OCR_Translation_app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in stream_start.
function stream_start_Callback(hObject, eventdata, handles)
% hObject    handle to stream_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stream;
stream=1;
while(stream)
guidata(hObject,handles);
handles.T=handles.T.stream();
end




function ip_text_Callback(hObject, eventdata, handles)
% hObject    handle to ip_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ip_text as text
%        str2double(get(hObject,'String')) returns contents of ip_text as a double


% --- Executes during object creation, after setting all properties.
function ip_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ip_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function port_text_Callback(hObject, eventdata, handles)
% hObject    handle to port_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of port_text as text
%        str2double(get(hObject,'String')) returns contents of port_text as a double


% --- Executes during object creation, after setting all properties.
function port_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to port_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_snapshot.
function get_snapshot_Callback(hObject, eventdata, handles)
% hObject    handle to get_snapshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stream
stream =0;
%guidata(hObject,handles);

% --- Executes on button press in trans.
function trans_Callback(hObject, eventdata, handles)
% hObject    handle to trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.img_plot);
handles.T=handles.T.translate();
handles.src_comp_text.String=handles.T.text_source;
handles.dest_comp_text.String=handles.T.text_destination;
guidata(hObject,handles);





function src_lang_text_Callback(hObject, eventdata, handles)
% hObject    handle to src_lang_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of src_lang_text as text
%        str2double(get(hObject,'String')) returns contents of src_lang_text as a double


% --- Executes during object creation, after setting all properties.
function src_lang_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to src_lang_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dest_lang_text_Callback(hObject, eventdata, handles)
% hObject    handle to dest_lang_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dest_lang_text as text
%        str2double(get(hObject,'String')) returns contents of dest_lang_text as a double


% --- Executes during object creation, after setting all properties.
function dest_lang_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dest_lang_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function src_comp_text_Callback(hObject, eventdata, handles)
% hObject    handle to src_comp_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of src_comp_text as text
%        str2double(get(hObject,'String')) returns contents of src_comp_text as a double


% --- Executes during object creation, after setting all properties.
function src_comp_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to src_comp_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dest_comp_text_Callback(hObject, eventdata, handles)
% hObject    handle to dest_comp_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dest_comp_text as text
%        str2double(get(hObject,'String')) returns contents of dest_comp_text as a double


% --- Executes during object creation, after setting all properties.
function dest_comp_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dest_comp_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
