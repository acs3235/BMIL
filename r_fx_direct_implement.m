clc
clear all
close all
%%
addpath '/c/Users/acs3235/Documents/BMIL/BMIL'
addpath '/c/Users/acs3235/Documents/BMIL/BMIL/direct_implementation/MC'
addpath '/c/Users/acs3235/Documents/BMIL/BMIL/direct_implementation/HankelTransform'
%%
% n1=1.4;
% ua1=1;
% us1=20;
% d1=100000e-4;

n1=1.33;
ua1=0.08;
us1=194;
d1=100000e-4;
% 
% n2=1.4;
% ua2=1000;
% us2=20;
% d2=8000e-4;

g=0.95;

num_photon=1e4;
n_above=1;
n_below=1;
dz=10e-4;
dr=50e-4;
r=1.5;
num_dz=round((d1)/dz);
num_dr=round(r/dr);
num_da=30;


filename='single_simu';

tissue=[n1 ua1 us1 g d1];
%tissue=[n1 ua1 us1 g d1;n2 ua2 us2 g d2];
%s=MCML(filename,num_photon,tissue,n_above,n_below,dz,dr,num_dz,num_dr,num_da);

[distance_cm,ref_temp] = MCMLr_r(ua1,0,us1,0,g,dr,num_dr);
    

%%
% s
% ref_temp=s.refl_r;
ref=ref_temp(1:length(ref_temp)-1);
figure
plot(ref)

%%
ref_FT=fftshift(abs(fft(ref)));
figure
plot(ref_FT)

%%
% fx=linspace(0,0.25,length(ref))*10;
% kernel=besselj(0,2*pi*fx).*ref';
% kernel_FT=fftshift(abs(fft(kernel)));
% figure
% plot(kernel_FT)
rho_temp=0:dr:r;
rho=rho_temp(2:length(rho_temp)-1);
fx=linspace(0,0.6,100);
%%


% for i=1:length(fx)
%     Rdk(i)=2*pi*sum(rho.*besselj(0,fx(i)*2*pi*rho).*ref')*dr;
% end
% figure

clear Rdk

Rdk = 2*pi*spatial_transform2(fx, ref', rho);

plot(fx, Rdk)

%% this method is same as the one above
% [H,I]=ht(ref',rho,fx*2*pi);
% figure
% plot(H)

