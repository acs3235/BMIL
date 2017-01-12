clear all; close all; clc

x = [1 2 3]
y = [4 5 6]
y2 = [4.5 5.5 6.5]

figure(1)
plot(x,y)
hold all;
plot(x, y + 1)
figure(2)
plot(x,y2)

