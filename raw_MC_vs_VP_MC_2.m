%Andrew Stier
% Plots the output of the Ricky Hennesse MCM model before convolution, the 
% output of the Virtual Photonics forward model, and the output of the VP 
% MCM model to compare them. 

% Raw MCM normalized by sum
% VP MCM normalized by sum
% VP forward model not normalized

clear all; close all; clc

%% Plot raw MCM output
dr      = 0.009; %mm
Ndr     = round(6/dr)
s		= 0.1;     % Source Radius [mm]
g       = 0.8;      % scattering anisotropy

dr_cm = dr/10;
s_cm = s/10;

f = [0:.02:1];
figure()
l_star = 0.25;
mu_a = 1/(101*l_star);
musp_v = 100 * mu_a;
mu_a_cm = mu_a*10 %mm^-1 -> cm^-1
musp_v_cm = musp_v*10 %mm^-1 -> cm^-1
[R,distance,Rp2] = MCMLr_f(mu_a_cm,0,musp_v_cm,0,g,f,dr_cm,Ndr);

r_mm = distance * 10

%ref = read_file_mco('mcml.mco');
% r = (0:ref.step_num(2)-1)*ref.step_size(2);
% r_mm = r*10
% 
% 
% Rp2 = ref.refl_r
% 
% plot(r,Rp2)
% 
% sum(Rp2)

% Rp2 = Rp2(1:end-1)
% r_mm = r_mm(1:end-1)

h1 = plot(r_mm,Rp2, 'b')

%%
hold all;

h2 = plot(r_mm,Rp2./max(Rp2), 'b--')
h3 = plot(r_mm,Rp2./sum(Rp2), 'b:')

xlabel('radius from source (mm)')
ylabel('refl')

%axis([0 4 0 1])
%%
%Plot VP MCM output

rawVPMC = importfile('MCsim.txt')
d = cell2mat(rawVPMC(:, 3))
Rp = cell2mat(rawVPMC(:, 4))
h4 = plot(d,Rp,'r')
h5 = plot(d,Rp./max(Rp),'r--')
h6 = plot(d/Rp./sum(Rp),'r:')

xlabel('radius from source (mm)')
ylabel('refl')


raw = importfile('lstars_p.txt')

%Allocate imported array to column variable names
d = cell2mat(raw(:, 1))
dr = diff(d)
dr = dr(1)


%%
%Plot VP forward model
Rp = cell2mat(raw(:, 2))
h7 = plot(d,Rp,'g')
h8 = plot(d,Rp./max(Rp),'g--')
h9 = plot(d,Rp./sum(Rp),'g:')
hold all;
title('VP forward model')
xlabel('radius from source (mm)')
ylabel('refl')

legend({'raw MC','MC max', 'MC sum', 'VP FM', 'VP FM max', 'VP FM sum', 'VP MCM', 'VP MCM max', 'VP MCM sum'})
%legend([h1 h2 h3], {'raw MC','MC max', 'MC sum'}, [h7 h8 h9],{'VP MCM', 'VP MCM max', 'VP MCM sum'})


axis([0 4 0 1])

