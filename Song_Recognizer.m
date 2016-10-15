function varargout = Song_Recognizer(varargin)
% SONG_RECOGNIZER MATLAB code for Song_Recognizer.fig
%      SONG_RECOGNIZER, by itself, creates a new SONG_RECOGNIZER or raises the existing
%      singleton*.
%
%      H = SONG_RECOGNIZER returns the handle to a new SONG_RECOGNIZER or the handle to
%      the existing singleton*.
%
%      SONG_RECOGNIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SONG_RECOGNIZER.M with the given input arguments.
%
%      SONG_RECOGNIZER('Property','Value',...) creates a new SONG_RECOGNIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Song_Recognizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Song_Recognizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Song_Recognizer

% Last Modified by GUIDE v2.5 18-Sep-2015 21:45:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Song_Recognizer_OpeningFcn, ...
                   'gui_OutputFcn',  @Song_Recognizer_OutputFcn, ...
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


% --- Executes just before Song_Recognizer is made visible.
function Song_Recognizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Song_Recognizer (see VARARGIN)

% Choose default command line output for Song_Recognizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Song_Recognizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Song_Recognizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
set(handles.pushbutton1,'string','Listening...','enable','off');
set(handles.text4,'string','','enable','on');
recObj = audiorecorder(44100,16,1)
disp('Start speaking.')
recordblocking(recObj,2);
disp('End of Recording.');
play(recObj);
y = getaudiodata(recObj);
load('song_data.mat');
start=1;
d=[];
y= downsample(y,10);% get the first channel
ymax = max(abs(y));% find the maximum value
y = y/ymax; 
for i=1:length(song_length)
    stop=start+song_length(i)-1;
    temp=song(start:stop);
    start=stop+1;
    cor = xcorr(temp,y);
    m = max(cor);
    d = [d m];
end
d
[value,loc]=max(d);
fid = fopen('all_song_name.txt');
tline = fgets(fid);
i=1;
while ischar(tline)
    if(i==loc)
        set(handles.pushbutton1,'string','Play Music','enable','on');
        set(handles.text4,'string',strcat('Song Name : ',tline),'enable','on');
        break;
    end
    i=i+1;
    tline = fgets(fid);
end
fclose(fid);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
pushbutton1
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
