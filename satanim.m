% function satanim(t,angles)


dcm = quat2dcm([quat.Data(:,4) quat.Data(:,1:3)]);
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
P_i=P;
figure;
xlim([-4, 4]);
ylim([-4, 4]);
zlim([-4,4]);
plot3(P(:,1),P(:,2),P(:,3)); hold on;
scalr = 100;
for i = 1:1:length(quat.Time)/scalr
    clf('reset');
    P = P_i*dcm(:,:,i*scalr);
    plot3(P(:,1),P(:,2),P(:,3)); hold on; % rotated cube
    xlim([-4, 4]);
    ylim([-4, 4]);
    zlim([-4,4]);
    grid on;
    pause(.0000000001);
end



% end