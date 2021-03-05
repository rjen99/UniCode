%% 2D
fun_theta_dd = -1;
fun_theta_d = @(t) 5 - t;
fun_theta = @(t) 1 + 1.*t - 0.5.*(t.^2);

t = 0:0.01:1;
l = 1.8;
theta = fun_theta(t');

base = zeros(length(t),2);
head = [ones(length(t),1).*l.*sin(theta),ones(length(t),1).*l.*cos(theta)];

figure;
for i=1:length(t)
    plot([base(i,1),head(i,1)],[base(i,2),head(i,2)],'-')
    
    axis equal
    axis([-2,2,-2,2])
    pause(0.01);
end

%% 3D, plots angle, velocity, and kinetic energy graphs
fun_theta_dd = -1;
fun_theta_d = @(t) 3 - 6.*t;
fun_theta = @(t) pi./6 + 3.*t - 3*(t.^2);

fun_phi_dd = @(t) 8.*t;
fun_phi_d = @(t) 4.*(t.^2);
fun_phi = @(t) (4./3).*(t.^3);

t = 0:0.01:1;
l = 1.8;
I = 57.82;

theta = fun_theta(t');
theta_d = fun_theta_d(t');
phi = fun_phi(t');
phi_d = fun_phi_d(t');

KE = 0.5*I*theta_d + 0.5*I*phi_d;

% plot phi & theta to check values against video
figure;
plot(theta)
hold on
plot(phi)
plot([0;100],[pi./2;pi./2])
legend('\theta','\phi', '\pi/2')
title('angle')
figure;
plot(theta_d)
hold on
plot(phi_d)
legend('\theta_d','\phi_d')
title('velocity')
figure;
plot(KE)
title('kinetic energy')
%pause;
%% 3D, plots an animation of the movement from 3 views
L_1 = l.*cos(theta);
l_1 = l.*sin(theta);
L_2 = l_1.*sin(phi);
L_3 = l_1.*cos(phi);

base = zeros(length(t),3);
head = ones(length(t),3);
head(:,1) = head(:,1).*L_3;
head(:,2) = head(:,2).*L_2;
head(:,3) = head(:,3).*L_1;

% plot motion in three different views
figure;
for i=1:length(t)
    subplot(1,3,1)
    plot3([base(i,1),head(i,1)],[base(i,2),head(i,2)],[base(i,3),head(i,3)],'-')
    axis equal
    axis([-2,2,-2,2,-2,2])
    
    subplot(1,3,2)
    plot3([base(i,1),head(i,1)],[base(i,2),head(i,2)],[base(i,3),head(i,3)],'-')
    axis equal
    axis([-2,2,-2,2,-2,2])
    view(90,0)
    title('horizontal')
    
    subplot(1,3,3)
    plot3([base(i,1),head(i,1)],[base(i,2),head(i,2)],[base(i,3),head(i,3)],'-')
    axis equal
    axis([-2,2,-2,2,-2,2])
    view(0,90)
    title('top down')
    
    pause(0.01);
end