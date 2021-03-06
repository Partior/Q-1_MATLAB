f1='name'; v1={'Beechcraft 1900';'Fairchild Metroliner Metro III';...
    'Dornier Do 228';'Short SC7 Skyvan';'DHC-6 Twin Otter';...
    'Let L-410 Turbolet'};
f2='P_W'; v2={0.06752336449
0.071875
0.07903780069
0.092
0.09248
0.1048901488};

f3='W_S'; v3={55.22580645;51.61290323;42.29651163;33.06878307;29.76190476;...
    37.60660981};

f4='weight'; v4={17120
16000
14550
12500
12500
14110};

f5='range'; v5={578
1080
715
243
100
378};

clear dd
data_ws_pw=struct(f1,v1,f2,v2,f3,v3,f4,v4,f5,v5);

data_ws_pw(end+1).name='Partior';
data_ws_pw(end).P_W=Pa/550/W0(19);
data_ws_pw(end).W_S=W0(19)/S;
data_ws_pw(end).weight=W0(19);
ode_range;
data_ws_pw(end).range=r;