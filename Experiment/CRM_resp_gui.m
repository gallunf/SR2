function varargout = CRM_resp_gui(varargin)
% CRM_RESP_GUI M-file for CRM_resp_gui.fig
%      CRM_RESP_GUI, by itself, creates a new CRM_RESP_GUI or raises the existing
%      singleton*.
%
%      H = CRM_RESP_GUI returns the handle to a new CRM_RESP_GUI or the handle to
%      the existing singleton*.
%
%      CRM_RESP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRM_RESP_GUI.M with the given input arguments.
%
%      CRM_RESP_GUI('Property','Value',...) creates a new CRM_RESP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CRM_resp_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CRM_resp_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRM_resp_gui

% Last Modified by GUIDE v2.5 22-Mar-2010 09:45:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRM_resp_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @CRM_resp_gui_OutputFcn, ...
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


% --- Executes just before CRM_resp_gui is made visible.
function CRM_resp_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CRM_resp_gui (see VARARGIN)

% Choose default command line output for CRM_resp_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CRM_resp_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CRM_resp_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mydata.color=00;
mydata.number=00;
set(get(gcbo,'Parent'),'UserData',mydata);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=00;
mydata.number=01;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=00;
mydata.number=02;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mydata.color=00;
mydata.number=03;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=00;
mydata.number=04;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=00;
mydata.number=05;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=00;
mydata.number=06;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=00;
mydata.number=07;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=01;
mydata.number=00;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mydata.color=01;
mydata.number=01;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=01;
mydata.number=02;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=01;
mydata.number=03;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=01;
mydata.number=04;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=01;
mydata.number=05;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mydata.color=01;
mydata.number=06;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=01;
mydata.number=07;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mydata.color=02;
mydata.number=00;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=01;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=02;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=03;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=04;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=05;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=06;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=02;
mydata.number=07;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=03;
mydata.number=00;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=03;
mydata.number=01;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=03;
mydata.number=02;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=03;
mydata.number=03;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=03;
mydata.number=04;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=03;
mydata.number=05;
set(get(gcbo,'Parent'),'UserData',mydata);



% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mydata.color=03;
mydata.number=06;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see gcbo)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mydata.color=03;
mydata.number=07;
set(get(gcbo,'Parent'),'UserData',mydata);


% --- Executes on button press in pb_start.
function pb_start_Callback(hObject, eventdata, handles)
% hObject    handle to pb_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mydata.color=99;
mydata.number=99;
set(get(gcbo,'Parent'),'UserData',mydata);
