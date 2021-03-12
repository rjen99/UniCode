%t = sol.x;
t1=ones(length(t));
%y=sol.y;
% figure;
% for i = 1:18
% polarplot(sol.x(i).*[1,1,1,1],sol.y(:,i),'o','LineWidth', 2)
% hold on
% end
KE = (1./2).*67.*(1.8./2).*((1.8./2).^2).*(y(4,:).^2);
% plots thetas and theta dots against time
figure;
plot(t,y(1,:),'LineWidth', 2)
hold on
plot(t,y(2,:),'LineWidth', 2)
legend('\theta_1', '\theta_2')
xlabel('Time (s)')
ylabel('Angle (radians)')
title('Angle')
figure;
plot(t,y(3,:),'LineWidth', 2)
hold on
plot(t,y(4,:),'LineWidth', 2)
%axis([0,20,0,3])
legend('\omega_1', '\omega_2')
xlabel('Time (s)')
ylabel('Angular velocity (radians/s)')
title('Angular Velocity')

figure;
plot(t,KE,'LineWidth', 2)
title('Kinetic Energy of upper neck segment')
xlabel('Time (s)')
ylabel('Kinetic Energy (J)')
%% Demonstrates the motion (should look like a double pendulum in action)
% in theory this should play an animation
theta_1 = sol.y(1,:);
theta_2 = sol.y(2,:);
base_1 = zeros(length(theta_1));
base_2 = ones(length(theta_1))*0.9;
end_2 = ones(length(theta_1))*1.8;
figure;

for i=1:length(theta_1)
    polarplot([theta_1(i),theta_1(i),theta_2(i)],[base_1(i),base_2(i),end_2(i)],'-')
    %axis([-9,9,0,17])
    pax=gca;
    pax.ThetaDir = 'clockwise';
    pax.ThetaZeroLocation = 'top';
    M(i) = getframe;
    pause(0.1);
end
%%
myVideo = VideoWriter('giraffe_neck','MPEG-4'); %open video file
myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
open(myVideo)
for i=M
    writeVideo(myVideo, i)
end
close(myVideo)