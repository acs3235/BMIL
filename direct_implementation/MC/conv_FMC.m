% conv_data=conv_FMC(ex, em, dist)
% ex = the exitation matrix
% em = the emission matrix
% dist = the number of voxels between the source and detector.
% 
% conv_data = the resulting data

function conv_data=conv_FMC(ex, em, dist);
[t1,t2]=size(ex);
nollor=zeros(t1,dist);
ex2=[fliplr(ex),ex,nollor];
em2=[nollor,fliplr(em),em];
conv_data=ex2.*em2;
figure()
imagesc((conv_data));
