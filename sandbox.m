clear all; close all; clc

dr      = 0.009; %mm
Ndr     = round(6/dr)
s		= 0.1;     % Source Radius [mm]
g       = 0.8;      % scattering anisotropy
f = [0:.02:1];

dr_cm = dr * 10

l_star = 0.25;
mu_a = 1/(101*l_star);
musp_v = 100 * mu_a;
mu_a_cm = mu_a*10 %mm^-1 -> cm^-1
musp_v_cm = musp_v*10 %mm^-1 -> cm^-1

[distance, reflectance] = get_mco(mu_a_cm,0,musp_v_cm,0,g,f,dr_cm,Ndr)

semilogy(distance, reflectance)