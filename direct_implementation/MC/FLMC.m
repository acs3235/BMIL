% -------------------------------------------------------------------------
%
% FLMC - Performs Fluorescence Monte Carlo simulation
% Modified: 2009-03-16 /Erik Alerstam
% 
% Useage: 
%   [ex em]=FLMC(filename,number_of_photons,ex_layers,em_layers...)
%
%
% Arguments:
%
% Output:
%
% -------------------------------------------------------------------------

function [output_struct_a output_struct_r]=FLMC(varargin)

varargin
nargin

if nargin<4
    error('To few input arguments.');%Error:To few input arguments
end

layers_a=varargin{3};
layers_r=varargin{4};

a=size(layers_a);
r=size(layers_r);

%Are those necessary?
if a(1)~=r(1)
    error('Not the same number of layers');
end

if layers_a(:,5)~=layers_r(:,5)
    error('Inconsistent layers matrices');
end

a=1:nargin;
a(4)=[];

h_a=create_FLMC_MCA_input_file(varargin{a});
disp('.ina file created');

r=1:nargin;
r(3)=[];

h_r=create_FLMC_MCR_input_file(varargin{r});
disp('.inr file created');

%if display_console~=0 %Show the console window
    dos(['FLMC_MCA.exe ' h_a.input_filename ' &']);
    while isempty(dir(h_a.output_filename))
        pause(1);
    end
    
% else %Do not show the console window but echo the resulting console 
%     dos(['FLMC_MCA.exe ' h_a.input_filename], '-echo');
% end
disp('Excitation simulation done!');

%if display_console~=0 %Show the console window
    dos(['FLMC_MCR.exe ' h_r.input_filename ' &']);
    while isempty(dir(h_r.output_filename))
        pause(1);
    end
    
% else %Do not show the console window but echo the resulting console 
%     dos(['FLMC_MCA.exe ' h_r.input_filename], '-echo');
% end
disp('Emmission simulation done!');

pause(3); %Wait 3 sec for FLMC to write the output file.

output_struct_a=read_file_mca(h_a.output_filename);
output_struct_r=read_file_mcr(h_r.output_filename);

end %function FLMC

