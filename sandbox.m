clear all; close all; clc

x = [0 1 2 3 4];

y = [1 1 0 -2 -2];

integral = cumtrapz(x,y);
integral(end)