%Andrew Stier
% Plots the output of the Ricky Hennesse MCM model before convolution, the 
% output of the Virtual Photonics forward model, and the output of the VP 
% MCM model to compare them. 

clear all; close all; clc

%Plot raw MCM output
figure()
ref = read_file_mco('mcml.mco');
r = (0:ref.step_num(2)-1)*ref.step_size(2);
r_mm = r*10


Rp2 = ref.refl_r

plot(r,Rp2)

sum(Rp2)


%%

Rp2 = Rp2(1:end-1)
r_mm = r_mm(1:end-1)

plot(r_mm,Rp2./sum(Rp2))
xlabel('radius from source (mm)')
ylabel('refl')

%%
%Plot VP MCM output
hold all;

rawVPMC = importfile('MCsim.txt')
d = cell2mat(rawVPMC(:, 3))
Rp = cell2mat(rawVPMC(:, 4))
plot(d,Rp./sum(Rp))

xlabel('radius from source (mm)')
ylabel('refl')


raw = importfile('lstars_p.txt')

%% Allocate imported array to column variable names
d = cell2mat(raw(:, 1))
dr = diff(d)
dr = dr(1)


%%
%Plot VP forward model
Rp = cell2mat(raw(:, 2))
plot(d,Rp)
hold all;
title('VP forward model')
xlabel('radius from source (mm)')
ylabel('refl')

legend('normalized raw MC', 'VP MC', 'VP forward model')

