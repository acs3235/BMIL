%Simple experiment written by Andrew Stier

% Visualize and compare reflectance calculations made by MC model and
% by forward model as a
% way to verify output of MC model




clear all; close all; clc

% LUTcreate_1layer
% Created by Ricky Hennessy
% Please cite J. Biomed. Opt. 18(3), 037003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for diffuse, so it uses mua_v instead of gamma
%
% For now, we pass in gamma as if it were mua_v

%% Constants
dr      = 0.009; %mm
Ndr     = round(6/dr)
s		= 0.1;     % Source Radius [mm]
g       = 0.8;      % scattering anisotropy

dr_cm = dr/10;
s_cm = s/10;

f = [0:.02:1];

%% Parameters (musp gamma muad th)
% musp_v = 1;  % reduced scattering cm^-1
% mu_a  = 1.3:0.1:1.9;     % cm^-1

% musp_v = linspace(0.01,50,3);  % reduced scattering
% musp_v = 25;
% mu_a  = linspace(1,50,3);     % absorption
%mu_a = 25;

%%
%Make musp_v and mu_a arrays 

% l_stars = [0.25 0.5 1 2 4];

l_stars = 0.25;

%% 
H = waitbar(0,'Please Wait...');
%allocate space for the look up table
% LUT = zeros([length(musp_v) length(mua_v)]);
tic

%initialize a file where you give all the row names
create_CONV_input_file(s_cm)

%Instead of LUT, just storing all values in simple array for now
RsMC_all = [];
RsFM_all = [];

%Iterate through paramter combinations
for iteration = 1:length(l_stars)
    l_star = l_stars(iteration);
    mu_a = 1/(101*l_star);
    musp_v = 100 * mu_a;
    mu_a_cm = mu_a*10 %mm^-1 -> cm^-1
    mu_a_cm 
    musp_v_cm = musp_v*10 %mm^-1 -> cm^-1
    musp_v_cm
    g
    for aa = 1:length(mu_a)
        for ss = 1:length(musp_v)
            waitbar((ss + length(musp_v)*(aa-1))/(length(musp_v)*length(mu_a)),H) %This line for display purposes only
    %         LUT(aa,ss) = MCMLr(mua_v(aa),0,musp_v(ss)/(1-g),0,g,f,r);

            %Generate reflection values using both MC and FM (forward model)
%             [RsMC,distance_cm,refl] = MCMLr_f(mu_a_cm(aa),0,musp_v_cm(ss)/(1-g),0,g,f,dr_cm,Ndr);
            [distance_cm,refl] = MCMLr_r(mu_a_cm(aa),0,musp_v_cm(ss),0,g,f,dr_cm,Ndr);

            refl = refl./max(refl)
            
            RsMC = spatial_transform(f, refl, distance_cm * 10, dr_cm * 10)
            
            %Plot reflectance
            figure(3)
            distance_mm = distance_cm * 10
            normalized_r = refl./1E7
%             plot(distance_mm,normalized_r)
            plot(distance_mm, refl)
            xlabel('distance (mm)')
            ylabel('reflectance')
            hold all;
            
            fprintf('mu_a')

            mu_a(aa)
            
            fprintf('mu_s')
            musp_v(ss)
            %RsMC = 1
            RsFM = R_model_diff(mu_a(aa),musp_v(ss),f);

            %Plot the results
            ratios = f./musp_v(ss);
            %plot(ratios,RsMC)
            %plot(f,RsMC)
            %plot(ratios,RsFM,'--')
            
            figure(1)
            semilogy(f,RsMC)
            hold all;
            figure(2)
            semilogy(f,RsFM,'--')
            hold all;
            RsMC_all = [RsMC_all RsMC];
            RsFM_all = [RsFM_all RsFM];
        end
    end
end

figure(1)
xlabel('f (mm^-^1)')
ylabel('Reflection MC')

figure(2)
xlabel('f (mm^-^1)')
ylabel('Reflection FM')


L = findobj(1,'type','line');
copyobj(L,findobj(2,'type','axes'));

axis([0 1 .01 1])


toc
close(H)

%Calculate the l2 error between MC and FM results
error = mean(abs(RsMC_all-RsFM_all)./RsFM_all*100)

mu_as = 1./(101*l_stars)
musp_v = 100 * mu_as


% save LUT.mat LUT musp_v mua_v

