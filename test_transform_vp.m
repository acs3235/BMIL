%% Andrew Stier: Test the spatial frequency transform
% Uses VP forward model of R vs. d, transforms it, and compares output to 
% VP forward model for R vs. f. 

% Trying to reproduce figure 4 in "Quantitation and mapping of tissue 
% optical properties using modulated imaging"

%%
clear all; close all; clc

raw = importfile('lstars_p.txt')

%% Allocate imported array to column variable names
d = cell2mat(raw(:, 1))
dr = diff(d)
dr = dr(1)

raw2 = importfile('lstarsf.txt')
f = cell2mat(raw2(:, 1))

%iterate through the r vs. d files for each set of parameters
for i = 2:2:10
    Rp = cell2mat(raw(:, i))
    
    figure(1)
    plot(d,Rp)
    hold all;
    
    figure(2)
    
    for i = 1:length(f)
        Rf(i) = 2*pi*sum(d .* besselj(0,2*pi*f(i)*d) .* Rp * dr);
    end
    
    semilogy(f,Rf)
    hold all;
    
end

legend('l^* = .25','l^* = .5','l^* = 1.0','l^* = 2.0','l^* = 4.0')

%iterate through the r vs. f files for each set of parameters
for i = 2:2:10
    Rf_vp = cell2mat(raw2(:, i))
    
    figure(3)
    semilogy(f,Rf_vp,'--')
    hold all;
end



L = findobj(3,'type','line');
copyobj(L,findobj(2,'type','axes'));

figure(2)

xlabel('f (mm^-^1)')
ylabel('R')

title('- Transformed  -- "Truth"')

%%
figure()
Rp = cell2mat(raw(:, 2))
plot(d,Rp)
