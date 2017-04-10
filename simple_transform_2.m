clear all; close all; clc

L = 1000

% r      Radial positions [m]          {0:numel(h)-1}
% k      Spatial frequencies [rad/m]   {pi/numel(h)*(0:numel(h)-1)}

r = [0:L-1]
k = [0:L-1] * pi/L;

a = 1;

y = sin(a*r)./r

semilogy(r,y)

figure()

Y = 1./((a.^2 - k.^2).^(1/2))

semilogy(k,Y)
hold all;


Y2 = ht(y,r,k)

%Y3 = spatial_transform(k./(2*pi),y,r,1)

%semilogy(k,Y2)

semilogy(k,Y2)

legend('theory', 'my code')