function [theta,vel,accel] = tree_pivot(l,m,I,stop)
%TREE_PIVOT Models angle, velocity, and acceleration of tree falling, still
%attached at base
%   Detailed explanation goes here
g=9.81;
t=linspace(0,stop,stop*10);
f = @(x) ((m.*g.*l.*sin(x))./(2.*I));
h=0.1;
figure;
theta_curr=pi/24;
theta=[theta_curr];
subplot(2,2,1)
plot(0,theta,'.')
title('\Theta-cartesian')
for i=1:length(t)-1
    theta_curr=theta_curr+h*f(theta_curr);
    if theta_curr>pi/2
        break
    end
    theta=[theta,theta_curr];
    hold on
    plot(t(i+1),theta(i),'.')
end
ls=zeros(length(theta))+l;

pax=polaraxes;
subplot(2,2,2,pax)

polarplot(theta,ls,'.')
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
title(pax, '\Theta-polar')
%%
alpha=(4*g)/l;
vel=sqrt((3*g/l).*sin(theta));
accel=alpha.*sin(theta);
subplot(2,2,3)
plot(t(1:length(theta)),accel,'.')
title('Angular acceleration')
subplot(2,2,4)
plot(t(1:length(theta)),vel,'.')
title('Angular velocity')
end

