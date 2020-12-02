l=16; %metre, 50ft
m=15000; %kilogram, approx guess
I=(1/3)*m*(l^2);
g=9.81;
t=linspace(0,2,200)';
h=0.01;
[theta_vec,vel_vec,accel_vec]=tree_pivot(m,l,I,1);
theta=theta_vec(end);vel=vel_vec(end);accel=accel_vec(end);
x_base=-(l/2).*sin(theta);
y_com=(l/2).*cos(theta);
base=[x_base,0];
com=[0,y_com];
top=[-x_base,2*y_com];
%%
a_init=[0,-g];      % acceleration is constant
v_init=[vel.*cos(theta).*(l/2),-vel.*sin(theta).*(l/2)];
s_init=com;

v=[v_init(1)+(a_init(1).*t),v_init(2)+(a_init(2).*t)];
s=[(v_init(1).*t)+(0.5.*a_init(1).*(t.^2))+s_init(1),(v_init(2).*t)+(0.5.*a_init(2).*(t.^2))+s_init(2)];
s(s(:,2)<0,2)=0;
figure;
%plot(v,'.')
hold on;
plot(s(:,1),s(:,2),'.')
axis([-5,5,0,10])

%%

sb_x=sqrt((l./2).^2 - s(:,2).^2);
sb=[-sb_x+s(:,1),zeros(length(sb_x),1)];
st=[sb_x,s(:,2).*2];



base=[zeros(length(theta_vec),1)-sb_x(1)+s(1,1),zeros(length(theta_vec),1)];
top=[l.*sin(theta_vec)+base(:,1),l.*cos(theta_vec)];

figure;

for i=1:length(theta_vec)
    plot([base(i,1),top(i,1)],[base(i,2),top(i,2)],'-')
    axis([-9,9,0,17])
    M(i) = getframe;
    pause(0.1);
    i
end

for i=1:length(s)
    plot([sb(i,1),s(i,1),st(i,1)],[sb(i,2),s(i,2),st(i,2)],'-')
    axis([-9,9,0,17])
    M(length(theta_vec)+i) = getframe;
    pause(0.01);
    if s(i,2)==0
        break
    end
    %hold on
end
%%
myVideo = VideoWriter('tree2'); %open video file
myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
open(myVideo)
for i=M
    writeVideo(myVideo, i)
end
close(myVideo)

