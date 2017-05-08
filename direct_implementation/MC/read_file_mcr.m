% [data]= read_file_mcr();
%
% The mcr file is selected using a GUI. 

function [data]= read_file_mcr(varargin);
%clc

%addition by Erik Alerstam 2008-03-31
if nargin==0
    [FileName,PathName] = uigetfile('*.mcr','Select MCR-file to open')
else
    if nargin==1
        FileName=varargin{1};
    end
end

%[FileName,PathName] = uigetfile('*.mcr','Select MCO-file to open');
fid=fopen(FileName);           % Öppnar filen
name = fgetl(fid);
tline = fgetl(fid);
var=str2num(tline);
tline = fgetl(fid);
data=fscanf(fid,'%g');
data=reshape(data,var(3),var(2));
data=data';
% imagesc(data)
fclose(fid);