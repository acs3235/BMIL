clear all; close all; clc

raw = importfile('lstars_p.txt')

%% Allocate imported array to column variable names
d = cell2mat(raw(:, 1))
dr = diff(d)
dr = dr(1)


%%
Rp = cell2mat(raw(:, 2))
plot(d,Rp)
hold all;

figure()
ref = read_file_mco('mcml.mco');
r = (0:ref.step_num(2)-1)*ref.step_size(2);
r_mm = r*10

Rp2 = ref.refl_r

Rp2 = Rp2(1:end-1)
r_mm = r_mm(1:end-1)

plot(r_mm,Rp2./sum(Rp2))

xlabel('radius from source (mm)')
ylabel('refl')

