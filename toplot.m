%day4 plots

load g1
load g10
load g01
load elarge
load dotlarge
load middle
load lq1
load lq2
load lq3
load const1
load const2
load const3
load const4
load const5
load esmall
load edotsmall
load dotsmall


file = g1;
file2 = g10;
file3 = g01;

file = const1;
file2 = const2;
file3 = const3;
file4 = const4;
file5 = const5;

for k = 2:7
    figure(k)
    switch k
        case 2
            %plot(t,x1,'m')
            ylabel('lambda')
            hold on
        case 3
            %plot(t,x2,'m')
            ylabel('r')
            hold on
        case 4
            %plot(t,x3,'m')
            ylabel('p')
            hold on
        case 5
            %plot(t,x4,'m')
            ylabel('pdot')
            hold on
       case 6
            %plot(t,x5,'m')
            ylabel('e')
            hold on
       case 7
            %plot(t,x6,'m')
            ylabel('edot')
            hold on     
    end  
   % plot(file(1,:), file(k, :), 'r', file2(1,:), file2(k,:), 'g', file3(1,:), file3(k,:), 'b')
    plot(file(1,:), file(k, :), 'r', file2(1,:), file2(k,:), 'g', file3(1,:), file3(k,:), 'b',  file4(1,:), file4(k, :), 'c', file5(1,:),  file5(k, :), 'k')
    grid
    xlabel('tid (s)')
    legend('Constrain_1', 'Constrain_2', 'Constrain_3', 'Constrain_4', 'Constrain_5', 'Location','best')
    %legend('x_{opt}','LQ_{Q1}', 'LQ_{Q2}', 'LQ_{Q3}')
    %legend('LQ_{Q1}', 'LQ_{Q2}', 'LQ_{Q3}')
end

%figure(1)
%plot(t,x1,'m', file(1,:), file(k, :), 'r', file2(1,:), file2(k,:), 'g', file3(1,:), file3(k,:), 'b',  file4(1,:), file4(k, :), 'm', file5(1,:),  file5(k, :), 'k')
%grid
%legend('x_{opt}','LQ_{Q1}', 'LQ_{Q2}', 'LQ_{Q3}')
%legend('x_{opt}','Constrain_1', 'Constrain_2', 'Constrain_3', 'Constrain_4', 'Constrain_5')
%ylabel('edot')



figure(1)
%subplot(611)
%stairs(t,u),grid
%ylabel('u')
%legend('p_c', 'e_c')
subplot(611)
plot(t,x1,'m', file(1,:), file(2, :), 'r', file2(1,:), file2(2,:), 'g', file3(1,:), file3(2,:), 'b')
%plot(t,x1,'m', file(1,:), file(2, :), 'r', file2(1,:), file2(2, :), 'g', file3(1,:),  file3(2, :), 'b', file3(1,:),  file4(2, :), 'm', file3(1,:),  file5(2, :), 'k'), 
grid
legend('x_{opt}','Constrain_1', 'Constrain_2', 'Constrain_3', 'Constrain_4', 'Constrain_5')
ylabel('lambda')
subplot(612)
plot(t,x2,'m', file(1,:), file(3, :), 'r', file2(1,:), file2(3,:), 'g', file3(1,:), file3(3,:), 'b')
%plot(file(1,:),file(3, :), 'r', file2(1,:),  file2(3, :), 'g', file3(1,:),  file3(3, :), 'b', file3(1,:))
%,  file4(3, :), 'm', file3(1,:),  file5(3, :), 'k'), grid
ylabel('r')
subplot(613)
plot(t,x3,'m',file(1,:),  file(4, :), 'r', file2(1,:),  file2(4, :), 'g', file3(1,:),  file3(4, :), 'b')
%file3(1,:),  file4(4, :), 'm', file3(1,:),  file5(4, :), 'k'), 
grid
ylabel('p')
subplot(614)
plot(t,x4,'m',file(1,:),  file(5, :), 'r', file2(1,:),  file2(5, :), 'g', file3(1,:),  file3(5, :), 'b')
%, file3(1,:),  file4(5, :), 'm', file3(1,:),  file5(5, :), 'k'), 
grid
ylabel('pdot')
subplot(615)
plot(t,x5,'m',file(1,:),  file(6, :), 'r', file2(1,:),  file2(6, :), 'g', file3(1,:),  file3(6, :), 'b')
%file3(1,:),  file4(6, :), 'm', file3(1,:),  file5(6, :), 'k'), 
grid
ylabel('e')
subplot(616)
plot(t,x6,'m', file(1,:),  file(7, :), 'r', file2(1,:),  file2(7, :), 'g', file3(1,:),  file3(7, :), 'b')
%file3(1,:), file4(7, :), 'm', file3(1,:),  file5(7, :), 'k'), 
grid
xlabel('tid (s)'),ylabel('edot')

  
