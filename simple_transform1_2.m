clear all; close all; clc

M = 500;
dr = .1;

% r      Radial positions [m]          {0:numel(h)-1}
% k      Spatial frequencies [rad/m]   {pi/numel(h)*(0:numel(h)-1)}

r = [0:dr:M-1];

L = length(r);

% k = r * 2*pi/M;

k = linspace(0,6,100);

a = 1;

y = exp(-a * r);

semilogy(r,y)

figure()

Y = 2 * pi * a./((k.^2 + a^2).^(3/2));

semilogy(k,Y)
hold all;



Y2 = ht(y,r,k);

% Y3 = spatial_transform2(k./(2*pi),y,r)

f = k./(2*pi);

Y3 = 2* pi * spatial_transform2(f,y,r);

%Y4 = abs(besselh(0,y));

semilogy(k,Y2,'--')

semilogy(k,Y3)

%semilogy(k,Y4)

legend('theory','online code', 'my code')