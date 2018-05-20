%% Question 1
close all;clc;
clear all;

I_b = [100 1 2; 1 150 3; 2 3 200];
p_b = [0 0 1].';
h1_hat = [-sqrt(2/3) -sqrt(2/9) 1/3].';
h2_hat = [sqrt(2/3) -sqrt(2/9) 1/3].';
h3_hat = [0 sqrt(8/9) 1/3].';
h4_hat = [0 0 -1].';
h1_t0 = zeros(3,1);
h2_t0 = zeros(3,1);
h3_t0 = zeros(3,1);
h4_t0 = zeros(3,1);
A = [h1_hat h2_hat h3_hat h4_hat];
pinvA = pinv(A);
omega_B_N_t0=zeros(3,1);
q_t0 = [0 0 0 1].';
q_f = dcm2quat([1 0 0; 0 -1 0; 0 0 -1]);
q_f = q_f ./ quatnorm(q_f);
q_f = [q_f(2:4) q_f(1)].';
omega_B_N_tf = zeros(3,1);
p_N = [0 0 -1].';

% [c,h] = eig(I_b);
% e = c(:,1) - (c(:,1).'*p_b).*p_b;
% h_d = crs(e)*crs(e)*I_b*e*0.00051;
% norm(h_d)
t_f = 5000;

Kp= -.01;     
Kd= -4;    

tic
sim('q1_model2');
toc


%% plots 4 peck
% angular-velocity components vs. time,
figure; subplot(3,1,1)
plot(omega.Time, (omega.Data(:,1))); title('\omega_1 vs time');
subplot(3,1,2)
plot(omega.Time,  (omega.Data(:,2))); title('\omega_2 vs time');
subplot(3,1,3)
plot(omega.Time,  (omega.Data(:,3))); title('\omega_3 vs  time');
hold off;

% angles and shit
p_N_t = zeros(length(quat.Time),3);
for i = 1:1:length(quat.Time)
   quat_i = [quat.Data(i,4) quat.Data(i,1:3)];
   p_N_t(i,:) = (quat2dcm(quat_i).' *p_b).';
end
figure; subplot(3,1,1)
plot(quat.Time, p_N_t(:,1)); title('p_n_1 vs time');
subplot(3,1,2)
plot(quat.Time, p_N_t(:,2)); title('p_n_2 vs time');
subplot(3,1,3)
plot(quat.Time, p_N_t(:,3)); title('p_n_3 vs  time');
hold off;

% total momentum components
figure; subplot(3,1,1)
plot(h_total.Time, (h_total.Data(:,1))); title('h_1_{total} vs time');
subplot(3,1,2)
plot(h_total.Time, (h_total.Data(:,2))); title('h_2_{total} vs time');
subplot(3,1,3)
plot(h_total.Time, (h_total.Data(:,3))); title('h_3_{total} vs  time');
hold off;

% individual scalar wheel moms
figure;
plot(h_i.Time, h_i.Data(:,1)); hold on;
plot(h_i.Time, h_i.Data(:,2)); hold on;
plot(h_i.Time, h_i.Data(:,3)); hold on;
plot(h_i.Time, h_i.Data(:,4));
title('Wheel momentum vs Time');
xlabel('momentum Nms'); ylabel('time seconds')
legend('w1','w2','w3', 'w4')
hold off;


%% my own shit
% quaternion vs. time,
figure; subplot(4,1,1)
plot(quat.Time, (quat.Data(:,1))); title('q_1 vs time');
subplot(4,1,2)
plot(quat.Time,  (quat.Data(:,2))); title('q_2 vs time');
subplot(4,1,3)
plot(quat.Time,  (quat.Data(:,3))); title('q_3 vs  time');
subplot(4,1,4)
plot(quat.Time,  (quat.Data(:,4))); title('q_4 vs  time');
hold off;

% total momentum components
figure; subplot(3,1,1)
r1 = zeros(length(quat.Time),1);
r2 = r1;
r3 = r1;
for i=1:1:length(quat.Time)
   [r1(i),r2(i),r3(i)] = quat2angle([quat.Data(i,4) quat.Data(i,1:3)]); 
end
% [r1 r2 r3] = quat2angle(quat.Data(:,1:4));
plot(quat.Time, rad2deg(r1)); title('phi vs time');
subplot(3,1,2)
plot(quat.Time, rad2deg(r2)); title('theta vs time');
subplot(3,1,3)
plot(quat.Time, rad2deg(r3)); title('psi vs  time');
hold off;

% 
% % NEED: - individual wheel momentum scalars vs. time.
% % NEED: - N components vs. time
% satanim


