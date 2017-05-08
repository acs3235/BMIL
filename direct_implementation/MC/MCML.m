% -------------------------------------------------------------------------
%
% MCML - Perform a Monte Carlo simulation using MCML
% Modified: 2009-03-16 /Erik Alerstam
% 
% Useage: 
%   s=MCML(filename,number_of_photons,layers)
%
% Arguments:
%   filename            - Name of the input and output ¯les to/from MCML. If the name is
%                         taken MCML.m will add a number after the string to create a unique
%                         file name. The name must be a valid variable name in the MATLAB
%                         environment.
%   number_of_photons   - Number of photons in the simulation
%   layers              - Layers matrix. The rows in this matrix describe the layers of the
%                         simulation geometry, starting with the layer closest to the source.
%                         The number of layers in the medium modeled is defined by the num-
%                         ber of rows in this matrix. Each layer is described by 5 values,
%                         stored as columns in the matrix. The values are refractive index,
%                         n, absorption coeffcient, mu_a, [1/cm], scattering coeffcien, mu_s, [1/cm],
%                         anisotropy (g) factor, g, and layer thickness, t, [cm]. The order is given
%                         by: [n mua mus g t]
%
% Output:
%   s                   - A MATLAB structure containing all simulation results as well as the
%                         simulation input parameters. Some of the important fields of this
%                         structure are: s.refl_r - The reffectance as a function of radial dis-
%                         tance from the source (r), s.abs_rz - the amount of absorbed light
%                         as a function of distance, r, and depth, z, and s.f_rz - the fluence as
%                         a function r and z.
%
% -------------------------------------------------------------------------

function output_struct=MCML(varargin)

h=create_MCML_input_file(varargin{:});
disp('.mci file created');

%if display_console~=0 %Show the console window
dos(['/Users/andrew/Documents/BMIL/direct_implementation/MC/Mcml.exe' h.input_filename ' &']);
while isempty(dir(h.output_filename))
    pause(1);
end
    
% else %Do not show the console window but echo the resulting console 
%     dos(['Mcml.exe ' h.input_filename], '-echo');
% end
disp('Simulation done!');

disp(['MCML output file: ' h.output_filename]);

pause(3); %Wait 3 sec for MCML to write the output file

output_struct=read_file_mco(h.output_filename);

end %function MCML

