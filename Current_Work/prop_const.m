%% PropWash Constants
% All constants used by the /PropWash/ scripts to run and develop unique
% V-H and fuel useage diagrams

%% ATMOSPHERE
% https://wahiduddin.net/calc/density_altitude.htm
T0=288.15;          % K
L=6.5;              % K/km
Temp=@(H) T0-L*(H/3280.84);                 % Temperature

P0=101325;          % Pa
g=9.80665;          % gravitational constant
R=8.31432;          % Gas constant, J/mol*degK
M=28.9644;          % molecular weight of air, gm/mol
Prs=@(H) P0*(1-L*(H/3280.84)/T0)^(g*M/(R*L));% Pressure

p_SI=@(H) Prs(H)*M/(R*Temp(H)*1000);        % Density, kg/m^3
p=@(H) p_SI(H)*0.00194032;                  % Densith, slugs/ft^3

a=@(h) sqrt(1.4*287.058*Temp(h))*3.28084;   % mach 1 in feet per second

%% WEIGHT
Wfix=@(px) 225*(3+px);      % Payload weight, as function of # passengers

% Empty Weight - 
%   Fairchild Metro III empty weight - weight for propulsion system, then
%   plus our estamates for the propulsion system
% We=9064.1;                  % Empty (or Structure) weight
Wprops=[100;50];   % cruise; takeoff
Wapus=500;  % APUs, each
We=8737-(336*2-100*2)+([2,6]*[97.14;18.1]+[2,6]*Wprops+2*Wapus);

Wf=1100;                  % Fuel weight, takes up approx 183 gallons of volume at 6.01 lb/US gal
W0=@(pw) Wfix(pw)+We+Wf;    % Total

%% MAIN WING
%   Planeform
S=240;
AR=15;
b=sqrt(AR*S);   % or 60.0 ft
chrd=S/b;       % or 4.00 ft
r_chrd=6;
t_chrd=2;
e=1.78*(1-0.045*AR^0.68)-0.64; %eq 10b - http://faculty.dwc.edu/sadraey/Chapter%203.%20Drag%20Force%20and%20its%20Coefficient.pdf
K=1/(AR*e*pi);

%   Airfoil
incd=4.6;     % incidence angle of wing strucutre
airfoil_polar_file='Q1fullpolar.txt';  % file name of Airfoil Cl/Cd polar data as run by XFOIL
clms=[1,3,6,9]; %colums for alpha, Cl, Cd, Cm

%% FUSELAGE
%   Wetted Area and Fuselage Wetted Area
S_wet=4.5*S;        % from Dr. Raj Lecture 4
S_wet_f=S_wet-2*S;  % minus both sides of the wings
cab_diam=9;         % cabin diamater, ft

%% POWER
power_const % Run for constants as defined by Hrovat

%   Propellers
n=8;        % number of propellers