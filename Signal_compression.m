function varargout = Signal_compression(varargin)
% SIGNAL_COMPRESSION MATLAB code for Signal_compression.fig
%      SIGNAL_COMPRESSION, by itself, creates a new SIGNAL_COMPRESSION or raises the existing
%      singleton*.
%
%      H = SIGNAL_COMPRESSION returns the handle to a new SIGNAL_COMPRESSION or the handle to
%      the existing singleton*.
%
%      SIGNAL_COMPRESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNAL_COMPRESSION.M with the given input arguments.
%
%      SIGNAL_COMPRESSION('Property','Value',...) creates a new SIGNAL_COMPRESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Signal_compression_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Signal_compression_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Signal_compression

% Last Modified by GUIDE v2.5 18-Mar-2019 11:05:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Signal_compression_OpeningFcn, ...
                   'gui_OutputFcn',  @Signal_compression_OutputFcn, ...
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


% --- Executes just before Signal_compression is made visible.
function Signal_compression_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Signal_compression (see VARARGIN)

% Choose default command line output for Signal_compression
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Signal_compression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Signal_compression_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse_btn2.
function Browse_btn2_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_btn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
%global Sig_RLE_Lossless
global Sig_Irle_Lossless1
global Sig_Irle_Lossless2
global Sig_Irle_Lossless
global Sig_Irle_Lossy
global Sig_Irle_Lossy1
global Sig_Irle_Lossy2
global d
global ibasis
global y
d=0;
[filename,pathname] = uigetfile('*.mat', 'Select a file');
    handles.fullpathname = strcat(pathname, filename);
    y=dir(strcat(pathname,filename));
    y.bytes
    fullFileName = fullfile(pathname, filename);
    [pathname, filename, extension] = fileparts(fullFileName);
    
    
    if strcmpi(filename, 'lossless')
    load(handles.fullpathname)
    if  ibasis==2
    Sig_RLE_Lossless1
    Sig_RLE_Lossless2
    Sig_Irle_Lossless1=irle(Sig_RLE_Lossless1);
    Sig_Irle_Lossless2=irle(Sig_RLE_Lossless2);
    else 
         Sig_RLE_Lossless
    Sig_Irle_Lossless=irle(Sig_RLE_Lossless);
    end
    end 
    if strcmpi(filename, 'lossy')
    load(handles.fullpathname)
     if  ibasis==2
      Sig_RLE_Lossy1
      Sig_RLE_Lossy2
    Sig_Irle_Lossy1=irle(Sig_RLE_Lossy1);
    Sig_Irle_Lossy2=irle(Sig_RLE_Lossy2);
    else 
    Sig_Irle_Lossy=irle(Sig_RLE_Lossy);
     end
    end
    
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in Decomp_Lossless_btn.
function Decomp_Lossless_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Decomp_Lossless_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Sig_Irle_Lossless
global Sig_Irle_Lossless1
global Sig_Irle_Lossless2
global result_sig
global ibasis
global l
global a
global u
global y
%ratio1=(((u.bytes-y.bytes)/u.bytes)*100);
%set(handles.text1, 'String', num2str(ratio1));
Q=8;% 1 byte (value representation)
if ibasis==1 
ibasis;
Max_Sig=max(abs(result_sig));
Min_Sig=min(abs(result_sig));
Sig_IQuant_Lossless=((Max_Sig-Min_Sig)/(-1+2^Q))*Sig_Irle_Lossless+Min_Sig;% Inverse Quantization
Rec_Sig_Lossless=ifft(Sig_IQuant_Lossless);
w=a';
elseif  ibasis==2

 cA=result_sig(:,1);
 cD=result_sig(:,2);
Max_Sig1=max(cA);
Min_Sig1=min(cA);
Max_Sig2=max(cD);
Min_Sig2=min(cD);
Sig_IQuant_Lossless1=((Max_Sig1-Min_Sig1)/(-1+2^Q))*Sig_Irle_Lossless1+Min_Sig1;% Inverse Quantization
Sig_IQuant_Lossless2=((Max_Sig2-Min_Sig2)/(-1+2^Q))*Sig_Irle_Lossless2+Min_Sig2;% Inverse Quantization
Rec_Sig_Lossless=idwt(Sig_IQuant_Lossless1,Sig_IQuant_Lossless2,'sym1');%compressed Signal
size(Rec_Sig_Lossless(:,1:l))
w=a'; 
elseif  ibasis==3
    Max_Sig=max(result_sig);
    Min_Sig=min(result_sig);
    Sig_IQuant_Lossless=((Max_Sig-Min_Sig)/(-1+2^Q))*Sig_Irle_Lossless+Min_Sig;% Inverse Quantization
    Rec_Sig_Lossless=idct(Sig_IQuant_Lossless);%compressed Signal
    w=a';
