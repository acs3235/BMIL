%Simple experiment written by Andrew Stier

% Visualize and compare reflectance calculations made by MC model and
% by forward model given in McClathy et. al. Optica 3, 613-621 (2016) as a
% way to verify output of MC model

% Right now MC model is for diffuse scenario, so its output is very wrong.
% This is as expected.



clear all; close all; clc

% LUTcreate_1layer
% Created by Ricky Hennessy
% Please cite J. Biomed. Opt. 18(3), 037003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for diffuse, so it uses mua_v instead of gamma
%
% For now, we pass in gamma as if it were mua_v

%% Constants
f       = [0:0.1:1];    % Spatial frequency [cm^-1]
r       = 0.01;     % Detector Radius [cm]
s		= 0.01;     % Source Radius [cm]
g       = 0.9;      % scattering anisotropy

%% Parameters (musp gamma muad th)
% musp_v = 1;  % reduced scattering cm^-1
% mu_a  = 1.3:0.1:1.9;     % cm^-1

% musp_v = linspace(0.01,50,3);  % reduced scattering
musp_v = 25;
mu_a  = linspace(1,50,3);     % absorption
% mu_a = 25;

%% 
H = waitbar(0,'Please Wait...');
%allocate space for the look up table
% LUT = zeros([length(musp_v) length(mua_v)]);
tic

%initialize a file where you give all the row names
create_CONV_input_file(s)

%Instead of LUT, just storing all values in simple array for now
RsMC_all = [];
RsFM_all = [];

%Iterate through paramter combinations
for aa = 1:length(mu_a)
    for ss = 1:length(musp_v)
        waitbar((ss + length(musp_v)*(aa-1))/(length(musp_v)*length(mu_a)),H) %This line for display purposes only
%         LUT(aa,ss) = MCMLr(mua_v(aa),0,musp_v(ss)/(1-g),0,g,f,r);
        
        %Generate reflection values using both MC and FM (forward model)
        RsMC = MCMLr_f(mu_a(aa),0,musp_v(ss)/(1-g),0,g,f,r);
        RsFM = R_model_diff(mu_a(aa),musp_v(ss),f);
        
        %Plot the results
        ratios = f./musp_v(ss);
        plot(ratios,RsMC)
        hold all;
        plot(ratios,RsFM,'--')
        RsMC_all = [RsMC_all RsMC];
        RsFM_all = [RsFM_all RsFM];
    end
end

mu_a = [1 1 25.5 25.5 50 50]
legendCell = cellstr(num2str(mu_a', 'mu_a=%-d'))
legend(legendCell)
% legend('MC','Forward Model')
xlabel('f/mu_sp')
ylabel('Reflection')
toc
close(H)

%Calculate the l2 error between MC and FM results
error = norm(RsMC_all - RsFM_all)


% save LUT.mat LUT musp_v mua_v