function [theta,vel,accel] = tree_pivot_ode(info,init,stop,step_ps)
%TREE_PIVOT Models angle, velocity, and acceleration of tree falling, still
%attached at base
%   Detailed explanation goes here
t=linspace(0,stop,stop*step_ps);

[t,y]=ode45(@(t,y) rhs_tree(t,y,info),t,init);
theta=y(:,1);
vel=y(:,2);

%checking if the tree is horizontal and therefore fully fallen over
vel(theta(:)>pi/2)=0;
theta(theta(:)>pi/2)=pi/2;
accel=(info(2).*9.81.*info(1).*sin(theta))./(2.*info(3));
accel(theta(:)==pi/2)=0;
%% Graphing
%{
figure;

subplot(2,2,1)
plot(t,theta,'-')
title('\Theta-cartesian')

ls=zeros(length(theta))+info(1);


pax=polaraxes;
subplot(2,2,2,pax)

polarplot(theta,ls,'.')
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
title(pax, '\Theta-polar')


%vel=sqrt((3*9.81/info(1)).*sin(theta));
subplot(2,2,3)
plot(t(1:length(theta)),accel,'-')
title('Angular acceleration')
subplot(2,2,4)
plot(t(1:length(theta)),vel,'-')
title('Angular velocity')
%}
%%
function dydt = rhs_tree(t,y,info)
    g=9.81;
    l=info(1);
    m=info(2);
    I=info(3);
    
    dydt2 = ((m.*g.*l.*sin(y(1)))./(2.*I));
    dydt1 = y(2);
    dydt = [dydt1;dydt2];
end
end

