function varargout = run_SR2(varargin)
% run_SR2 M-file for run_SR2.fig
%      run_SR2, by itself, creates a new run_SR2 or raises the existing
%      singleton*.
%
%      H = run_SR2 returns the handle to a new run_SR2 or the handle to
%      the existing singleton*.
%
%      run_SR2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in run_SR2.M with the given input arguments.
%
%      run_SR2('Property','Value',...) creates a new run_SR2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before run_SR2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to run_SR2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help run_SR2

% Last Modified by GUIDE v2.5 24-Apr-2012 14:47:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @run_SR2_OpeningFcn, ...
                   'gui_OutputFcn',  @run_SR2_OutputFcn, ...
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


% --- Executes just before run_SR2 is made visible.
function run_SR2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to run_SR2 (see VARARGIN)

% Choose default command line output for run_SR2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes run_SR2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
caldir=pwd;
try load([caldir '\calfiles\SR_calvals.mat'])
    set(handles.ed_cal_date,'String',calvals.date)
catch
    set(handles.ed_cal_date,'String','UNCALIBRATED')
end

prompt = {'Enter subject number:','Enter Right Ear SRT:','Enter Left Ear SRT:'};
dlg_title = 'Initialize Spatial Release Testing';
num_lines = 3;
def = {'555','0','0'};
subjdata = inputdlg(prompt,dlg_title,num_lines,def);

set(handles.ed_subjnum,'String',subjdata{1})
set(handles.ed_RE_SRT,'String',subjdata{2})
set(handles.ed_LE_SRT,'String',subjdata{3})

handles.SR2vals.SRT.RE=str2double(subjdata{2});
handles.SR2vals.SRT.LE=str2double(subjdata{3});

SLval=30;
HL2SPL=22;

SRT_dB_SPL.RE=str2num(subjdata{2})+HL2SPL;
SRT_dB_SPL.LE=str2num(subjdata{3})+HL2SPL;


handles.SR2vals.presentation_level.LE=SRT_dB_SPL.LE+SLval;
handles.SR2vals.presentation_level.RE=SRT_dB_SPL.RE+SLval;

if handles.SR2vals.presentation_level.LE > 80
    handles.SR2vals.presentation_level.LE = 80;
end

if handles.SR2vals.presentation_level.RE > 80
    handles.SR2vals.presentation_level.RE = 80;
end

maxlev=max([handles.SR2vals.presentation_level.RE handles.SR2vals.presentation_level.RE]);
handles.target_level=maxlev;

set(handles.ed_tlev,'String',num2str(maxlev))

subject=subjdata{1};
homedir=pwd;
if ~exist([homedir '\data'],'dir')
    eval(['mkdir ' homedir '\data'])
end

