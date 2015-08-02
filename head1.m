
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
