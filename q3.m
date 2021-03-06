%% solution q3
clear all 
close all


I_b = [100 1 2; 1 150 3; 2 3 200];
I_d = 1;
ahat_b = [0 1 0].';
c = 0.1;
omega_b_t0 = [0.02 0 0.2].';
q_t0 = [0 0 0 1].';
shat_N = [0 0 1].';
m_N_t0 = 7.76*[sqrt(2)/2 sqrt(2)/2 0].'; 
merr = 0.1;
t_f = 1000;


%% sim
tic
sim('q3_model');
toc

%% plots 4 peck
% angular-velocity components in N vs. time,
omega_N = zeros(length(quat.Time),3);
for i = 1:1:length(quat.Time)
   quat_i = [quat.Data(i,4) quat.Data(i,1:3)];
   omega_N(i,:) = (quat2dcm(quat_i).' *omega.Data(i,:).').';
end
figure; subplot(3,1,1)
plot(quat.Time, (omega_N(:,1))); title('\omega_1^N vs time');
subplot(3,1,2)
plot(quat.Time,  (omega_N(:,2))); title('\omega_2^N vs time');
subplot(3,1,3)
plot(quat.Time,  (omega_N(:,3))); title('\omega_3^N vs  time');
hold off;

% nutation angle vs. time
[v d] = eig(I_b);
e = v(:,3);
ang = zeros(length(omega.Time),1);
for i = 1:1:length(omega.Time)
   hhat = (I_b*(omega.Data(i,:).'))/norm(I_b*(omega.Data(i,:).'));
   ang(i) = acos(dot(e,hhat));
end
figure; plot(omega.Time, rad2deg(ang));
title('nutation angle')


% quaternion vs. time,
figure; subplot(4,1,1)
plot(quat.Time, (quat.Data(:,1))); hold on;
plot(quat.Time, (q_est.Data(:,1))); hold off;
title('q_1 vs time'); legend('true','estimate');
subplot(4,1,2)
plot(quat.Time,  (quat.Data(:,2))); hold on;
plot(quat.Time, (q_est.Data(:,2))); hold off;
title('q_2 vs time');legend('true','estimate');
subplot(4,1,3)
plot(quat.Time,  (quat.Data(:,3))); hold on;
plot(quat.Time, (q_est.Data(:,3))); hold off;
title('q_3 vs  time');legend('true','estimate');
subplot(4,1,4)
plot(quat.Time,  (quat.Data(:,4))); hold on;
plot(quat.Time, (q_est.Data(:,4))); hold off;
title('q_4 vs  time');legend('true','estimate');
hold off;

