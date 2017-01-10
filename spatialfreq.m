close all; clear all; clc

%generate distance vector
d = [0:.005:1];

%Make sin wave representing spatial frequency
wave = sin(10 * pi * d);
% figure
% plot(d,wave)

%Get reflection distribution for one light injection point
r       = 0.01;     % Detector Radius [cm]
g       = 0.9;      % scattering anisotropy
mua_v   = 25;
musp_v  = 25;

R = MCMLr(mua_v,0,musp_v/(1-g),0,g,d,r);
% figure
% plot(d,R)