function varargout = Audio_Filter(varargin)
% AUDIO_FILTER MATLAB code for Audio_Filter.fig
%      AUDIO_FILTER, by itself, creates a new AUDIO_FILTER or raises the existing
%      singleton*.
%
%      H = AUDIO_FILTER returns the handle to a new AUDIO_FILTER or the handle to
%      the existing singleton*.
%
%      AUDIO_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIO_FILTER.M with the given input arguments.
%
%      AUDIO_FILTER('Property','Value',...) creates a new AUDIO_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Audio_Filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Audio_Filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Audio_Filter

% Last Modified by GUIDE v2.5 29-Apr-2018 16:38:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Audio_Filter_OpeningFcn, ...
                   'gui_OutputFcn',  @Audio_Filter_OutputFcn, ...
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


% --- Executes just before Audio_Filter is made visible.
function Audio_Filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Audio_Filter (see VARARGIN)

% Choose default command line output for Audio_Filter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Audio_Filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Audio_Filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.wav'},'Load Wav File');
[x,Fs] = audioread([PathName '/' FileName]);
x = x(:,1);
% assignin('base','Fs',Fs);
handles.x = x ./ max(abs(x));
handles.Fs = Fs;
axes(handles.axes_signal);
handles.Time = 0:1/Fs:(length(handles.x)-1)/Fs;
plot(handles.Time, handles.x);
axis([0 max(handles.Time) -1 1]);
xlabel('Time (s)')
ylabel('Magnitude')

axes(handles.axes_signalSpec);
% colormap(handles.axes_signalSpec, gray);
% specgram(handles.x, 1024, handles.Fs);
Fn = handles.Fs/2;
Fy = fft(handles.x)/length(handles.x);
Fv = linspace(0, 1, fix(length(handles.x)/2) + 1)*Fn;
Iv = 1:length(Fv);
plot(Fv, abs(Fy(Iv,1))*2)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

handles.fileLoaded = 1;

axes(handles.axes_noiseSpec); cla;
axes(handles.axes_signalNoiseSpec); cla;
axes(handles.axes_denoiseSpec); cla;

guidata(hObject, handles);


% --- Executes on button press in pushbutton_playSignal.
function pushbutton_playSignal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_playSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)
    sound(handles.x, handles.Fs);
end


% --- Executes on selection change in popupmenu_Noise.
function popupmenu_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_Noise contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_Noise

% switch (S)
%     case (1)
%         SP=norm(handles.x).^2; % Input signal power
%         NP=sqrt(SP*10^-(handles.SNR/10)/length(handles.x))*3.455; % Desired noise level
%         handles.x_noise = handles.x+NP*(0.5-rand(size(handles.x))); % adding noise
% end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_Noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_addNoise.
function pushbutton_addNoise_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileLoaded==1)
    if isfield(handles, 'SNR')
        SP=norm(handles.x).^2; % Input signal power
        NP=sqrt(SP*10^-(handles.SNR/10)/length(handles.x))*3.455; % Desired noise level
    else
        msgbox('Missing SNR! Please fill in the missing values and try again.','Missing SNR','error');
    end
                
    S = get(handles.popupmenu_Noise,'Value');
    
    switch (S)
        case (1) % white noise
            handles.Noise = NP*(0.5-rand(size(handles.x))); % adding noise
            %handles.Noise = wgn(1, length(handles.x), NP);
            DONE = 1;
        case (2) % signal freq noise
            %handles.Noise = wgn(1, length(handles.x), NP);
            f = 300;
            handles.Noise = NP*cos(2*pi*f*handles.Time');
            DONE = 1;
        case (3) % multi-freq noise
            f1 = 200;
            f2 = 300;
            f3 = 12000;
            f4 = 15000;
            handles.Noise = 0.25*NP*(cos(2*pi*f1*handles.Time')+cos(2*pi*f2*handles.Time')+cos(2*pi*f3*handles.Time')+cos(2*pi*f4*handles.Time'));
            DONE = 1;
    end
    
    
    if (DONE==1)
        handles.fileNoise = 1;
        handles.x_noise = handles.Noise + handles.x;
        
        axes(handles.axes_signalNoise)
        plot(handles.Time, handles.x_noise);
        axis([0 max(handles.Time) -1 1]);
        xlabel('Time (s)')
        ylabel('Time')


        axes(handles.axes_noiseSpec);
%         colormap(handles.axes_noiseSpec, gray);
%         specgram(handles.Noise, 1024, handles.Fs);
        Fn = handles.Fs/2;
        Fy = fft(handles.Noise)/length(handles.Noise);
        Fv = linspace(0, 1, fix(length(handles.Noise)/2) + 1)*Fn;
        Iv = 1:length(Fv);
        plot(Fv, abs(Fy(Iv,1))*2)
        xlabel('Frequency (Hz)')
        ylabel('Magnitude')


        axes(handles.axes_signalNoiseSpec);
%         colormap(handles.axes_signalNoiseSpec, gray);
%         specgram(handles.x_noise, 1024, handles.Fs);
Fn = handles.Fs/2;
Fy = fft(handles.x_noise)/length(handles.x);
Fv = linspace(0, 1, fix(length(handles.x)/2) + 1)*Fn;
Iv = 1:length(Fv);
plot(Fv, abs(Fy(Iv,1))*2)
xlabel('Frequency (Hz)')
ylabel('Magnitude')

    end

    
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton_playNoise.
function pushbutton_playNoise_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_playNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.fileNoise == 1)
    sound(handles.x_noise, handles.Fs);
