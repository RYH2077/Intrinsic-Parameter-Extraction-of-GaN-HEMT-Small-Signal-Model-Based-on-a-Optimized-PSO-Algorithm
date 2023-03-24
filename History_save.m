k1max=906.5;k1min=302.2;%Cgs fF
k2max=14.1;k2min=2;%Ri Ohm
k3max=0;k3min=300;%Rgsf KOhm
k4max=78;k4min=26;%Cgd fF
k5max=129;k5min=10;%rgd KOhm
k6max=304.5;k6min=10;%rgdf KOhm
k7max=1.4;k7min=0;%t s
k8max=0.12;k8min=0.09;%gm
k9max=14299;k9min=0;%Rds Ohm
k10max=43;k10min=0;%Cds fF

cpg=153.339.*1e-15;
cpgd=0;
cpd=110.151.*1e-15;
cgd = X(4)*1e-15;
cgs = X(1)*1e-15;%cgd=cgs
cds = X(10)*1e-15;
cpgi=572.63*1e-15;
cpdi=262.382*1e-15;

% Inductors
lg=48.079.*1e-12;
ld=63.668.*1e-12;
ls=13.515.*1e-12;
rg=2.160;
rd=9.103;
rs=1.639;

% Resistors & others
ri = X(2);
rds = X(9);
rgd = X(5)*1000;
gm = X(8);
tau =X(7);
Rgsf = X(3)*1000;
Rgdf = X(6)*1000;