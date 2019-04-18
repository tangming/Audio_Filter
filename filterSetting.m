function varargout = filterSetting(varargin)
% FILTERSETTING MATLAB code for filterSetting.fig
%      FILTERSETTING, by itself, creates a new FILTERSETTING or raises the existing
%      singleton*.
%
%      H = FILTERSETTING returns the handle to a new FILTERSETTING or the handle to
%      the existing singleton*.
%
%      FILTERSETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTERSETTING.M with the given input arguments.
%
%      FILTERSETTING('Property','Value',...) creates a new FILTERSETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filterSetting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filterSetting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filterSetting

% Last Modified by GUIDE v2.5 28-Apr-2018 17:15:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filterSetting_OpeningFcn, ...
                   'gui_OutputFcn',  @filterSetting_OutputFcn, ...
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


% --- Executes just before filterSetting is made visible.
function filterSetting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filterSetting (see VARARGIN)

% Choose default command line output for filterSetting
handles.output = hObject;
% handles.Fs = varargin{1};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes filterSetting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = filterSetting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on selection change in popupmenu_name.
function popupmenu_name_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_name
nameIdx = get(hObject,'Value');
handles.nameIdx = nameIdx;
switch(nameIdx)
    case(1)
        set(handles.edit_PB,'Enable','off');
        set(handles.text_PB,'Enable','off');
        set(handles.edit_SB,'Enable','off');
        set(handles.text_SB,'Enable','off');
    case(2)
        set(handles.edit_PB,'Enable','on');
        set(handles.text_PB,'Enable','on');
        set(handles.edit_SB,'Enable','off');
        set(handles.text_SB,'Enable','off');    
    otherwise
        set(handles.edit_PB,'Enable','on');
        set(handles.text_PB,'Enable','on');
        set(handles.edit_SB,'Enable','on');
        set(handles.text_SB,'Enable','on');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_type.
function popupmenu_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_type
typeIdx = get(hObject,'Value');
handles.typeIdx = typeIdx;
switch(typeIdx)
    case(1)
        set(handles.text_LP,'Enable','on');
        set(handles.edit_LP,'Enable','on');
        set(handles.text_HP,'Enable','off');
        set(handles.edit_HP,'Enable','off');
    case(2)
        set(handles.text_HP,'Enable','on');
        set(handles.edit_HP,'Enable','on');
        set(handles.text_LP,'Enable','off');
        set(handles.edit_LP,'Enable','off');
    otherwise
        set(handles.text_HP,'Enable','on');
        set(handles.edit_HP,'Enable','on');
        set(handles.text_LP,'Enable','on');
        set(handles.edit_LP,'Enable','on');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_order.
function popupmenu_order_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_order contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_order
order = get(hObject,'Value');
handles.order=order+1;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_OK.
function pushbutton_OK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% nameIdx = get(hObject,'Value');
% handles.nameIdx = nameIdx;
% typeIdx = get(hObject,'Value');
% handles.typeIdx = typeIdx;
% order = get(hObject,'Value');
% handles.order=order+1;

final=(handles.nameIdx*10)+handles.typeIdx;
Fs = evalin('base', 'Fs')
handles.Fs = Fs;
switch(final)
    case(11)
        fpass  = str2double(get(handles.edit_LP,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=butter(n,wn,'low');

    case(12)
        fpass  = str2double(get(handles.edit_HP,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=butter(n,wn,'high');
    case(13)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=butter(n,[wp ws],'bandpass');

    case(14)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=butter(n,[wp ws],'stop');
    case(21)
        fpass  = str2double(get(handles.edit_LP,'String'));
        r=str2double(get(handles.pass,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=cheby1(n,r,wn,'low');

    case(22)
        fpass  = str2double(get(handles.edit_HP,'String'));
        r=str2double(get(handles.pass,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=cheby1(n,r,wn,'high');
    case(23)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        r=str2double(get(handles.pass,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=cheby1(n,r,[wp ws],'bandpass');

    case(24)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        r=str2double(get(handles.pass,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=cheby1(n,r,[wp ws],'stop');
    case(31)
        fpass  = str2double(get(handles.edit_LP,'String'));
        rp=str2double(get(handles.pass,'String'));
        rs=str2double(get(handles.stop,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,wn,'low');

    case(32)
        fpass  = str2double(get(handles.edit_HP,'String'));
        rp=str2double(get(handles.pass,'String'));
        rs=str2double(get(handles.stop,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,wn,'high');
    case(33)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        rp=str2double(get(handles.pass,'String'));
        rs=str2double(get(handles.stop,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,[wp ws],'bandpass');

    case(34)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        rp=str2double(get(handles.pass,'String'));
        rs=str2double(get(handles.stop,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,[wp ws],'stop');
end
assignin('base','b',b);
assignin('base','a',a);
guidata(hObject, handles);


function edit_LP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LP as text
%        str2double(get(hObject,'String')) returns contents of edit_LP as a double
handles.LP = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_LP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_HP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_HP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_HP as text
%        str2double(get(hObject,'String')) returns contents of edit_HP as a double
handles.HP = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_HP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_HP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PB as text
%        str2double(get(hObject,'String')) returns contents of edit_PB as a double
handles.PB = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_PB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SB as text
%        str2double(get(hObject,'String')) returns contents of edit_SB as a double
handles.SB = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_SB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
