%Testing against transform found at http://www.stat.phys.titech.ac.jp/~yokoyama/memo4.pdf

clear all; close all; clc

M = 100;

% r      Radial positions [m]          {0:numel(h)-1}
% k      Spatial frequencies [rad/m]   {pi/numel(h)*(0:numel(h)-1)}

r = [0:0.2:M-1];

L = length(r);

k = r * 2*pi/M;

a = 3;

y = exp(-a * r.^2);

semilogy(r,y)

figure()

Y = 1/(2*a)*exp(-k.^2./(4*a));

semilogy(k,Y)
hold all;



Y2 = ht(y,r,k);

% Y3 = spatial_transform2(k./(2*pi),y,r)

f = k./(2*pi);

Y3 = spatial_transform2(f,y,r);

Y4 = abs(besselh(0,y));

semilogy(k,Y2)

semilogy(k,Y3)

%semilogy(k,Y4)

legend('theory','online code', 'my code')

xlabel('k')
ylabel('R')