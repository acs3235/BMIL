function  [samplePointsSpaceDomain,samplePointsFrequencyDomain] = baddour_find_r_and_f(R,N)

n=1; %order

%the first step is to create a vector of bessel zeroes that will be used
%at multiples places in the code with "besselzero"

%the last entry in besselzero is the kind of the bessel function, 1 is used
zeros=besselzero(n,N,1);

samplePointsSpaceDomain=spaceSampler(R, zeros).';


%the corresponding frequency domain points are given by:

samplePointsFrequencyDomain=freqSampler(R,zeros).';