%Simple experiment written by Andrew Stier

% Visualize and compare reflectance calculations made by MC model and
% by forward model as a
% way to verify output of MC model




clear all; close all; clc

% LUTcreate_1layer
% Created by Ricky Hennessy
% Please cite J. Biomed. Opt. 18(3), 037003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Constants
dr      = 0.009; %mm
Ndr     = round(6/dr)
s		= 0.1;     % Source Radius [mm]
g       = 0.9;      % scattering anisotropy

dr_cm = dr/10;
s_cm = s/10;

f = [0:.02:1];



l_stars = [0.25 0.5 1 2 4];

% l_stars = 0.25;


%initialize a file where you give all the row names
create_CONV_input_file(s_cm)

%Instead of LUT, just storing all values in simple array for now
RsMC_all = [];
RsFM_all = [];

%Iterate through paramter combinations
for iteration = 1:length(l_stars)
    
    filename = strcat(strcat('temp',num2str(iteration)),'.mco')
    refl = import_from_mco(filename).';
    refl = refl(1:end-1)
    distance_cm = [0:Ndr-1] * dr_cm
    
    %Find R vs. d
    l_star = l_stars(iteration);
    mu_a = 1/(101*l_star);
    musp_v = 100 * mu_a;
    mu_a_cm = mu_a*10 %mm^-1 -> cm^-1
    musp_v_cm = musp_v*10 %mm^-1 -> cm^-1

    [distance_cm_gpu,refl_gpu] = MCMLr_r(mu_a_cm,0,musp_v_cm,0,g,dr_cm,Ndr);
    %[distance_cm_gpu,refl_gpu] = get_mco(mu_a_cm,0,musp_v_cm,0,g,f,dr_cm,Ndr);
    
    %Plot R vs. d
    figure(1)
    distance_mm = distance_cm * 10
    
    semilogy(distance_mm, refl)
    xlabel('distance (mm)')
    ylabel('reflectance')
    hold all;

    figure(2)
    semilogy(distance_cm_gpu * 10, refl_gpu,'--')
    xlabel('distance (mm)')
    ylabel('reflectance')
    hold all;
end

L = findobj(1,'type','line');
copyobj(L,findobj(2,'type','axes'));



