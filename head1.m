
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

setMethod(f="initialize",
          signature="piper",
          definition=function(.Object, l, call=sys.call(), size=NULL,
              group=NULL, colours=NULL, numbersymbols=FALSE,
              wt.col=NULL, wt.pch=NULL, pt.col=NULL)
          {
            # initialise member data
            if ( !is.null(size) ) {
              .Object@size <- size
            } else {
                .Object@size <- 1
            }
            .Object@Ca <- l$Ca
            .Object@Mg <- l$Mg
            .Object@Cl <- l$Cl
            .Object@SO4 <- l$SO4
            .Object@pt.pch <- l$pt.pch
            if ( !is.null(l$group) ) {
                .Object@group <- group
            } else { # plot all samples on the same plot
                .Object@group <- rep( 1, times=length(l$Ca) )
            }
            if ( !is.null(l$WaterType) ) {
                .Object@WaterType <- l$WaterType
            } else { # treat each sample as an individual water type
                .Object@WaterType <- seq( 1:length(row.names(l)) )
            }
            if ( !is.null(l$IDs) ) {
                .Object@IDs <- l$IDs
            } else {
                .Object@IDs <- row.names(l)
            }
            # TODO: make this less confusing
            # make the colours and symbols for the points now
            # because it saves confusion later
            # wt.col and wt.pch should be factors (?)
            # pt.col and pt.pch should be vectors
            # pt. overides wt.
          
            # set pt.col
            if ( ! is.null( l$pt.col ) ) {              # if specified
              .Object@pt.col <- l$pt.col                # assign it
            } else {                                    # else calculate it...
              wtf <- as.factor(.Object@WaterType)
              if ( ! is.null( l$wt.col ) ) {
                if ( length(l$wt.col) != length( levels(wtf) ) ) {
                  cat("ERROR: wt.col wrong length for WaterType!")
                  return(invisible())
                } else { levels(wtf) <- l$wt.col }
              } else {  # the default for pt.col
                levels( wtf ) <- seq( 1:length(levels(wtf)) )
              }
                  
              .Object@pt.col <- as.vector( wtf )
            }

            # set pt.pch
            # input wt:      2 2 1 2 3
            # output pt.col  2 2 1 2 3
            #        pt.pch  1 2 1 3 1
            if ( ! is.null( l$pt.pch ) ) {             # if specified
              .Object@pt.pch <- l$pt.pch               # assign it
            } else {                                   # else calculate it...
              wtf <- as.factor(.Object@WaterType)
              pch <- .Object@WaterType                 # initialise
              ## if ( ! is.null( l$wt.pch ) ) {
##               for ( i in levels(wtf) ) {
##                  # get subset , replace with values from vector
##                  lrp<-sum( wtf==i ) # the number of samples of that watertype
##                  pch[ wtf==i ] <- l$wt.pch[1:lrp]
##                }
##              } else {
##                # loop through levels
##                for ( i in levels(wtf) ) {
##                  lrp<-sum( wtf==i ) # the number of samples of that watertype
##                  pch[ wtf==i ] <- seq(lrp)
##                }
##              }
           ###   .Object@pt.pch <- pch                 # assign
          }
            .Object@call <- call
              return(.Object)
          }
)
