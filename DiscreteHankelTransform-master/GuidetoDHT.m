function  [r,f] = baddour_find_r_and_f(R,N)

n=1; %order
N=256; %number of points

%the first step is to create a vector of bessel zeroes that will be used
%at multiples places in the code with "besselzero"

%the last entry in besselzero is the kind of the bessel function, 1 is used
zeros=besselzero(n,N,1);

%both forward and inverse transformed are performed with the same
%Transformation matrix "yMatrix"

yMatrix=YmatrixAssembly(n,N,zeros);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
% Case 1: Forward Transform
%}


% let's define the space limitation. 
R=15; 


%the function that has to be transformed needs to be discretized at
%specific sample points. this can be achieved by using the spaceSampler
%function

samplePointsSpaceDomain=spaceSampler(R, zeros);


% once the sample points are defined, the function is discretized
%the function that will be used is the sinc function defined as:
% f(r)=sin(a*r)/(a*r)

%let's take an arbitrary factor a;
a=5;


%then the discrete function is:
f=sin(a*samplePointsSpaceDomain(:))./(a*samplePointsSpaceDomain(:));

size(f)

%%

%in order to perform the transform, the discrete function has to be a 
%column vector 

%there is also the need to apply a scaling factor defined as:

scalingFactor=R^2/zeros(N); %space limited function scaling factor


%the transform is then performed by:
Ftransformed=yMatrix*f(:)*scalingFactor;

%the corresponding frequency domain points are given by:

samplePointsFrequencyDomain=freqSampler(R,zeros);

%and the result can be seen as:

figure()
plot(samplePointsFrequencyDomain,Ftransformed);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
 Case 2: Inverse Transform
%}


%in the case of the inverse transform, the function is limited in the
%frequency domain by "W"

W=30; 

%the sampling is then performed using the "freqSampler" function. However
%the frequency limit "W" has to be transformed to "R" by:

R=zeros(N)/W;

frequencySamplePoints=freqSampler(R,zeros);


%the discrete function is then given by:

F=  (frequencySamplePoints<a).*(((frequencySamplePoints./a).^n).*cos(n*pi/2)./ ...
    (a^2.*sqrt(1-frequencySamplePoints.^2./a^2).*(1+sqrt(1-frequencySamplePoints.^2/a^2)).^n))+ ...
    (frequencySamplePoints>a).*((sin(n.*asin(a./frequencySamplePoints)))./(a^2.*sqrt(frequencySamplePoints.^2./a^2-1)));
    
%the scaling factor for a frequency limited function while performing a
%IDHT is given by:


scalingFactorFreq=1;

%the inverse transform is then given by:

fTransformed=yMatrix*F(:)*scalingFactorFreq;


%and the corresponding sample points in the space domain are given by:

spaceSamplePoints=spaceSampler(R,zeros);


%the result can be seen by:

figure()
plot(spaceSamplePoints,fTransformed)

%% Compare DHT computed results with continuous function
%Check results for forward transform
figure()
plot(spaceSamplePoints,fTransformed,samplePointsSpaceDomain,f)
legend('IDHT computed function','continuous function')

%Check results for inverse transform
figure()
plot(samplePointsFrequencyDomain,Ftransformed,frequencySamplePoints,F);
legend('DHT computed function','continuous function')
