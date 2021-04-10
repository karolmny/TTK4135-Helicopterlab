%Labday 3
clear all;
close all;

run("template_problem_2.m")

%q1 = 7;
%q2 = 0.01;
%q3 = 1;
%q4 = 0.5;
Q = diag([7 3 0.5 1]);

R = 0.1;

[K, S, e] = dlqr(A1, B1, Q, R);


display("K :");
display(K);

%Sending data
x_opt = [x1 x2 x3 x4];
x2model = [t', x_opt];

close all;

load unit.mat %1111 1
load sunit.mat %1111 0.1
load lunit.mat %1111 10
load pen1.mat %5132 0.1
load pen2.mat %5 1 10 5  0.1
load pen3.mat %3 1 0.05 0.1  0.1
load pen4.mat
load pen5.mat
load pen6.mat
load pen7.mat
load pen8.mat
load pen9.mat
load pen10.mat
load pen11.mat
load pen12.mat

for k = (2:5)
    figure(10+k)
    plot(pen10(1,:), pen10(k, :), 'r');
    hold on
%     plot(pen5(1,:), pen5(k, :), 'g');
%     hold on
%     plot(pen4(1,:), pen4(k, :), 'b');
%     hold on
    plot(pen8(1,:), pen8(k, :), 'k');
    hold on
    plot(pen7(1,:), pen7(k, :), 'm'); %vi liker denne
end 



