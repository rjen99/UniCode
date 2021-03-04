t = sol.x;
t1=ones(length(t));
% figure;
% for i = 1:18
% polarplot(sol.x(i).*[1,1,1,1],sol.y(:,i),'o','LineWidth', 2)
% hold on
% end

% plots thetas and theta dots against time
figure;
plot(t,sol.y(1,:),'LineWidth', 2)
hold on
plot(t,sol.y(2,:),'LineWidth', 2)

legend('\theta_1', '\theta_2')
figure;
plot(t,sol.y(3,:),'LineWidth', 2)
hold on
plot(t,sol.y(4,:),'LineWidth', 2)
%axis([0,20,0,3])
legend('\omega_1', '\omega_2')
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
    pause(0.1);
end