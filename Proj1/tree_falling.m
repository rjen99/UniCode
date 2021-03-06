l=20; %metre, 50ft
%m=15000; %kilogram, approx guess
density=940;
m=l.*density;
g=9.81;
I=(1/3)*m*(l^2);
info=[l,m,I];

step_ps=200;
init=[pi./24;0];    % starts at small angle, 0 velocity

%% Initial pivoting
[theta,vel,accel]=tree_pivot_ode(info,init,3.25,50); % stops after 2.5s, 50 steps per second

% calculate positions
base=[zeros(length(theta),1),zeros(length(theta),1)];
com=[(l./2).*sin(theta)+base(:,1),(l./2).*cos(theta)];  % com = centre of mass
top=[(l).*sin(theta)+base(:,1),(l).*cos(theta)];
%% Freefalling
t=linspace(0,5,1.*step_ps)';
len = length(t);

[x_v,y_v,phi_v]=freefall(t,theta,vel,l./2);
xc=x_v{1}; vx=x_v{2}; ax=x_v{3};
yc=y_v{1}; vy=y_v{2}; ay=y_v{3};
phi=phi_v{1}; vphi=phi_v{2}; aphi=phi_v{3};


%{
figure;
subplot(3,1,1)
plot(t,vx,'-')
subplot(3,1,2)
plot(t,vy,'-')
subplot(3,1,3)
plot(t,phi,'-')
%}

%calculate positions        b=base, c=centre, t=top
xb = xc - (l./2).*sin(phi);
yb = yc - (l./2).*cos(phi);
xt= xc + (l./2).*sin(phi);
yt = yc + (l./2).*cos(phi);
%% Pivot 2

% finds first point that the base is lower than the ground level (-1) and saves the previous step
stp=find(yb<=-1,1,'first')-1;       
angv = (sqrt(vx(stp).^2 + vy(stp).^2).*cos(phi(stp)-atan(vx(stp)./vy(stp))))./(l./2);
init2 = [phi(stp);angv+vphi(stp)];

% uses the angle the tree was at when it 'hit the ground'
% and the angular velocity + the tangential velocity converted to angular
% velocity
[theta2,vel2,accel2]=tree_pivot_ode(info,init2,5,50);

% calculating positions again
base2=[zeros(length(theta2),1)+xb(stp),zeros(length(theta2),1)+yb(stp)];
top2=[(l).*sin(theta2)+base2(:,1),(l).*cos(theta2)+yb(stp)];

%% Animation

% getframe and 'im' lines are for saving the plot to videos, comment out if
% not needed/wanted. 'im' lines and lines commented .gif are for gif, the
% others are for .avi files and are commented that as well.

fn = 'tree_fall.gif';

figure;

for i=1:length(theta)
    plot([0,0],[-1,0],'-',[-2,20],[-1,-1],'-')
    hold on
    plot([base(i,1),top(i,1)],[base(i,2),top(i,2)],'r-')
    hold off
    axis([-2,30,-2,30])
    axis equal
    
%     if i==1           %.avi
%         M=getframe;
%     else
%         M = [M,getframe];
%     end

    M=getframe;     %.gif
    im = frame2im(M);
    [imind,cm] = rgb2ind(im,256);
    if i ==1
        imwrite(imind,cm,fn,'gif', 'Loopcount', inf, 'DelayTime',1./step_ps);
    else
        imwrite(imind,cm,fn,'gif','WriteMode','append', 'DelayTime',1./step_ps);
    end
    
    pause(1./step_ps);
end
pause;
for i=1:len
    if yb(i) <= -1 || yt(i) <= -1
        i;
        break
    end
    plot([0,0],[-1,0],'-',[-2,20],[-1,-1],'-')
    hold on
    plot([xb(i),xc(i),xt(i)],[yb(i),yc(i),yt(i)],'r-')
    title('Tree in free fall')
    xlabel('x (m)')
    ylabel('y (m)')
    hold off
    axis([-2,30,-2,30])
    axis equal
    
    %M = [M,getframe];      %.avi
    
    M=getframe;             %.gif
    im = frame2im(M);
    [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,fn,'gif','WriteMode','append', 'DelayTime',1./step_ps);
    
    pause;%(1./step_ps);
end
pause;
for i=1:length(theta2)
    plot([0,0],[-1,0],'-',[-2,20],[-1,-1],'-')
    hold on
    plot([base2(i,1),top2(i,1)],[base2(i,2),top2(i,2)],'r-')
    hold off
    axis([-2,30,-2,30])
    axis equal
    
    %M = [M,getframe];      %.avi
    
    M=getframe;             %.gif
    im = frame2im(M);
    [imind,cm] = rgb2ind(im,256);
    imwrite(imind,cm,fn,'gif','WriteMode','append', 'DelayTime',1./step_ps);
    
    pause(1./step_ps);
    if theta2(i)==theta2(i+1)
        break
    end
end
%% save .avi file
%{
myVideo = VideoWriter('tree_fall_3'); %open video file
myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
open(myVideo)
for i=M
    writeVideo(myVideo, i)
end
close(myVideo)
%}
%% Functions
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