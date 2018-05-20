close all
clear all
load('data.mat')
[r p y] = quat2angle(q(1:end,:));
dcm = quat2dcm(q(1:end,:));

figure;
subplot(3,1,1);
plot(t,r); hold on;
subplot(3,1,2);
plot(t,p); hold on;
subplot(3,1,3);
plot(t,y); hold off;


Q = [0 0 0];
B = [1 0 0];
C = [0 1 0];
D = [0 0 1];
E = [0 1 1];
F = [1 0 1];
G = [1 1 0];
H = [1 1 1];
P = [Q;B;F;H;G;C;Q;D;E;H;F;D;E;C;G;B];
P(:,1) = P(:,1) - 0.5;
P(:,2) = (P(:,2) - 0.5).*1.5;
P(:,3) = (P(:,3) - 0.5).*2;
figure;
xlim([-2, 2]);
ylim([-2, 2]);
zlim([-2,2]);
plot3(P(:,1),P(:,2),P(:,3)); hold on;
for i = 1:1:length(t)
    clf('reset');
    P = P*dcm(:,:,i);
    plot3(P(:,1),P(:,2),P(:,3)); hold on; % rotated cube
    xlim([-2, 2]);
    ylim([-2, 2]);
    zlim([-2,2]);
    grid on;
    pause(1);
end
