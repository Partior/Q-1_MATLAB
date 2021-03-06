function dval=airborne_wash(~,val,ne)

persistent mu SFC_eq Pa L T Df Dw incd Clmax %#ok<PSET>
if isempty(mu)
    load('takeoff_const.mat')
end

dval=zeros(size(val));

Wt=val(1);
Vt=val(2);

% formulation of dV/dt
Lg=L(Clmax-incd,0,Vt,ne);
Tt=T(Vt,0,ne);
Dg=Df(0,0,Vt)+Dw(0,0,Vt,ne)*0.4; % air drag resistance
% using eq 19A from  http://www.dept.aoe.vt.edu/~lutze/AOE3104/takeoff&landing.pdf

%find flight path angle
gm=atand(val(4)/val(2));


dval(1)=-SFC_eq(Pa/550); % dW/dt
dval(2)=(cosd(gm)*(Tt-Dg)-sind(gm)*Lg)/(Wt/32.2); % dV_x/dt
dval(3)=Vt; % dS/dt
if val(5)<1
    dval(4)=max(0,(sind(gm)*(Tt-Dg)+cosd(gm)*Lg-Wt)/(Wt/32.2)); % dV_y/dt
else
    dval(4)=(sind(gm)*(Tt-Dg)+cosd(gm)*Lg-Wt)/(Wt/32.2);
end
dval(5)=val(4); %dy/dt