%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
% !!!!!!!!! Read me before using !!!!!!!!!!                              %
% By using this freeware, you are agree to the following:                %
% 1. you are free to copy and redistribute the material in any format;   %
% 2. you are free to remix, transform, and build upon the material for   %
%    any purpose, even commercially;                                     %
% 3. you must provide the name of the creator and attribution parties,   %
%    a copyright notice, a license notice, a disclaimer notice, and a    % 
%    link to the material (https://github.com/maozirui/diffusion.FDM.1D);%
% 4. users are entirely at their own risk using this freeware.           %
%                                                                        %
% Before use, please read the License carefully:                         %
% <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">   %
% <img alt="Creative Commons License" style="border-width:0"             %
% src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />    %
% This work is licensed under a                                          %
% <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">   %
% Creative Commons Attribution 4.0 International License</a>.            %
%                                                                        %
% %%%%%%%%% Introduction:
% This script is developed to simulate the diffusion phenomenon governed %
% by the diffusion equation in 1D case.                                  % 
%                                                                        %
% %%%%%%%%% Numerical model:                                             %
%  /|\                             |                                     %
%   |                              |                                     %
%   |                              |                                     %
%   |                                                                    %
%   |                   ___________C2___________                         %
%   |                  |           |            |                        %
%   |                  |           |            |                        %
%   |                  |                        |                        %
%   |_______C1_________|<-------- w=f*L ------->|__________C1________    %
%   |                                                                    %
%   |<---------------------------- L ------------------------------->|   %
%   |__________________________________________________________________\ %
%   0                              |                                   / %
%                                  |                                     %
% %%%%%%%%% Governing equation:                                          %
%                                                                        %
%    dc         d^2(c)                                                   %
%   ---- = D * --------   (1)                                            %
%    dt         dx^2                                                     %
%                                                                        %
% where c = density of the diffusing material                            %
%       D = collective diffusion coefficient                             %
%       L = length of 1D domain                                          %
%       w = width of the central segment controlled by the factor f      %
%       f = ratio of the central segment to L.  Note: f in (0, 1)        %
%      C1 = one constant defining the initial c in both sides            %
%      C2 = another constant defining the initial c in central segment   %
%       T = total physical time in simulation                            %
% refer to: https://en.wikipedia.org/wiki/Diffusion_equation.            %
%                                                                        %
% %%%%%%%%% Boundary Conditions:                                         %
% Periodical boundary is applied to the both ending nodes, i.e.,         %
%      x(N) | x(1) x(2) .................. x(N-1) x(N) | x(1)            %
%                                                                        %
% %%%%%%%%% Finite Difference Approximation:                             %
% The second-order derivative of c in the govering equation (1) is       %
% approximated with the 2nd order accurate central Finite Difference     %
% scheme, i.e.,                                                          %
%                                                                        %
%  d^2(c)   c(i+1) - 2c(i) + c(i-1)                                      %
%  ------ = -----------------------                                      %
%   dx^2           (dx)^2                                                %
%                                                                        %
% %%%%%%%%% inputs:                                                      %
% L, T, D, C1, C2, f (all assigned value should be positive, f in(0,1))  %
%                                                                        %
%%%%%%%%%% How to use this freeware:                                     %
% 1. Download the documents 'Diffusion.m' and 'Diffusion.fig';           %
% 2. Open the 'Difussion.m' with Matlab.                                 %
% 3. Before running it, please ensure the two documents locate in the    %
%    same folder.                                                        %
% 4. Click 'Run' in Matlab toolstrip under 'EDITOR'.                     %
% 5. The GUI (User Interface) shall show up.                             %
% 6. Specify the values for each user-define parameters;                 %
% 7. Click the 'Run' botton in GUI when everything is ready;             %
% 8. The instant result will be plotted in the right panel;              %
% 9. Click the 'Stop' button in GUI to stop the calculation at any time; %
% 10. An animation will be saved in the document-located folder after    %
%     each time of calculation. Please rename it immediately otherwise   %
%     it will be overwritten.                                            %
%                                                                        %
% %%%%%%%%% other information:                                           %
% Author: Zirui Mao (Post-doc in Professor Demkowicz's group)             %
% Date last modified: Jan., 20th, 2020                                   %
% This script is originally developed for the course 'MSEN 620           %
% KINETIC PROCESS MAT SCI' instructed by Dr. Demkowicz.                  %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function varargout = Diffusion(varargin)
% DIFFUSION MATLAB code for Diffusion.fig
%      DIFFUSION, by itself, creates a new DIFFUSION or raises the existing
%      singleton*.
%
%      H = DIFFUSION returns the handle to a new DIFFUSION or the handle to
%      the existing singleton*.
%
%      DIFFUSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIFFUSION.M with the given input arguments.
%
%      DIFFUSION('Property','Value',...) creates a new DIFFUSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Diffusion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Diffusion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Diffusion

% Last Modified by GUIDE v2.5 17-Jan-2020 11:11:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Diffusion_OpeningFcn, ...
                   'gui_OutputFcn',  @Diffusion_OutputFcn, ...
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


% --- Executes just before Diffusion is made visible.
function Diffusion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Diffusion (see VARARGIN)

javaFrame = get(gcf,'JavaFrame');
set(javaFrame,'Maximized',1);

L=1; % Length
T=0.2; % total time
D=1;  % collective diffusion coefficient
C1=1; % constant 1
C2=2; % constant 2
f=0.5; % ratio of central segment to the total length
N=500; % total number of nodes
nprint = 100; % total number of plots
x=[0:1/N:L]; % x location
c=x; % density of diffusing material
Pl=L*(1-f)/2; % left piecewise point
Pr=L-Pl; % right piecewise point

%%%% initial state %%%%%%%
c(abs(x-L/2)<=f*L/2) = C2; 
c(abs(x-L/2)>f*L/2) = C1;
c0=c;

dx=1/N; % grid size
dt=0.2*dx*dx/2/D; % critical time step dt by following the von Neumann criterion
nt=ceil(T/dt); % total time steps
tprint=T/nprint; 

plot(x,c,'k','linewidth',1.0);
xlabel('x');
ylabel('c');
set(gca,'TickDir','out');
axis([0 L min(C1,C2)-abs(C1-C2)*0.5 max(C1,C2)+abs(C1-C2)*0.5]);
set(gca,'Fontname','Times New Roman','Fontsize',17);

% Choose default command line output for Diffusion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Diffusion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Diffusion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;


function L_input_Callback(hObject, eventdata, handles)
% hObject    handle to L_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
L=str2double(get(hObject,'String'));
update_button_Callback(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of L_input as text
%        str2double(get(hObject,'String')) returns contents of L_input as a double


% --- Executes during object creation, after setting all properties.
function L_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f_input_Callback(hObject, eventdata, handles)
% hObject    handle to f_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f_input as text
%        str2double(get(hObject,'String')) returns contents of f_input as a double
f=str2double(get(hObject,'String'));
update_button_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function f_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C1_input_Callback(hObject, eventdata, handles)
% hObject    handle to C1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C1=str2double(get(hObject,'String'));
update_button_Callback(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of C1_input as text
%        str2double(get(hObject,'String')) returns contents of C1_input as a double


% --- Executes during object creation, after setting all properties.
function C1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C2_input_Callback(hObject, eventdata, handles)
% hObject    handle to C2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C2=str2double(get(hObject,'String'));
update_button_Callback(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of C2_input as text
%        str2double(get(hObject,'String')) returns contents of C2_input as a double


% --- Executes during object creation, after setting all properties.
function C2_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function D_input_Callback(hObject, eventdata, handles)
% hObject    handle to D_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
D=str2double(get(hObject,'String'));
update_button_Callback(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of D_input as text
%        str2double(get(hObject,'String')) returns contents of D_input as a double

% --- Executes during object creation, after setting all properties.
function D_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T_input_Callback(hObject, eventdata, handles)
% hObject    handle to T_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=str2double(get(hObject,'String'));
update_button_Callback(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of T_input as text
%        str2double(get(hObject,'String')) returns contents of T_input as a double


% --- Executes during object creation, after setting all properties.
function T_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in update_button.
function update_button_Callback(hObject, eventdata, handles)
% hObject    handle to update_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
L=str2double(get(handles.L_input,'String'));
f=str2double(get(handles.f_input,'String'));
C1=str2double(get(handles.C1_input,'String'));
C2=str2double(get(handles.C2_input,'String'));
D=str2double(get(handles.D_input,'String'));
T=str2double(get(handles.T_input,'String'));
N=500; % total number of nodes
nprint = 100; % total number of plots
x=[0:1/N:L]; % x location
c=x; % density of diffusing material
Pl=L*(1-f)/2; % left piecewise point
Pr=L-Pl; % right piecewise point

%%%% initial state %%%%%%%
c(abs(x-L/2)<=f*L/2) = C2; 
c(abs(x-L/2)>f*L/2) = C1;
c0=c;

dx=1/N; % grid size
dt=0.2*dx*dx/2/D; % critical time step dt by following the von Neumann criterion
nt=ceil(T/dt); % total time steps
tprint=T/nprint; 

plot(x,c,'k','linewidth',1.0);
xlabel('x');
ylabel('c');
set(gca,'TickDir','out');
axis([0 L min(C1,C2)-abs(C1-C2)*0.5 max(C1,C2)+abs(C1-C2)*0.5]);
set(gca,'Fontname','Times New Roman','Fontsize',17);


% --- Executes on button press in Run_button.
function Run_button_Callback(hObject, eventdata, handles)
% hObject    handle to Run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
L=str2double(get(handles.L_input,'String'));
f=str2double(get(handles.f_input,'String'));
C1=str2double(get(handles.C1_input,'String'));
C2=str2double(get(handles.C2_input,'String'));
D=str2double(get(handles.D_input,'String'));
T=str2double(get(handles.T_input,'String'));
N=500; % total number of nodes
nprint = 100; % total number of plots
x=[0:1/N:L]; % x location
c=x; % density of diffusing material
Pl=L*(1-f)/2; % left piecewise point
Pr=L-Pl; % right piecewise point

%%%% initial state %%%%%%%
c(abs(x-L/2)<=f*L/2) = C2;
c(abs(x-L/2)>f*L/2) = C1;
c0=c;

dx=1/N; % grid size
dt=0.2*dx*dx/2/D; % critical time step dt by following the von Neumann criterion
nt=ceil(T/dt); % total time steps
tprint=T/nprint;
pic_num=1;
set(handles.Stop_button,'userdata',0);
for k=1:nt
    if get(handles.Stop_button, 'userdata') % stop condition
		break;
	end
    t=k*dt;
    c_p=[c(2:end) c(1)];  % c(i+1)
    c_l=[c(end) c(1:end-1)]; % c(i-1)
    c=c+dt*D*(c_p-2*c+c_l)/dx/dx; % update c by the diffusion equation
    if mod(t,tprint)==0 % plot the results and save animation
        if get(handles.Stop_button, 'userdata') % stop condition
            break;
        end
        plot(x,c0,'k--',x,c,'k-','linewidth',1.0);
        legend('Initial state','Instant state');
        title(sprintf('Time =%1.2e sec', t),'position',[0.5*L,max(C1,C2)+0.3*abs(C1-C2)]);
        xlabel('x');
        ylabel('c');
        set(gca,'TickDir','out');
        axis([0 L min(C1,C2)-abs(C1-C2)*0.5 max(C1,C2)+abs(C1-C2)*0.5]);
        set(gca,'Fontname','Times New Roman','Fontsize',17);
        drawnow;
        F=getframe(gcf);
        I=frame2im(F);
        [I,map]=rgb2ind(I,256);
        if pic_num == 1
            imwrite(I,map,'result.gif','gif', 'Loopcount',inf,'DelayTime',0.);
        else
            imwrite(I,map,'result.gif','gif','WriteMode','append','DelayTime',0.);
        end
        pic_num = pic_num + 1;
    end
end


% --- Executes on button press in Stop_button.
function Stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Stop_button,'userdata',1);
