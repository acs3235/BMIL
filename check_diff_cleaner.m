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
dr      = 1; %mm
Ndr     = 300;
s		= 0.1;     % Source Radius [mm]
g       = 0.71;      % scattering anisotropy

dr_cm = dr/10;
s_cm = s/10;





l_stars = [0.25 0.5 1 2 4];

% l_stars = 0.25;


%initialize a file where you give all the row names
create_CONV_input_file(s_cm)

%Instead of LUT, just storing all values in simple array for now
RsMC_all = [];
RsFM_all = [];

%Iterate through paramter combinations
for iteration = 1:length(l_stars)
    
    %Find R vs. d
    l_star = l_stars(iteration);
    mu_a = 1/(101*l_star);
    musp_v = 100 * mu_a;
    mu_a_cm = mu_a*10 %mm^-1 -> cm^-1
    musp_v_cm = musp_v*10 %mm^-1 -> cm^-1

%     [distance_cm,refl] = MCMLr_r(mu_a_cm,0,musp_v_cm,0,g,f,dr_cm,Ndr);
    
    dataRr = dlmread('out.Rrc','\t',1,0);
    distance_cm = dataRr(:,1);
    refl = dataRr(:,2);
    
    %Plot R vs. d
    figure(3)
    distance_mm = distance_cm * 10;
    %f = 2*pi /(Ndr) * distance_mm;
    f = distance_mm./(Ndr * dr^2);
    
    plot(distance_mm, refl)
    xlabel('distance (mm)')
    ylabel('reflectance')
    hold all;


    %Calculate RsMC
    RsMC = 2*pi*spatial_transform2(f, refl, distance_cm * 10);
%     RsMC = ht(refl,distance_cm * 10,2*pi*f)./(2*pi);
    
    %Calculate RsFM
    RsFM = R_model_diff(mu_a,musp_v,f);
    
%     RsMC = RsMC./max(RsMC);
%     RsFM = RsFM./max(RsFM);

    %Plot both
    
    figure(2)
    semilogy(f,RsFM,'--')
    hold all;
end

figure(1)
semilogy(f,RsMC)
hold all;

figure(1)
xlabel('f (mm^-^1)')
ylabel('Reflection MC')

figure(2)
xlabel('f (mm^-^1)')
ylabel('Reflection FM')


L = findobj(1,'type','line');
copyobj(L,findobj(2,'type','axes'));

axis([0 1 .01 1])


