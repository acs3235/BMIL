clear all; close all; clc

L = 1000

% r      Radial positions [m]          {0:numel(h)-1}
% k      Spatial frequencies [rad/m]   {pi/numel(h)*(0:numel(h)-1)}

r = [0:L-1]
k = [0:L-1] * pi/L;

a = 1;

y = exp(-a * r.^2)

semilogy(r,y)

figure()

Y = 1/(2*a)*exp(-k.^2./(4*a))

semilogy(k,Y)
hold all;


Y2 = ht(y,r,k)

Y3 = spatial_transform(k./(2*pi),y,r,1)

Y4 = abs(besselh(0,y))

semilogy(k,Y2)

semilogy(k,Y3)

semilogy(k,Y4)

legend('theory','online code', 'my code','matlab code?')