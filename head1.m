
%energy per weight of drilled fluid
global h=[];
%gravitational constant meters per second squared
global g=9.820;
%reprivational constant cubic meters per second squared
global GM=9.86*(10^14);
%fluid density - default filtered water
global rho=1.0;
%velocity of fluid in aquifier/other
global v=0;
global condition_v="null";
%hydraulic conductivity
global k=-1.0;
%hydraulic gradient default 2.0;
global deltah_deltag=2.0;

%hydraulic conductivity is a measure of of how easily a medium
%transmits water, higher K materials transmit more easily than low 
%k materials;
function darcys_law(){
%where function Q=-K*dh/ds*A
%radius of flow crossectional area in m
r=1.0
%crosssectional area of flow
var A = 2*pi*r;
Q=-k*(deltah_deltag)*A;
return Q;
}

%calculate bernoulli equation in terms of pressure
pressure_head=calcP();
%return pressure head
function calcP(){
%solidpipe v perforation pipe = default null 1.0
P=1.0;
return P/(rho*g);
}


function hydrostatic(){
    if v==0{
        condition_v="hydrostatic conditions";
    }
}
