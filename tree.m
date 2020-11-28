l=16; %metre, 50ft
m=15000; %kilogram, approx guess
g=9.81;
I=(1/3)*m*(l^2);
t=linspace(0,5,100);
%f = @(x) ((3*g).*sin(x))./(2*l);
f = @(x) ((m.*g.*l.*sin(x))./I);
h=0.05;
figure;
theta_curr=pi/24;
theta=[theta_curr];
subplot(2,2,1)
plot(0,theta,'.')
title('\Theta-cartesian')
for i=1:99
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