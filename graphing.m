
height=linspace(15,45,60); %metre, 50ft
dens=linspace(900,1000,101); %kilogram, approx guess
stmp=[0.5,1,1.5,2];
breaking=linspace(0.25,4,50);
g=9.81;

s=1;
l=20;
stop=2.5;
density=940;

step_ps=200;
init=[pi./24 ;0]; % starts at small angle, 0 velocity

P=[];
T=[];
time=[];
V=[];
B=[];

for stop=breaking
    m=l.*density;
    I=(1/3)*m*(l^2);
    info=[l,m,I];
    
    %% Initial pivoting
    [theta,vel,accel]=tree_pivot_ode(info,init,stop,50); % stops after 2.5s, 50 steps per second

    % calculate positions
    base=[zeros(length(theta),1),zeros(length(theta),1)];
    com=[(l./2).*sin(theta)+base(:,1),(l./2).*cos(theta)];  % com = centre of mass
    top=[(l).*sin(theta)+base(:,1),(l).*cos(theta)];
    %% Freefalling
    t=linspace(0,10,1.*step_ps)';
    len = length(t);

    [x_v,y_v,phi_v]=freefall(t,theta,vel,l./2);
    xc=x_v{1}; vx=x_v{2}; ax=x_v{3};
    yc=y_v{1}; vy=y_v{2}; ay=y_v{3};
    phi=phi_v{1}; vphi=phi_v{2}; aphi=phi_v{3};

    %calculate positions        b=base, c=centre, t=top
    xb = xc - (l./2).*sin(phi);
    yb = yc - (l./2).*cos(phi);
    xt= xc + (l./2).*sin(phi);
    yt = yc + (l./2).*cos(phi);
    %% Pivot 2

    % finds first point that the base is lower than the ground level (-1) and saves the previous step
    stp=find(yb<=-s,1,'first')-1;       
    angv = (sqrt(vx(stp).^2 + vy(stp).^2).*cos(phi(stp)-atan(vx(stp)./vy(stp))))./(l./2);
    init2 = [phi(stp);angv+vphi(stp)];
    
    % uses the angle the tree was at when it 'hit the ground'
    % and the angular velocity + the tangential velocity converted to angular
    % velocity
    [theta2,vel2,accel2]=tree_pivot_ode(info,init2,10,50);

    % calculating positions again
    base2=[zeros(length(theta2),1)+xb(stp),zeros(length(theta2),1)+yb(stp)];
    top2=[(l).*sin(theta2)+base2(:,1),(l).*cos(theta2)+yb(stp)];

    %% Producing single graphs for comparison
    last=find(vel2==0,1,'first')-1;
    if last == 0
        P=[P,m.*(init2(2).*(l./2))];
        T=[T,xt(stp)];
        B=[B,xb(stp)];
        time=[time,stop+(stp./step_ps)+(last./step_ps)];
        V=[V,(init2(2).*(l./2))];
    else
        P=[P,m.*(vel2(last).*(l./2))];
        T=[T,top2(last,1)];
        B=[B,base2(last,1)];
        time=[time,stop+(stp./step_ps)+(last./step_ps)];
        V=[V,(vel2(last).*(l./2))];
    end
end
%%
figure;plot(breaking,B,'-')
title('Position of base against height of tree stump')
xlabel('Height of tree stump (m)')
ylabel('Position of base (m)')
%%
figure;
subplot(2,2,1);plot(breaking,P,'-')
title('Time of breaking against final momentum')
xlabel('Time of breaking (s)')
ylabel('Momentum (kg m/s)')
subplot(2,2,2);plot(breaking,T,'-')
title('Time of breaking against final position of tree top')
xlabel('Time of breaking (s)')
ylabel('Position of tree top from stump (m)')
subplot(2,2,3);plot(breaking,V,'-')
title('Time of breaking against final velocity')
xlabel('Time of breaking (s)')
ylabel('Velocity (m/s)')
subplot(2,2,4);plot(breaking,time,'-')
title('Time of breaking against time taken to fall')
xlabel('Time of breaking (s)')
ylabel('Time (s)')
%% Function
function [x_values,y_values,theta_values] = freefall(t,theta,vel,l)
    g=9.81;
    
    len=length(t);

    thetas=theta(end);
    thetads=vel(end);
    thetadds=0;

    xs=(l).*sin(thetas);
    xds=xs.*thetads;
    xdds=0;

    ys=(l).*cos(thetas);
    yds=-ys.*thetads;
    ydds=-g;

    xdd=zeros(len,1)+xdds;
    xd=xdd.*t+xds;
    x = (0.5).*xdd.*(t.^2) + xds.*t + xs;

    ydd=zeros(len,1)+ydds;
    yd=ydd.*t+yds;
    y = (0.5).*ydd.*(t.^2) + yds.*t + ys;

    thetadd=zeros(len,1)+thetadds;
    thetad=thetadd.*t+thetads;
    theta = (0.5).*thetadd.*(t.^2) + thetads.*t + thetas;
    
    x_values = {x,xd,xdd};
    y_values = {y,yd,ydd};
    theta_values = {theta,thetad,thetadd};
end