elseif  ibasis==4
    Max_Sig=max((result_sig));
    Min_Sig=min(result_sig);
    Sig_IQuant_Lossless=((Max_Sig-Min_Sig)/(-1+2^Q))*Sig_Irle_Lossless+Min_Sig;% Inverse Quantization
    Rec_Sig_Lossless=ifwht(Sig_IQuant_Lossless);%compressed Signal
    w=a';
end
axes(handles.axes3)
plot(Rec_Sig_Lossless(:,1:l));
message = sprintf('done');
uiwait(warndlg(message));
error1=w-Rec_Sig_Lossless(:,1:l);
axes(handles.axes2)
plot(error1,'r')
ratio=((abs(u.bytes - y.bytes)/u.bytes)*100);
set(handles.text1, 'String', num2str(ratio)); 


% --- Executes on button press in Browse_btn.
function Browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axes4)

numberOfTries = 0;
global a
global l
global type 
global u
a=0;
cla(handles.axes1)
axes(handles.axes1)
while numberOfTries < 20  % Failsafe
    % Get the name of the file that the user wants to use.
    [filename,pathname] = uigetfile('*.mat; *.wav; *.csv', 'Select a file');
    handles.fullpathname = strcat(pathname, filename);
    u=dir(strcat(pathname, filename));
    u.bytes
    
    if filename == 0 % User clicked the Cancel button.
        break; 
    end
    fullFileName = fullfile(pathname, filename);
    [pathname, filename, extension] = fileparts(fullFileName);
    if strcmpi(extension, '.wav') || strcmpi(extension, '.mp3') %audio
        [A, handles.Fs] = audioread(handles.fullpathname);
        a = A(:,1);
        plot(a);
        type=1;

        break; % out of while loop
    elseif strcmpi(extension, '.mat') %mat
        if strcmpi(filename, 'ult_sig');
            g=load(handles.fullpathname);
            a=g.ult_sig;
            plot(a);
            type=3;
        elseif strcmpi(filename, 'mr');
            load(handles.fullpathname);
            a=VarName1;
            plot(a);
            type=4;
        else
        load(handles.fullpathname);
        a=val(:);
        plot(a);
        type=2;
        end
        break;
        
    elseif strcmpi(extension, '.csv')
        data= csvread (handles.fullpathname) ;
        t = data (: , 1 );
        a =data (: , 2 ) ;
        plot(a);
        type=2
        break;
    else
        message = sprintf('Error: you must pick (.mat, .csv, .wav or .mp3) file, not a "%s" file.', extension);
        uiwait(warndlg(message));
    end 

end
l=length(a);
l
set(handles.edit1,'string',filename);

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
value = get(hObject,'Value');
global a
global l
global result_sig

global ibasis

axes(handles.axes2)
% Set current data to the selected data set.
switch str{value};
case 'FFT' % User selects peaks.
   fft_Sig=fft(a);
    ibasis=1;
   result_sig=fft_Sig;
   %plot(abs(fft_Sig));
case 'DWT' % User selects membrane.
   [cA,cD] = dwt(a,'sym1');
   ibasis=2;
   result_sig=[cA,cD];
   %result_sig
   %plot([cA,cD]);
case 'DCT' % User selects sinc.
  dct_Sig=dct(a);
   ibasis=3;
  result_sig=dct_Sig;
  %axes(handles.axes2)
  %plot(dct_Sig)
case 'FWHT' % User selects sinc.
   fwht_S=fwht(a);%Discrete Cosin Transform of signal
   result_sig=fwht_S;
   ibasis=4;
   %fwht_Sig=fwht_S(1:l);
   %plot(fwht_S);
