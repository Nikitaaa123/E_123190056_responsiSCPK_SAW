function varargout = SAW_123190056_Nikita(varargin)
% SAW_123190056_NIKITA MATLAB code for SAW_123190056_Nikita.fig
%      SAW_123190056_NIKITA, by itself, creates a new SAW_123190056_NIKITA or raises the existing
%      singleton*.
%
%      H = SAW_123190056_NIKITA returns the handle to a new SAW_123190056_NIKITA or the handle to
%      the existing singleton*.
%
%      SAW_123190056_NIKITA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_123190056_NIKITA.M with the given input arguments.
%
%      SAW_123190056_NIKITA('Property','Value',...) creates a new SAW_123190056_NIKITA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_123190056_Nikita_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_123190056_Nikita_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW_123190056_Nikita

% Last Modified by GUIDE v2.5 26-Jun-2021 01:27:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_123190056_Nikita_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_123190056_Nikita_OutputFcn, ...
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


% --- Executes just before SAW_123190056_Nikita is made visible.
function SAW_123190056_Nikita_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW_123190056_Nikita (see VARARGIN)

% Choose default command line output for SAW_123190056_Nikita
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW_123190056_Nikita wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_123190056_Nikita_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton1.

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = ([1,3:8]);
data = readtable('DATA RUMAH.xlsx',opts);
dataa = table2cell(data);
set(handles.uitable1,'data',dataa);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1,'data','');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3:8); %mengambil data dari dataset kolom 3-8
data = readtable('DATA RUMAH.xlsx', opts);%input data berdasarkan kriteria
input = table2cell(data);
x = table2array(data); %input data berdasarkan kriteria

k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut negatif &1= atribut positif

w=[0.3,0.2,0.23,0.10,0.07,0.10];%bobot untuk masing-masing kriteria

%menampilkan data
disp ('nilai input x =')
disp (input)

%normalisasi matriks
[m n] = size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R = zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y = zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j) = x(:,j)./max(x(:,j));
    else %statement untuk kriteria dengan atribut biaya
        R(:,j) = min(x(:,j))./x(:,j);
    end;
end;

%menampilkan matriks yang sudah ternormalisasi
disp ('matriks yang sudah ternormalisasi R =')
disp (R)

%tahapan kedua, proses perangkingan
for i=1:m,
    V(i) = sum(w.*R(i,:));
end;

%mencari nilai 20 teratas
opts1 = detectImportOptions('DATA RUMAH.xlsx');
opts1.SelectedVariableNames = ([1,3:8]); %mengambil data yang diperlukan
data1 = readtable('DATA RUMAH.xlsx', opts1); %membaca tabel
input1 = table2cell(data1);

%proses mengurutkan
V = V.';
V = num2cell(V);
hasil = {input1; V};
hasil = horzcat(hasil{:});
hasilsort = sortrows(hasil, 8, 'descend');
ranked = hasilsort(1:20,:);

%tampilan hasil
disp('Hasil perangkingan 20 teratas =');disp(ranked);
set(handles.uitable4,'Data',ranked);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable4,'data',''); %menghapus data hasil yang ditampilkan
