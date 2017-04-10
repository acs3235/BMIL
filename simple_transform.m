clear all; close all; clc

M = 50;

% r      Radial positions [m]          {0:numel(h)-1}
% k      Spatial frequencies [rad/m]   {pi/numel(h)*(0:numel(h)-1)}

r = [0:0.05:M-1];

L = length(r);

k = r * 2*pi/M;

a = 1;

y = exp(-a * r);

semilogy(r,y)

figure()

Y = k./((k.^2 + a^2).^(3/2));

semilogy(k,Y)
hold all;



Y2 = ht(y,r,k);

% Y3 = spatial_transform2(k./(2*pi),y,r)

f = k./(2*pi);

Y3 = spatial_transform2(f,y,r);

%Y4 = abs(besselh(0,y));

semilogy(k,Y2)

semilogy(k,Y3)

%semilogy(k,Y4)

legend('theory','online code', 'my code')