end
% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Compress_Lossless.
function Compress_Lossless_Callback(hObject, eventdata, handles)
% hObject    handle to Compress_Lossless (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global result_sig
global p
global Sig_RLE_Lossless
global ibasis
%global Sig_RLE_Lossless

Q=8;% 1 byte (value representation)
if ibasis==1 
Max_Sig=max(abs(result_sig));
Min_Sig=min(abs(result_sig));
Sig_Quant_Lossless=round((-1+2^Q)*(result_sig-Min_Sig)/(Max_Sig-Min_Sig));
%-------------------------- Run Length Codising --------------------------%
Sig_RLE_Lossless=rle(Sig_Quant_Lossless);
%CR_lossless=length(result_sig)/(length(Sig_RLE_Lossless)+2);%Compression Ratio
p=Sig_RLE_Lossless;
save lossless.mat Sig_RLE_Lossless
elseif  ibasis==2
    l=length(result_sig);

    cA=result_sig(:,1);
    cD=result_sig(:,2);
 
Max_Sig1=max(cA);
Min_Sig1=min(cA);
Max_Sig2=max(cD);
Min_Sig2=min(cD);
Sig_Quant_Lossless1=round((-1+2^Q)*(cA-Min_Sig1)/(Max_Sig1-Min_Sig1));
Sig_Quant_Lossless2=round((-1+2^Q)*(cD-Min_Sig2)/(Max_Sig2-Min_Sig2));
%-------------------------- Run Length Codising --------------------------%
Sig_RLE_Lossless1=rle(Sig_Quant_Lossless1);
Sig_RLE_Lossless2=rle(Sig_Quant_Lossless2);
%CR_lossless=length(result_sig)/(length(Sig_RLE_Lossless)+2);%Compression Ratio
save ('lossless.mat' ,'Sig_RLE_Lossless1','Sig_RLE_Lossless2');
elseif  ibasis==3
    Max_Sig=max((result_sig));
    Min_Sig=min(result_sig);
    Sig_Quant_Lossless=round((-1+2^Q)*(result_sig-Min_Sig)/(Max_Sig-Min_Sig));
    %-------------------------- Run Length Codising --------------------------%
Sig_RLE_Lossless=rle(Sig_Quant_Lossless);
%CR_lossless=length(result_sig)/(length(Sig_RLE_Lossless)+2);%Compression Ratio
p=Sig_RLE_Lossless;
save lossless.mat Sig_RLE_Lossless
elseif  ibasis==4
Max_Sig=max((result_sig));
    Min_Sig=min(result_sig);
    Sig_Quant_Lossless=round((-1+2^Q)*(result_sig-Min_Sig)/(Max_Sig-Min_Sig));
   %-------------------------- Run Length Codising --------------------------%
Sig_RLE_Lossless=rle(Sig_Quant_Lossless);
%CR_lossless=length(result_sig)/(length(Sig_RLE_Lossless)+2);%Compression Ratio
p=Sig_RLE_Lossless;
save lossless.mat Sig_RLE_Lossless 

end
message = sprintf('done  , saved');
uiwait(warndlg(message));




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on button press in Decomp_lossy_btn.
function Decomp_lossy_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Decomp_lossy_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Sig_Irle_Lossy
global Sig_Irle_Lossy1
global Sig_Irle_Lossy2
global ibasis
global Signal_Lossy
global Signal_Lossy1
global Signal_Lossy2
global Sig_RLE_Lossy
global l
global a 
global u
global y
Q=8;% 1 byte (value representation)
if ibasis==1 
    Max_SigAfter=max(abs(Signal_Lossy));
    Min_SigAfter=min(abs(Signal_Lossy));
    Sig_IQuant=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle_Lossy+Min_SigAfter;% Inverse Quantization
    Rec_Sig_Lossy=ifft(Sig_IQuant);
    e=a';
elseif  ibasis==2
    Max_SigAfter1=max(Signal_Lossy1);
    Min_SigAfter1=min(Signal_Lossy1);
    Max_SigAfter2=max(Signal_Lossy2);
    Min_SigAfter2=min(Signal_Lossy2);
    Sig_IQuant1=((Max_SigAfter1-Min_SigAfter1)/(-1+2^Q))*Sig_Irle_Lossy1+Min_SigAfter1;% Inverse Quantization
    Sig_IQuant2=((Max_SigAfter2-Min_SigAfter2)/(-1+2^Q))*Sig_Irle_Lossy2+Min_SigAfter2;% Inverse Quantization
    Rec_Sig_Lossy=idwt(Sig_IQuant1,Sig_IQuant2,'sym1');
    e=a';
elseif  ibasis==3
    Max_SigAfter=max(Signal_Lossy);
    Min_SigAfter=min(Signal_Lossy);
    Sig_IQuant=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle_Lossy+Min_SigAfter;% Inverse Quantization
    Rec_Sig_Lossy=idct(Sig_IQuant);
    e=a';
    size(e)
    size(Rec_Sig_Lossy)
elseif  ibasis==4
    Max_SigAfter=max(Signal_Lossy);
    Min_SigAfter=min(Signal_Lossy);
    Sig_IQuant=((Max_SigAfter-Min_SigAfter)/(-1+2^Q))*Sig_Irle_Lossy+Min_SigAfter;% Inverse Quantization
    Rec_Sig_Lossy=ifwht(Sig_IQuant);
    e=a';
    
end
axes(handles.axes4)
plot(Rec_Sig_Lossy(:,1:l));
message = sprintf('done');
uiwait(warndlg(message));
error2=e-Rec_Sig_Lossy(:,1:l);
axes(handles.axes2)
plot(error2,'g');
ratio=((abs(u.bytes - y.bytes)/u.bytes)*100);
set(handles.text1, 'String', num2str(ratio)); 

% --- Executes on button press in Comp_Lossy.
function Comp_Lossy_Callback(hObject, eventdata, handles)
% hObject    handle to Comp_Lossy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global result_sig
global type
global Signal_Lossy
global Signal_Lossy1
global Signal_Lossy2
%%%%%%%%%%%%%%%%%%%%%%%%% Lossy %%%%%%%%%%%%%%%%%% Figure2
%-------------------------- Thresholding For lossy -------------------------%
global ibasis
global Sig_RLE_Lossy

[S_sorted, k] = sort(abs(result_sig)); %sorting data 
 if type==1;
 M = 2000;
 elseif type==2
    M = 500;
 elseif type==3
    M = 2000;
 elseif type==4
     M = 200;
 end  
Signal_Lossy = result_sig;
%-------------------------- Quantization For lossy ------------------------%
Q=8;% 1 byte (value representation)
if ibasis==1 
Signal_Lossy(k(1:M)) = 0;
Max_SigAfter=max(abs(Signal_Lossy));
Min_SigAfter=min(abs(Signal_Lossy));
Sig_Quant_Lossy=round((-1+2^Q)*(Signal_Lossy-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE_Lossy=rle(Sig_Quant_Lossy);
%CR_Lossy=length(Signal_Lossy)/(length(Sig_RLE_Lossy)+2);%Compression Ratio
z=Sig_RLE_Lossy;
save ('lossy.mat' ,'Sig_RLE_Lossy')
elseif  ibasis==2
Signal_Lossy1=result_sig(:,1);
Signal_Lossy2=result_sig(:,2);
Signal_Lossy1(k(1:M/2)) = 0;
Signal_Lossy2(k(1:M/2)) = 0;
Max_SigAfter1=max(Signal_Lossy1);
Min_SigAfter1=min(Signal_Lossy1);
Max_SigAfter2=max(Signal_Lossy2);
Min_SigAfter2=min(Signal_Lossy2);
Sig_Quant_Lossy1=round((-1+2^Q)*(Signal_Lossy1-Min_SigAfter1)/(Max_SigAfter1-Min_SigAfter1));
Sig_Quant_Lossy2=round((-1+2^Q)*(Signal_Lossy2-Min_SigAfter2)/(Max_SigAfter2-Min_SigAfter2));
Sig_RLE_Lossy1=rle(Sig_Quant_Lossy1);
Sig_RLE_Lossy2=rle(Sig_Quant_Lossy2);
%CR_Lossy=length(Signal_Lossy)/(length(Sig_RLE_Lossy)+2);%Compression Ratio
save('lossy.mat','Sig_RLE_Lossy1','Sig_RLE_Lossy2')
  
elseif  ibasis==3
   Max_SigAfter=max(Signal_Lossy);
Min_SigAfter=min(Signal_Lossy);
Sig_Quant_Lossy=round((-1+2^Q)*(Signal_Lossy-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE_Lossy=rle(Sig_Quant_Lossy);
%CR_Lossy=length(Signal_Lossy)/(length(Sig_RLE_Lossy)+2);%Compression Ratio
z=Sig_RLE_Lossy;
save lossy.mat Sig_RLE_Lossy   
elseif  ibasis==4
Max_SigAfter=max(Signal_Lossy);
Min_SigAfter=min(Signal_Lossy);
Sig_Quant_Lossy=round((-1+2^Q)*(Signal_Lossy-Min_SigAfter)/(Max_SigAfter-Min_SigAfter));
Sig_RLE_Lossy=rle(Sig_Quant_Lossy);
%CR_Lossy=length(Signal_Lossy)/(length(Sig_RLE_Lossy)+2);%Compression Ratio
z=Sig_RLE_Lossy;
save lossy.mat Sig_RLE_Lossy  

end



message = sprintf('done, saved');
% compressed=dir('lossy2.mat');
% original=(handles.fullpathname )
% CR_lossy=(original.bytes/compressed.bytes);
uiwait(warndlg(message));
