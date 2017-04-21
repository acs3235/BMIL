function Ftransformed = baddour_dht(R,f) 

n=1; %order
N=len(f)

%the first step is to create a vector of bessel zeroes that will be used
%at multiples places in the code with "besselzero"

%the last entry in besselzero is the kind of the bessel function, 1 is used
zeros=besselzero(n,N,1);

yMatrix=YmatrixAssembly(n,N,zeros);



%%

%in order to perform the transform, the discrete function has to be a 
%column vector 

%there is also the need to apply a scaling factor defined as:

scalingFactor=R^2/zeros(N); %space limited function scaling factor


%the transform is then performed by:
Ftransformed=yMatrix*f(:)*scalingFactor;

