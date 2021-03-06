%% Intial Moment Estamates
% Designed to provide S&C the intial estamates for lifting moment generated
% soley by the main wing.

%% Inital scripts
% clear; clc
prop_const
prop_T
v2=@(v,t,h,pt) sqrt(t/(1/2*p(h)*A(pt))+v.^2);   % velocity ratio, velocity, thrust, h
airfoil_polar   % sets up fuselage drag
cd_new      % sets up airfoil drag polar
equations_wash
lift_modder

%% CONSTANTS
% To be changed as Cg is nailed down

Cg=[-32;0;-1]; % x,y,z, location of C_g relative to nose of aircraft
AC=[-32+(4*(0.35-0.25));0;-4]; %x,y,z location of the Aerodynamic center
cD=[-32;0;-2];  % approx center of drag
C_Thrust=[-31;0;-4]; %x,y,z average location of thrust centers
L_gear=[-37;0;(4+4)];

% Calculations

Mw=@(aoa,h,v,on) ...
    1/2*p(h)*v.^2*Cma(aoa+incd)*((b-2*[2,on-2]*Rmax)*chrd)+...free stream wing lift
    1/2*p(h)*v2(v,CT(v,h,on),h,1).^2*Cma(incd)*((2*[2,0]*Rmax)*chrd)+... prop wash lift, cruise props
    1/2*p(h)*v2(v,TT(v,h,on),h,2).^2*Cma(incd)*((2*[0,on-2]*Rmax)*chrd);  %prop wash lift, takeoff props

% Developed domain
resol=30;
[hmat,mmat]=meshgrid(linspace(0,40e3,30),linspace(0.15,0.5,30));

%% Text Output...
v=1.2*VLOF;
h=0;
ne=8;
loc=2;  %1=about cg, 2 = about landing gear
opts=optimoptions('fsolve','display','off');
taoa=fsolve(@(aa) L(aa,h,v,ne)-W0(19),1,opts);
CM=Mw(taoa,h,v,ne);
if loc==1
    CM_L=cross(AC-Cg,W0(19)*[0;0;-1]);
    CM_T=cross(C_Thrust-Cg,T(v,h,0,ne)*[1;0;0]);
else
    CM_L=W0(19)*cross(AC-L_gear,[0;0;-1])+W0(19)*cross(Cg-L_gear,[0;0;1]);
    CM_T=T(v,h,ne)*cross(C_Thrust-L_gear,[1;0;0])+D(taoa,h,v,ne)*cross(cD-L_gear,[-1;0;0]);
end

fprintf('\n \t \t Moment Generated by Lifting Surface: \n')
fprintf('\t Total Moment: %15.0f ft-lb \n',CM+CM_L(2)+CM_T(2))
fprintf('\t \t C_m generated: %10.f ft-lb \n',CM)
fprintf('\t \t Lift-Weight:   %10.f ft-lb \n',CM_L(2))
fprintf('\t \t Thrust-Drag:   %10.f ft-lb \n',CM_T(2))

%% Full Domain
% % Compute for Steady Level Flight, cruise props only
% for ita=1:resol
%     parfor itb=1:resol
%         taoa(ita,itb)=fsolve(@(aa) ...
%             L(aa,...
%             hmat(ita,itb),...
%             a(hmat(ita,itb))*mmat(ita,itb),...
%             2)-...
%             W0(19),5,opts);
%         M_Cm_mat(ita,itb)=Mw(taoa(ita,itb),hmat(ita,itb),a(hmat(ita,itb))*mmat(ita,itb),2);
%         CM_L=cross(AC-Cg,W0(19)*[0;0;-1]);
%         CM_W=cross(Cg-Cg,W0(19)*[0;0;1]);
%         CM_T=cross(C_Thrust-Cg,T(250*1.4666,25e3,1000*550,2)*[1;0;0]);
%         CM_D=cross((AC-Cg)/2,T(250*1.4666,25e3,1000*550,2)*[-1;0;0]);
%         M_L_mat(ita,itb)=CM_L(2)+CM_W(2);
%         M_T_mat(ita,itb)=CM_T(2)+CM_D(2);
%     end
% end
%
% Tot_mat=M_Cm_mat+M_L_mat+M_T_mat;
%
% %% Graphic Output
% figure(1); clf
% ss=surf(hmat/1e3,mmat,Tot_mat);
% set(ss,'EdgeColor',[0.8 0.8 0.8],'FaceColor','interp')
% xlabel('Altidue, 1,000 ft')
% ylabel('Mach')
% zlabel('Total Moment, ft-lb')
