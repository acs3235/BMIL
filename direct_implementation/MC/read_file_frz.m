function [s]=read_file_frz(varargin)
clc

%addition by Erik Alerstam 2008-03-26
if nargin==0
    [FileName,PathName] = uigetfile('*.frz;*.frzc','Select FRZ-file to open');
else
    if nargin==1
        FileName=varargin{1};
    end
end


fid=fopen(FileName);           % Öppnar filen
disp(FileName)

tline = fgetl(fid);               % Tar bort onödiga rader            
st = fscanf(fid,'%g');            % [Matris]

sp=reshape(st',3,length(st)/3);
r=unique(sp(1,:))';
z=unique(sp(2,:));
sk=reshape(sp(3,:),length(z),length(r));
fclose(fid);
s=struct('data',{sk},'r',{r},'z',{z'});