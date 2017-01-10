clear all; close all; clc

%Generate and visualize results with forward model:

clear all; close all; clc

for gamma = 1.3:0.1:1.9
    i = 1
    for ratio = 0:0.1:1
        mu = 1;
        f = ratio;
        Rsm(i) = R_model(gamma,mu,f);
        i = i + 1;
    end
    ratios = [0:0.1:1];
    plot(ratios,Rsm)
    hold all;
end

gammas = [1.3:0.1:1.9];
legendCell = cellstr(num2str(gammas', 'gammas=%-d'))
legend(legendCell)


%Generate and visualize results with monte carlo code:

% LUTcreate_1layer
% Created by Ricky Hennessy
% Please cite J. Biomed. Opt. 18(3), 037003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for diffuse, so it uses mua_v instead of gamma
%
% For now, we pass in mua_v as if it were gamma

%% Constants
f       = [0.6, 1.2];    % Spatial frequency [mm^-1]
r       = 0.01;     % Detector Radius [cm]
s		= 0.01;     % Source Radius [cm]
g       = 0.9;      % scattering anisotropy

%% Parameters (musp muae muad th)
musp_v = 1.2;  % reduced scattering mm^-1
mua_v  = 1.4;     % gamma (actually absorption coefficient right now)

%% Make Second Figure
H = waitbar(0,'Please Wait...');
%allocate space for the look up table
% LUT = zeros([length(musp_v) length(mua_v)]);
tic

%initialize a file where you give all the row names
create_CONV_input_file(s)
for aa = 1:length(mua_v)
    for ss = 1:length(musp_v)
        waitbar((ss + length(musp_v)*(aa-1))/(length(musp_v)*length(mua_v)),H) %This line for display purposes only
%         LUT(aa,ss) = MCMLr(mua_v(aa),0,musp_v(ss)/(1-g),0,g,f,r);
        RsMC = MCMLr_f(mua_v(aa),0,musp_v(ss)/(1-g),0,g,f,r);
        ratios = f./musp_v;
        plot(ratios,RsMC,'--')
        hold all;
    end
end
legendCell = cellstr(num2str(mua_v', 'mua_v=%-d'))
legend(legendCell)
toc
close(H)

% save LUT.mat LUT musp_v mua_v