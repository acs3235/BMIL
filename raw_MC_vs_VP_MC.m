%Andrew Stier
% Plots the output of the Ricky Hennesse MCM model before convolution, the 
% output of the Virtual Photonics forward model, and the output of the VP 
% MCM model to compare them. 

% Raw MCM normalized by sum
% VP MCM normalized by sum
% VP forward model not normalized

clear all; close all; clc

%Plot raw MCM output
figure()
ref = read_file_mco('mcml.mco');
r = (0:ref.step_num(2)-1)*ref.step_size(2);
r_mm = r*10


Rp2 = ref.refl_r

plot(r,Rp2)

sum(Rp2)

Rp2 = Rp2(1:end-1)
r_mm = r_mm(1:end-1)

plot(r_mm,Rp2, 'b')
hold all;

plot(r_mm,Rp2./max(Rp2), 'b--')
plot(r_mm,Rp2./sum(Rp2), 'b:')

xlabel('radius from source (mm)')
ylabel('refl')

axis([0 4 0 1])
%%
%Plot VP MCM output

rawVPMC = importfile('MCsim.txt')
d = cell2mat(rawVPMC(:, 3))
Rp = cell2mat(rawVPMC(:, 4))
plot(d,Rp,'r')
plot(d,Rp./max(Rp),'r--')
plot(d/Rp./sum(Rp),'r:')

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
plot(d,Rp,'g')
plot(d,Rp./max(Rp),'g--')
plot(d,Rp./sum(Rp),'g:')
hold all;
title('VP forward model')
xlabel('radius from source (mm)')
ylabel('refl')

legend('raw MC','MC max', 'MC sum', 'VP FM', 'VP FM max', 'VP FM sum', 'VP MCM', 'VP MCM max', 'VP MCM sum')
axis([0 4 0 1])

