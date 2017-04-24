clear all; close all; clc

R = 500;
L = 1000;

[r,f] = baddour_find_r_and_f(R,L)

k = 2*pi*f;

a = 1;

y = exp(-a * r);

semilogy(r,y)

figure()

Y = 2 * pi * a./((k.^2 + a^2).^(3/2));

semilogy(k,Y)
hold all;

size(y)
size(r)
size(k)

%Y2 = ht(y,r,k);

% Y3 = spatial_transform2(k./(2*pi),y,r)

Y3 = 2* pi * spatial_transform2(f,y,r);

%Y4 = abs(besselh(0,y));

%semilogy(k,Y2,'--')

semilogy(k,Y3)

%semilogy(k,Y4)

%legend('theory','online code', 'my code')