if ~exist([homedir '\data\' subject],'dir')
    eval(['mkdir ' homedir '\data\' subject])
end

fdir = dir([homedir '\data\' subject '\' subject '_SR2.*']);
runs=length(fdir);
if runs
    for n=1:runs
        try
        load([homedir '\data\' subject '\' subject '_SR2.' num2str(n)],'-mat')
        switch SR2vals.condition
            case 0
                set(handles.ed_colocated,'String',num2str(SR2vals.total_correct))
            case 15
                set(handles.ed_15degrees,'String',num2str(SR2vals.total_correct))
            case 30
                set(handles.ed_30degrees,'String',num2str(SR2vals.total_correct))
            case 45
                set(handles.ed_45degrees,'String',num2str(SR2vals.total_correct))
        end
        handles.summary{n}=SR2vals;
        end
    end
end
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = run_SR2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_go.
function pb_go_Callback(hObject, eventdata, handles)
% hObject    handle to pb_go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pb_go,'String','Running')
set(handles.pb_go,'BackgroundColor',[1 0 0])
set(handles.pb_go,'Enable','off')
set(handles.pb_stop,'Enable','on')
set(handles.pb_go,'UserData',1)

subject=get(handles.ed_subjnum,'String');
handles.SR2vals.subject=subject;

homedir=pwd;
if ~exist([homedir '\data'],'dir')
    eval(['mkdir ' homedir '\data'])
end

if ~exist([homedir '\data\' subject],'dir')
    eval(['mkdir ' homedir '\data\' subject])
end

fdir = dir([homedir '\data\' subject '\' subject '_SR2.*']);
runs=length(fdir);
run=length(fdir)+1;

handles.SR2vals.run=run;
handles.SR2vals.total_correct=NaN;
handles.SR2vals.file = [pwd '\data\' subject '\' subject '_SR2.' num2str(run)];

handles.SR2vals.condition=handles.condition;
handles.SR2vals.SRT.LE=str2double(get(handles.ed_LE_SRT,'String'));
handles.SR2vals.SRT.RE=str2double(get(handles.ed_RE_SRT,'String'));
handles.SR2vals.RMS=.123;
handles.SR2vals.target_level=str2double(get(handles.ed_tlev,'String'));

caldir=pwd;
try
    load([caldir '\calfiles\SR_calvals.mat'])
catch
    calvals.system=2;
    calvals.cal_level_left=99;
    calvals.cal_level_right=99;
    calvals.cal_atten=-20;
    calvals.system_name='Default';
    calvals.date=NaN;
end

handles.SR2vals.calvals=calvals;
handles.SR2vals.caltone_RMS=10^(calvals.cal_atten/20);


CRMdir='C:\wavFiles\CRMwaves\Talker';
load Kemar_CIPIC
handles.SR2vals.samplerate=44100;

% Set the random number generator to a unique state
rand('state',sum(100*clock))
randn('state',sum(100*clock))
f=CRM_resp_gui;
set(f,'Position',[270 40 130 33])
set(f,'Name','Response')
buttonhandles=guidata(f);


set(f,'UserData',[]);
set(buttonhandles.pb_start,'String','Start');
set(buttonhandles.pb_start,'Enable','on');
start=get(f,'UserData');
set(buttonhandles.tx_instructions,'String','Press Start to begin.')
while isempty(start)
    pause(.1)
    start=get(f,'UserData');
end
set(buttonhandles.pb_start,'String','');

target_level=handles.SR2vals.target_level*ones(1,20);
SNR=[10 10 8 8 6 6 4 4 2 2 0 0 -2 -2 -4 -4 -6 -6 -8 -8];
masker_level=target_level-SNR;
handles.SR2vals.masker_level=masker_level;
handles.SR2vals.SNR=SNR;

separation=handles.SR2vals.condition;
guidata(handles.figure1, handles);

running=get(handles.pb_go,'UserData');
trial=1;
set(handles.axes1,'NextPlot','replace')
while running
    set(handles.ed_mlev,'String',num2str(masker_level(trial)));
    
    twavs=[];m1wavs=[];m2wavs=[]; target=[];masker1=[]; masker2=[];
    ta=[];m1=[];m2=[];
    
    
    num=randperm(8)-1; col=randperm(4)-1;callsign=randperm(6);
    ttalker=randperm(3);
    target=[num2str(ttalker(1)) '\000' num2str(col(1)) '0' num2str(num(1)) '.wav'];
    masker1=[num2str(ttalker(2)) '\0' num2str(callsign(1)) '0' num2str(col(2)) '0' num2str(num(2)) '.wav'];
    masker2=[num2str(ttalker(3)) '\0' num2str(callsign(2)) '0' num2str(col(3)) '0' num2str(num(3)) '.wav'];
    
    ta=wavread([CRMdir target]);
    ta=ta.*(handles.SR2vals.RMS/std(ta));
    
    m1=wavread([CRMdir masker1]);
    m1=m1.*(handles.SR2vals.RMS/std(m1));
    
    m2=wavread([CRMdir masker2]);
    m2=m2.*(handles.SR2vals.RMS/std(m2));
    
    
    %   create a modulation / windowing function (an envelope)
    rampdur = 0.02; % 20 millisecond ramps
    rampsamps = ceil(rampdur.*handles.SR2vals.samplerate);
    ta_envelope = [cos(linspace(-pi/2,0,rampsamps)) ones(1,length(ta)-2*rampsamps) cos(linspace(0,pi/2,rampsamps))].^2;
    m1_envelope = [cos(linspace(-pi/2,0,rampsamps)) ones(1,length(m1)-2*rampsamps) cos(linspace(0,pi/2,rampsamps))].^2;
    m2_envelope = [cos(linspace(-pi/2,0,rampsamps)) ones(1,length(m2)-2*rampsamps) cos(linspace(0,pi/2,rampsamps))].^2;
    
    %   Modulate each signal
    ta=ta.*ta_envelope';
    m1=m1.*m1_envelope';
    m2=m2.*m2_envelope';
    
    handles.SR2vals.target_atten_LE=target_level(trial)-calvals.cal_level_left;
    handles.SR2vals.target_atten_RE=target_level(trial)-calvals.cal_level_right;
    
    handles.SR2vals.target_RMS.LE=handles.SR2vals.caltone_RMS*10^(handles.SR2vals.target_atten_LE/20);
    handles.SR2vals.target_RMS.RE=handles.SR2vals.caltone_RMS*10^(handles.SR2vals.target_atten_RE/20);
    
    handles.SR2vals.ampfactor.target.LE=handles.SR2vals.target_RMS.LE/handles.SR2vals.RMS;
    handles.SR2vals.ampfactor.target.RE=handles.SR2vals.target_RMS.RE/handles.SR2vals.RMS;
    
    handles.SR2vals.masker_atten_LE=masker_level(trial)-calvals.cal_level_left;
    handles.SR2vals.masker_atten_RE=masker_level(trial)-calvals.cal_level_right;
    
    handles.SR2vals.masker_RMS.LE=handles.SR2vals.caltone_RMS*10^(handles.SR2vals.masker_atten_LE/20);
    handles.SR2vals.masker_RMS.RE=handles.SR2vals.caltone_RMS*10^(handles.SR2vals.masker_atten_RE/20);
    
    handles.SR2vals.ampfactor.masker.LE=handles.SR2vals.masker_RMS.LE/handles.SR2vals.RMS;
    handles.SR2vals.ampfactor.masker.RE=handles.SR2vals.masker_RMS.RE/handles.SR2vals.RMS;
    

    tlen=length(ta); m1len=length(m1); m2len=length(m2);
    maxlen=max([tlen,m1len,m2len]);
    tbuff=maxlen-tlen; m1buff=maxlen-m1len; m2buff=maxlen-m2len;
    tzeros=zeros(tbuff,1); m1zeros=zeros(m1buff,1); m2zeros=zeros(m2buff,1);
    
    targ.LE=[ta; tzeros]*handles.SR2vals.ampfactor.target.LE; 
    targ.RE=[ta; tzeros]*handles.SR2vals.ampfactor.target.LE; 
    
    mask1.LE=[m1; m1zeros]*handles.SR2vals.ampfactor.masker.LE; 
    mask1.RE=[m1; m1zeros]*handles.SR2vals.ampfactor.masker.RE; 
    
    mask2.LE=[m2; m2zeros]*handles.SR2vals.ampfactor.masker.LE; 
    mask2.RE=[m2; m2zeros]*handles.SR2vals.ampfactor.masker.RE; 
    
    
    
    set(buttonhandles.tx_instructions,'String',['Trial ' num2str(trial)])
    set(handles.ed_trial,'String',num2str(trial))
    pause(.5)
    set(buttonhandles.tx_instructions,'String','')
    pause(.5)
    switch handles.SR2vals.condition
        case 0
            tIR=IR_0;
            m1IR=IR_0;
            m2IR=IR_0;
        case 15
            tIR=IR_0;
            m1IR=IR_n15;
            m2IR=IR_p15;
        case 30
            tIR=IR_0;
            m1IR=IR_n30;
            m2IR=IR_p30;
        case 45
            tIR=IR_0;
            m1IR=IR_n45;
            m2IR=IR_p45;
    end
    
    
  
        twavs(:,1) = conv(tIR(:,1),targ.LE);
        twavs(:,2) = conv(tIR(:,2),targ.RE);
        m1wavs(:,1) = conv(m1IR(:,1),mask1.LE);
        m1wavs(:,2) = conv(m1IR(:,2),mask1.RE);
        m2wavs(:,1) = conv(m2IR(:,1),mask2.LE);
        m2wavs(:,2) = conv(m2IR(:,2),mask2.RE);

    
    sig.left=twavs(:,1)+m1wavs(:,1)+m2wavs(:,1);
    sig.right=twavs(:,2)+m1wavs(:,2)+m2wavs(:,2);
    
    if calvals.system==1
        pa_wavplay([sig.left sig.right],handles.SR2vals.samplerate);
    else
        sound([sig.left sig.right],handles.SR2vals.samplerate,16);
        pause(length(sig.left)/handles.SR2vals.samplerate);
    end

    
    
    
    for n=1:32
        commandtext=['set(buttonhandles.pushbutton' num2str(n) ',''Enable'',''on'')'];
        eval(commandtext)
    end
    
    set(buttonhandles.tx_instructions,'String','What Color and Number?')
    set(f,'UserData',[]);
    
    mydata=get(f,'UserData');
    
    while isempty(mydata)
        pause(.1)
        mydata=get(f,'UserData');
        running=get(handles.pb_go,'UserData');
        if ~running
            set(buttonhandles.tx_instructions,'String','Thank you.  Please wait.')
            set(handles.pb_go,'String','Go')
            set(handles.pb_go,'BackgroundColor',[0 1 0.5])
            set(handles.pb_go,'Enable','on')
            set(handles.pb_stop,'Enable','off')
            guidata(handles.figure1, handles);
            return
        end
    end
    
    mydata.tlevel=target_level(trial);
    mydata.mlevel=masker_level(trial);
    mydata.SNR=SNR(trial);
    mydata.tcol=col(1);
    mydata.tnum=num(1);
    mydata.m1col=col(2);
    mydata.m1num=num(2);
    mydata.m2col=col(3);
    mydata.m2num=num(3);
    
    if mydata.color==col(1)
        mydata.colcorr=1;
    else
        mydata.colcorr=0;
    end
    
    if mydata.number==num(1)
        mydata.numcorr=1;
    else
        mydata.numcorr=0;
    end
    
    if mydata.numcorr+mydata.colcorr == 2
        mydata.correct=1;
        set(buttonhandles.tx_instructions,'String','Correct')
    else
        mydata.correct=0;
        set(buttonhandles.tx_instructions,'String','Incorrect.')
    end
    data{trial}=mydata;
    summary(trial)=data{trial}.correct;
    set(handles.ed_total,'String',num2str(sum(summary)))
    
    plot(handles.axes1,handles.SR2vals.SNR(1:2:trial)+.15,summary(1:2:trial),'ko')
    set(handles.axes1,'NextPlot','add')
    plot(handles.axes1,handles.SR2vals.SNR(2:2:trial)-.15,summary(2:2:trial),'k^')
    xlabel(handles.axes1,'SNR (dB)')
    %ylabel(handles.axes1,'Correct = 1; Incorrect = 0')
    set(handles.axes1,'YTick',[0 1])
    set(handles.axes1,'XTick',-10:2:12)
    set(handles.axes1,'YTickLabel',{'Incorrect','Correct'})
    axis(handles.axes1,[-9 11 -.1 1.1])
    
    pause(.5)
    
    
    trial=trial+1;
    if trial>20
        set(handles.pb_go,'UserData',0)
        handles.SR2vals.total_correct=sum(summary);
        handles.SR2vals.data=data;
        handles.SR2vals.summary=summary;
        SR2vals=handles.SR2vals;
        save(handles.SR2vals.file,'SR2vals')
        
        switch SR2vals.condition
            case 0
                set(handles.ed_colocated,'String',num2str(SR2vals.total_correct))
            case 15
                set(handles.ed_15degrees,'String',num2str(SR2vals.total_correct))
            case 30
                set(handles.ed_30degrees,'String',num2str(SR2vals.total_correct))
            case 45
                set(handles.ed_45degrees,'String',num2str(SR2vals.total_correct))
        end


            
            
            if ~exist('SR2summary.csv','file')
                fid=fopen('SR2summary.csv','w');
                
                fprintf(fid,'%s','Subject');
                fprintf(fid,', %s','Date');
                fprintf(fid,', %s','Spatial');
                fprintf(fid,', %s','Total Correct');
                fprintf(fid,', %s',num2str(SR2vals.SNR));
                fclose(fid);
                
            end
            
            fid=fopen('SR2summary.csv','a');
            fprintf(fid,'\n');
            fprintf(fid,'%s',SR2vals.subject);
            fprintf(fid,', %s',date);
            fprintf(fid,', %s',num2str(SR2vals.condition));
            fprintf(fid,', %s',num2str(SR2vals.total_correct));
            fprintf(fid,', %s',num2str(SR2vals.summary));
            
            fclose(fid);
            
    end
    running=get(handles.pb_go,'UserData');
end

set(buttonhandles.tx_instructions,'String','Thank you.  Please wait.')

set(handles.pb_go,'String','Saving')
set(handles.pb_go,'Enable','off')

fid=fopen([pwd '\data\' subject '\' subject '_SR2_summary.csv'],'w');

fdir = dir([homedir '\data\' subject '\' subject '_SR2.*']);

fprintf(fid,'%s','Subject');
fprintf(fid,', %s','Condition');
fprintf(fid,', %s','Total Correct');
fprintf(fid,', %s',num2str(SR2vals.SNR));

runs=length(fdir);
if runs
    for n=1:runs
        try
        load([homedir '\data\' subject '\' subject '_SR2.' num2str(n)],'-mat')
        fprintf(fid,'\n');
        fprintf(fid,'%s',SR2vals.subject);
        fprintf(fid,', %s',num2str(SR2vals.condition));
        fprintf(fid,', %s',num2str(SR2vals.total_correct));
        fprintf(fid,', %s',num2str(SR2vals.summary));
        end
    end
end

fclose(fid);


set(handles.pb_go,'String','Export Data')
set(handles.pb_go,'Enable','on')

set(handles.pb_go,'String','Go')
set(handles.pb_go,'BackgroundColor',[0 1 0.5])
set(handles.pb_go,'Enable','on')
set(handles.pb_stop,'Enable','off')
set(handles.pb_go,'UserData',0)
guidata(handles.figure1, handles);

function ed_subjnum_Callback(hObject, eventdata, handles)
% hObject    handle to ed_subjnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_subjnum as text
%        str2double(get(hObject,'String')) returns contents of ed_subjnum as a double


% --- Executes during object creation, after setting all properties.
function ed_subjnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_subjnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pb_go,'String','Go')
set(handles.pb_go,'BackgroundColor',[0 1 0.5])
set(handles.pb_go,'Enable','on')
set(handles.pb_stop,'Enable','off')
set(handles.pb_go,'UserData',0)

% --- Executes on button press in pb_done.
function pb_done_Callback(hObject, eventdata, handles)
% hObject    handle to pb_done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f=CRM_resp_gui;
close(f);

close(handles.figure1);
% --- Executes on button press in rb_0.
function rb_0_Callback(hObject, eventdata, handles)
% hObject    handle to rb_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_0
set(handles.rb_15,'Value',0)
set(handles.rb_30,'Value',0)
set(handles.rb_45,'Value',0)
handles.condition=0;
guidata(hObject, handles);

set(handles.pb_go,'String','Go')
set(handles.pb_go,'BackgroundColor',[0 1 .5])
set(handles.pb_go,'Enable','on')

% --- Executes on button press in rb_15.
function rb_15_Callback(hObject, eventdata, handles)
% hObject    handle to rb_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_15
set(handles.rb_0,'Value',0)
set(handles.rb_30,'Value',0)
set(handles.rb_45,'Value',0)
handles.condition=15;
guidata(hObject, handles);

set(handles.pb_go,'String','Go')
set(handles.pb_go,'BackgroundColor',[0 1 .5])
set(handles.pb_go,'Enable','on')

% --- Executes on button press in rb_30.
function rb_30_Callback(hObject, eventdata, handles)
% hObject    handle to rb_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_30
set(handles.rb_0,'Value',0)
set(handles.rb_15,'Value',0)
set(handles.rb_45,'Value',0)
handles.condition=30;
guidata(hObject, handles);

set(handles.pb_go,'String','Go')
set(handles.pb_go,'BackgroundColor',[0 1 .5])
set(handles.pb_go,'Enable','on')

% --- Executes on button press in rb_45.
function rb_45_Callback(hObject, eventdata, handles)
% hObject    handle to rb_45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_45
set(handles.rb_0,'Value',0)
set(handles.rb_15,'Value',0)
set(handles.rb_30,'Value',0)
handles.condition=45;
guidata(hObject, handles);

set(handles.pb_go,'String','Go')
set(handles.pb_go,'BackgroundColor',[0 1 .5])
set(handles.pb_go,'Enable','on')


function ed_mlev_Callback(hObject, eventdata, handles)
% hObject    handle to ed_mlev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_mlev as text
%        str2double(get(hObject,'String')) returns contents of ed_mlev as a double


% --- Executes during object creation, after setting all properties.
function ed_mlev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_mlev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_tlev_Callback(hObject, eventdata, handles)
% hObject    handle to ed_tlev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_tlev as text
%        str2double(get(hObject,'String')) returns contents of ed_tlev as a double


% --- Executes during object creation, after setting all properties.
function ed_tlev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_tlev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_trial_Callback(hObject, eventdata, handles)
% hObject    handle to ed_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_trial as text
%        str2double(get(hObject,'String')) returns contents of ed_trial as a double


% --- Executes during object creation, after setting all properties.
function ed_trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_correct_Callback(hObject, eventdata, handles)
% hObject    handle to ed_correct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_correct as text
%        str2double(get(hObject,'String')) returns contents of ed_correct as a double


% --- Executes during object creation, after setting all properties.
function ed_correct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_correct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_total_Callback(hObject, eventdata, handles)
% hObject    handle to ed_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_total as text
%        str2double(get(hObject,'String')) returns contents of ed_total as a double


% --- Executes during object creation, after setting all properties.
function ed_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_RE_SRT_Callback(hObject, eventdata, handles)
% hObject    handle to ed_RE_SRT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_RE_SRT as text
%        str2double(get(hObject,'String')) returns contents of ed_RE_SRT as a double


% --- Executes during object creation, after setting all properties.
function ed_RE_SRT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_RE_SRT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_LE_SRT_Callback(hObject, eventdata, handles)
% hObject    handle to ed_LE_SRT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_LE_SRT as text
%        str2double(get(hObject,'String')) returns contents of ed_LE_SRT as a double


% --- Executes during object creation, after setting all properties.
function ed_LE_SRT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_LE_SRT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_cal_date_Callback(hObject, eventdata, handles)
% hObject    handle to ed_cal_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_cal_date as text
%        str2double(get(hObject,'String')) returns contents of ed_cal_date as a double


% --- Executes during object creation, after setting all properties.
function ed_cal_date_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_cal_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_cal.
function pb_cal_Callback(hObject, eventdata, handles)
% hObject    handle to pb_cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject,'Enable','off')
calvals = go_calibrate(handles);
set(handles.ed_cal_date,'String',calvals.date)
set(hObject,'Enable','on')


function calvals = go_calibrate(handles)
% play three-second long tone  and save the RMS values

caldir=pwd;
calfile=[caldir '\calfiles\SR_calvals.mat'];

if ~exist([caldir '\calfiles'],'dir')
    eval(['mkdir ' caldir '\calfiles'])
end

if exist(calfile,'file')
    load([caldir '\calfiles\SR_calvals.mat'])
    calvals.previous_cal_level_left=calvals.cal_level_left;
    calvals.previous_cal_level_right=calvals.cal_level_left;

    % Construct a questdlg with three options
    ovrwrt = questdlg('Calibration file exists.  Overwrite?','Calibration File Exists','Yes','No','No');
    if strcmp(ovrwrt,'No')
        load([caldir '\calfiles\SR_calvals.mat'])
        return
    end
    D=dir([caldir '\calfiles\SR_calvals_old*']);
    numfiles=size(D,1);
    fname2 = [caldir '\calfiles\SR_calvals_old_' num2str(numfiles+1) '.mat'];
    copyfile(calfile,fname2);
    else
        calvals.previous_cal_level_left=0;
    calvals.previous_cal_level_right=0;
end

calvals.date=date;
calvals.directory=pwd;
calvals.cal_freq=1000;
calvals.cal_level_left=-99;
calvals.cal_level_right=-99;
calvals.cal_atten=-20;
tone=makeCalTone(calvals.cal_freq, 44100, 3, calvals.cal_atten, 0,.005);   
silence=zeros(size(tone.wave));
            
isasio=questdlg('Does sound generation system use ASIO Drivers?','Sound System','Yes','No','Unsure','Yes');

if strcmp(isasio,'Yes')
    sname=inputdlg('Enter System name:','Name System',1,{'ASIO Soundcard'});
    calvals.system_name=sname{1};
    calvals.system=1;
    calvals.driver='asio';
elseif strcmp(isasio,'No')
    sname=inputdlg('Enter System name:','Name System',1,{'Windows Soundcard'});
    calvals.system=2;
    calvals.system_name=sname{1};
    calvals.driver='win';
elseif strcmp(isasio,'Unsure')
    checkasio=questdlg('Check to see if sound generation system supports greater ASIO Drivers?','Sound System','Yes','No','Yes');
    if strcmp(checkasio,'Yes')
        h=warndlg('Click Ok and then listen for a 1000 Hz tone.','Tone Will Play');
        uiwait(h)
        pause(.1)
        pa_wavplay([tone.wave' tone.wave'],tone.sampling_rate,'asio');
        useasio=questdlg('Was a sound presented?','Sound System','Yes','No','Yes');
        if strcmp(useasio,'Yes')
            sname=inputdlg('Enter System name:','Name System',1,{'ASIO Soundcard'});
            calvals.system_name=sname{1};
            calvals.system=1;
            calvals.driver='asio';
        elseif strcmp(useasio,'No')
            sname=inputdlg('Enter System name:','Name System',1,{'Windows Soundcard'});
            calvals.system=2;
            calvals.system_name=sname{1};
            calvals.driver='win';
        end
    else
        warndlg('System will use Windows drivers. Redo calibration to reset.')
            sname=inputdlg('Enter System name:','Name System',1,{'Windows Soundcard'});
            calvals.system=2;
            calvals.system_name=sname{1};
            calvals.driver='win';
    end
end



for side=1:2
    if side==1
        while calvals.cal_level_left==-99
%             set(handles.tx_comment,'String',['Now playing ' num2str(calvals.cal_freq) ' Hz tone on left channel at 44100 Hz.'])
            pause(.5)
            tone=makeCalTone(calvals.cal_freq, 44100, 3, calvals.cal_atten, 0,.005);
            silence=zeros(size(tone.wave));
            if calvals.system==1
                pa_wavplay([tone.wave' silence'],tone.sampling_rate);
            else
                sound([tone.wave' silence'],tone.sampling_rate,16);
            end
%             set(handles.tx_comment,'String','')
            level=[];
            qstring=['Enter dB SPL reading for LEFT CHANNEL (enter -99 to play again)         Previous level was ' num2str(calvals.previous_cal_level_left) ': '];
            level = inputdlg(qstring,'Calibration Level (dB)',1,{'-99'});
           
            
            try
                calvals.cal_level_left =str2num(level{1});
            catch
                calvals.cal_level_left = -99;
            end
            
        end
        
        
    else
        
        
        while calvals.cal_level_right==-99
%             set(handles.tx_comment,'String',['Now playing ' num2str(calvals.cal_freq) ' Hz tone on right channel at 44100 Hz.'])
            pause(.5)
            tone=makeCalTone(calvals.cal_freq, 44100, 3, calvals.cal_atten, 0,.005);
            silence=zeros(size(tone.wave));
            if calvals.system==1
                pa_wavplay([silence' tone.wave'],tone.sampling_rate);
            else
                sound([silence' tone.wave'],tone.sampling_rate,16);
            end
%             set(handles.tx_comment,'String','')
            level=[];
            qstring=['Enter dB SPL reading for RIGHT CHANNEL (enter -99 to play again)         Previous level was ' num2str(calvals.previous_cal_level_right) ': '];
            level = inputdlg(qstring,'Calibration Level (dB)',1,{'-99'});
            
            try
                calvals.cal_level_right =str2num(level{1});
            catch
                calvals.cal_level_right =-99;
            end
            
        end
    end
    
end



save([caldir '\calfiles\SR_calvals.mat'],'calvals')

function s=makeCalTone(frequency, sampling_rate, duration, amplitude, phase, onoff_ramp)
% s=makeCalTone(frequency, sampling_rate, duration, amplitude, phase)
%   frequency: in Hz (e.g., 1000); a vector creates a tone complex
%   sampling_rate: in Hz (e.g., 48000)
%   duration: in seconds (e.g., 1)
%   amplitude: in decibels re: maximum (e.g., -30)
%   phase: in radians, between 0 and 2*pi (e.g., pi)
%   onofframp: in seconds (e.g., .01)

s.frequency=frequency;
s.sampling_rate=sampling_rate;
s.duration=duration;
s.amplitude=amplitude;
s.phase=phase;

%determine the signal length in samples and create a vector (x) of the right length to hold it
x=1:ceil(duration.*sampling_rate);
final_tone=zeros(1,length(x));

for n=1:length(frequency)
    %generate a sine wave
    tone=sin((2*pi*(frequency(n)/sampling_rate).*x)+phase);
    % create a windowing function (an envelope)
    rampdur = onoff_ramp;
    rampsamps = ceil(rampdur.*sampling_rate);
    envelope = [cos(linspace(-pi/2,0,rampsamps)) ones(1,ceil(duration.*sampling_rate)-2*rampsamps) cos(linspace(0,pi/2,rampsamps))].^2;
    tone=tone.*envelope;
    final_tone=final_tone+tone;
end

%set the RMS level of the signal to the specified amplitude in dB
toneRMS=sqrt(mean(final_tone.^2));
amp=10^(amplitude/20);
ampdiff=amp/toneRMS;


s.wave=final_tone.*ampdiff;


function ed_15degrees_Callback(hObject, eventdata, handles)
% hObject    handle to ed_15degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_15degrees as text
%        str2double(get(hObject,'String')) returns contents of ed_15degrees as a double


% --- Executes during object creation, after setting all properties.
function ed_15degrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_15degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_30degrees_Callback(hObject, eventdata, handles)
% hObject    handle to ed_30degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_30degrees as text
%        str2double(get(hObject,'String')) returns contents of ed_30degrees as a double


% --- Executes during object creation, after setting all properties.
function ed_30degrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_30degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_45degrees_Callback(hObject, eventdata, handles)
% hObject    handle to ed_45degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_45degrees as text
%        str2double(get(hObject,'String')) returns contents of ed_45degrees as a double


% --- Executes during object creation, after setting all properties.
function ed_45degrees_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_45degrees (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_colocated_Callback(hObject, eventdata, handles)
% hObject    handle to ed_colocated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_colocated as text
%        str2double(get(hObject,'String')) returns contents of ed_colocated as a double


% --- Executes during object creation, after setting all properties.
function ed_colocated_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_colocated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
