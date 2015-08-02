
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
global kappa=-1.0;
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

%related to the intrinsic permeability
function intrinsic(){
%Hydraulic conductivity list K:
%Gravel            0.001-1
%Clean Sand        10^-6-0.001
%Silty Sand        10^-7-10^-3
%Silt              10^-9-10^-5
%Clay              10^-12-10^-8

%the dynamic viscosity mew - default 1.0
mew=1.0;

%fluid density rho2 - default 1.0
rho2=1.0;

%kappa being the intrinsic permeability of a pore space
kappa=(mew/(rho2*g));
}


function hydrostatic(){
    if v==0{
        condition_v="hydrostatic conditions";
    }
}