end


function edit_SNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SNR as text
%        str2double(get(hObject,'String')) returns contents of edit_SNR as a double
handles.SNR = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_SNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Denoise.
function pushbutton_Denoise_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Denoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

final=(handles.nameIdx*10)+handles.typeIdx;
% Fs = evalin('base', 'Fs')
% handles.Fs = Fs;
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
        r=str2double(get(handles.edit_PB,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=cheby1(n,r,wn,'low');

    case(22)
        fpass  = str2double(get(handles.edit_HP,'String'));
        r=str2double(get(handles.edit_PB,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=cheby1(n,r,wn,'high');
    case(23)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        r=str2double(get(handles.edit_PB,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=cheby1(n,r,[wp ws],'bandpass');

    case(24)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        r=str2double(get(handles.edit_PB,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=cheby1(n,r,[wp ws],'stop');
    case(31)
        fpass  = str2double(get(handles.edit_LP,'String'));
        rp=str2double(get(handles.edit_PB,'String'));
        rs=str2double(get(handles.edit_SB,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,wn,'low');

    case(32)
        fpass  = str2double(get(handles.edit_HP,'String'));
        rp=str2double(get(handles.edit_PB,'String'));
        rs=str2double(get(handles.edit_SB,'String'));
        n=handles.order +1;
        wn=fpass*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,wn,'high');
    case(33)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        rp=str2double(get(handles.edit_PB,'String'));
        rs=str2double(get(handles.edit_SB,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,[wp ws],'bandpass');

    case(34)
        fpass  = str2double(get(handles.edit_LP,'String'));
        fstop  = str2double(get(handles.edit_HP,'String'));
        rp=str2double(get(handles.edit_PB,'String'));
        rs=str2double(get(handles.edit_SB,'String'));
        n=handles.order +1;
        wp=fpass*2/handles.Fs;
        ws=fstop*2/handles.Fs;
        [b,a]=ellip(n,rp,rs,[wp ws],'stop');
end


[F,w] = freqz(b, a, 1000, handles.Fs);
axes(handles.axes_filter);
semilogy(w,abs(F));
xlabel('Frequency (Hz)')
ylabel('Magnitude')
handles.x_filter = filter(b,a,handles.x_noise);

axes(handles.axes_signalFilted)
plot(handles.Time, handles.x_filter);
axis([0 max(handles.Time) -1 1]);
xlabel('Time (s)')
ylabel('Magnitude')

axes(handles.axes_denoiseSpec);
% colormap(handles.axes_denoiseSpec, gray);
% specgram(handles.x_filter, 1024, handles.Fs);
Fn = handles.Fs/2;
Fy = fft(handles.x_filter)/length(handles.x);
Fv = linspace(0, 1, fix(length(handles.x)/2) + 1)*Fn;
Iv = 1:length(Fv);
plot(Fv, abs(Fy(Iv,1))*2)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
handles.filtered = 1;

guidata(hObject, handles);



% --- Executes on button press in pushbutton_PlayDenoise.
function pushbutton_PlayDenoise_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PlayDenoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.filtered==1)
    sound(handles.x_filter, handles.Fs);
end


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
handles.nameIdx = 1;
guidata(hObject, handles);



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
handles.typeIdx = 1;
guidata(hObject, handles);


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
handles.order=2;
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
set(hObject,'Enable','off');



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
set(hObject,'Enable','off');



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
set(hObject,'Enable','off');
