% these functions (also defined in rhs_ode) are in terms of theta_1 (x) and
% theta_2 (y), and are to simplify the equations of motions, as shown below

% tau = a1(x,y)*x_dd + b1(x,y)*y_dd + c1(x,y)*y_d + d1(x,y);
% tau = a2(x,y)*x_dd + b2(x,y)*y_dd + c2(x,y)*x_d + d2(x,y);

% they dont actually need ran
a1 = @(x,y) (3/4)*m*(l^2) + M*(l^2) + 2*I;     
b1 = @(x,y) 0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I;    
c1 = @(x,y) 0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y);  
d1 = @(x,y) - (5/2)*m*g*l*sin(x) - k*(y-x);     

a2 = @(x,y) 0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I;
b2 = @(x,y) 0.25*m*(l^2) + M*(l^2) + I;
c2 = @(x,y) -0.5*(l^2)*sin(x-y)*(m + M);
d2 = @(x,y) k*(y-x) - (3/2)*m*g*l*sin(y);

%%
x0 = [0,0,0.5,0];

all_y = [];
all_t = [];
l=1.6:0.05:2;
for i = 1:length(l)
    sol = ode45(@(t,x) rhs_ode(t,x,l(i)),t_span,x0);
    t_span = linspace(0,sol.x(end),20);
    %heck = deval(sol,t_span);
    a=find(sol.y(1,:)<0.6);
    y = sol.y(:,a);
    t = sol.x(:,a);
    
    all_y = [all_y,y(:,end)];
    all_t = [all_t,t(:,end)];
end
%{
sol = ode45(@(t,x) rhs_ode(t,x,2),[0,1],x0);
a=find(sol.y(1,:)<0.6);
y = sol.y(:,a);
t = sol.x(:,a);
y(1,end)
t(end)

theta_1 = y(1,:);
theta_2 = y(2,:);
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
%}
%%
function dzdt = rhs_ode(t,z,l)
% Correct values need put in
tau = 1000;
m=120;
M=32;
g=9.81;
I=0.5*m*((l./2)^2);
k=200;

a1 = @(x,y) (3/4)*m*(l^2) + M*(l^2) + 2*I;
b1 = @(x,y) 0.5*m*(l^2)*cos(x-y) + 0.5*M*(l^2)*cos(x-y) + I;
c1 = @(x,y) 0.5*m*(l^2)*sin(x-y) + 0.5*M*(l^2)*sin(x-y);
d1 = @(x,y) - (5/2)*m*g*l*sin(x) - k*(y-x);

a2 = @(x,y) 0.5*m*(l^2)*cos(x-y) +0.5*M*(l^2) + I;
b2 = @(x,y) 0.25*m*(l^2) + M*(l^2) + I;
c2 = @(x,y) -0.5*(l^2)*sin(x-y)*(m + M);
d2 = @(x,y) k*(y-x) - (3/2)*m*g*l*sin(y);

% The two equations of motion were rearranged and x_dd/y_dd substituted to
% get an equation for x_dd/y_dd only in terms of x_d, y_d, x, y
% (x and y representing theta_1 and theta_2)

x_d = z(3);
y_d = z(4);
x_dd = (tau - c1(z(1),z(2))*(z(3)^2) - d2(z(1),z(2)) - (b1(z(1),z(2))./b2(z(1),z(2)))*(tau - c2(z(1),z(2))*(z(3)^2) - d2(z(1),z(2))))./(a1(z(1),z(2))-(a1(z(1),z(2))*b1(z(1),z(2))/b2(z(1),z(2))));
y_dd = (tau - c2(z(1),z(2))*(z(3)^2) - d2(z(1),z(2)) - (a2(z(1),z(2))./a1(z(1),z(2)))*(tau - c1(z(1),z(2))*(z(4)^2) - d1(z(1),z(2))))./(b2(z(1),z(2))-(a1(z(1),z(2))*b1(z(1),z(2))/a1(z(1),z(2))));
dzdt = [x_d; y_d; x_dd; y_dd];
end

