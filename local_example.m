clear all; close all; clc

data = load('sandbox.Rr')

r = data(:,1);
refl = data(:,2);

diff(r)