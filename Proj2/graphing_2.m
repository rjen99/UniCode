KE = (1./2).*67.*(l./2).*((l./2).^2).*(all_y(4,:).^2);
Ang_Mom = 67.*(l./2).*all_y(4,:);
% plots thetas and theta dots against time
figure;
plot(all_y(1,:),'LineWidth', 2)
hold on
plot(all_y(2,:),'LineWidth', 2)
legend('\theta_1', '\theta_2')
xlabel('Time (s)')
ylabel('Angle (radians)')
title('Angle')
figure;
plot(l,all_y(3,:),'LineWidth', 2)
hold on
plot(l,all_y(4,:),'LineWidth', 2)
%axis([0,20,0,3])
legend('\omega_1', '\omega_2')
xlabel('Neck length (m)')
ylabel('Angular velocity (rad/s) at ~0.6rad')
title('Angular Velocity against Neck Length')

figure;
plot(l,KE,'LineWidth', 2)
title('Kinetic Energy of Upper Neck Segment against Overall Neck Length \newline assuming the angular velocity is constant')
xlabel('Neck Length (m)')
ylabel('Kinetic Energy (J)')