t = sol.x;
t1=ones(length(t));
figure;
polarplot(sol.y(1,:),t1.*0.9,'LineWidth', 2)
hold on
polarplot(sol.y(2,:),t1.*1.8,'LineWidth', 2)
%%
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
    pause(0.1)
end