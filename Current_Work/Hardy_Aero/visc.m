function mu=visc(h)
% This function is purely to outpu the viscosity of the air at various
% altitudes, used by the drag model for the fuselage

Temp=@(h) 15.0-6.5*(h/3280.84)+273.15;  % input h of feet, output of Temp in kel

tb=[60 3.7903436E-7
    50 3.7321822E-7
    40 3.6734886E-7
    30 3.6142511E-7
    20 3.5544579E-7
    10 3.4940968E-7
    0 3.4331552E-7
    -10 3.37162E-7
    -20 3.3094782E-7
    -30 3.2467161E-7
    -40 3.1833197E-7
    -50 3.1192748E-7
    -60 3.0545668E-7
    -70 2.9891807E-7
    -80 2.9231013E-7
    -90 2.8563131E-7
    -100 2.7888003E-7
    -110 2.7205469E-7
    -120 2.6515368E-7
    -130 2.5817536E-7];

convt=@(k) k*9/5-459.67;

mu=interp1(tb(:,1),tb(:,2),convt(Temp(h)));