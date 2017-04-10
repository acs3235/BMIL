clear all; close all; clc

x = linspace(0,10,100)

plot(x,besselj(0,x))
hold all;

plot(x, x*0)